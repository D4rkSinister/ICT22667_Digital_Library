from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.models import User
from django.db.models import Q
from django.contrib import messages
from django.utils import timezone
from django.http import JsonResponse
from django.db import transaction
from datetime import timedelta
from .models import Book, Category, Author, Borrowing, Favorite
from .forms import BookForm, CategoryForm, AuthorForm

# Create your views here.

def user_login(request):
    """User login view"""
    if request.user.is_authenticated:
        return redirect('library:index')
    
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        
        user = authenticate(request, username=username, password=password)
        
        if user is not None:
            login(request, user)
            messages.success(request, f'Welcome back, {user.first_name or user.username}!')
            return redirect('library:index')
        else:
            messages.error(request, 'Invalid username or password.')
    
    return render(request, 'library/login.html')


def user_logout(request):
    """User logout view"""
    logout(request)
    messages.success(request, 'You have been logged out successfully.')
    return redirect('library:index')


@login_required(login_url='library:login')
def user_profile(request):
    """User profile view"""
    context = {
        'user': request.user,
    }
    return render(request, 'library/profile.html', context)


@login_required(login_url='library:login')
@login_required(login_url='library:login')
def my_borrowings(request):
    """View all borrowings for current user"""
    # Get all borrowings for the current user
    borrowings = Borrowing.objects.filter(student=request.user).order_by('-borrow_date')
    
    # Separate active and returned borrowings
    active_borrowings = borrowings.filter(is_returned=False)
    returned_borrowings = borrowings.filter(is_returned=True)
    
    # Calculate penalties for active borrowings
    for borrowing in active_borrowings:
        days_borrowed = (timezone.now() - borrowing.borrow_date).days
        penalty = 0
        if days_borrowed > 7:
            penalty = (days_borrowed - 7) * 5
        borrowing.days_borrowed = days_borrowed
        borrowing.penalty = penalty
        borrowing.is_overdue = days_borrowed > 7
    
    for borrowing in returned_borrowings:
        days_borrowed = (borrowing.return_date - borrowing.borrow_date).days
        borrowing.days_borrowed = days_borrowed
    
    context = {
        'active_borrowings': active_borrowings,
        'returned_borrowings': returned_borrowings,
    }
    return render(request, 'library/my_borrowings.html', context)


def index(request):
    """Home page view"""
    latest_books = Book.objects.filter(is_available=True).order_by('-created_at')[:8]
    total_books = Book.objects.count()
    total_authors = Author.objects.count()
    total_categories = Category.objects.count()
    
    context = {
        'latest_books': latest_books,
        'total_books': total_books,
        'total_authors': total_authors,
        'total_categories': total_categories,
    }
    
    return render(request, 'library/index.html', context)


def browse(request):
    """Browse books view with filtering and search"""
    books = Book.objects.all()
    categories = Category.objects.all()
    authors = Author.objects.all()
    
    # Search functionality
    search_query = request.GET.get('search', '')
    if search_query:
        books = books.filter(
            Q(title__icontains=search_query) |
            Q(description__icontains=search_query) |
            Q(authors__first_name__icontains=search_query) |
            Q(authors__last_name__icontains=search_query) |
            Q(isbn__icontains=search_query) |
            Q(serial_number__icontains=search_query)
        ).distinct()
    
    # Category filter
    category_id = request.GET.get('category', '')
    selected_category = None
    selected_category_name = None
    if category_id:
        selected_category = category_id
        try:
            selected_category_obj = Category.objects.get(id=category_id)
            selected_category_name = selected_category_obj.name
            books = books.filter(category__id=category_id)
        except Category.DoesNotExist:
            pass
    
    # Availability filter
    availability = request.GET.get('availability', '')
    if availability == 'available':
        books = books.filter(is_available=True)
    elif availability == 'unavailable':
        books = books.filter(is_available=False)
    
    # Sorting / Favorites filter
    sort = request.GET.get('sort', '-created_at')
    if sort == 'favorites':
        if request.user.is_authenticated:
            favorite_book_ids = Favorite.objects.filter(user=request.user).values_list('book_id', flat=True)
            books = books.filter(id__in=favorite_book_ids).order_by('-created_at')
        else:
            books = books.none()
    else:
        books = books.order_by(sort)
    
    # Check if any filters are applied
    has_filters = bool(search_query or category_id or availability or sort == 'favorites')
    
    # Get user's favorite books for display
    user_favorite_ids = []
    if request.user.is_authenticated:
        user_favorite_ids = list(Favorite.objects.filter(user=request.user).values_list('book_id', flat=True))
    
    context = {
        'books': books,
        'categories': categories,
        'authors': authors,
        'search_query': search_query,
        'selected_category': selected_category,
        'selected_category_name': selected_category_name,
        'availability': availability,
        'sort': sort,
        'has_filters': has_filters,
        'user_favorite_ids': user_favorite_ids,
    }
    
    return render(request, 'library/browse.html', context)


def is_superuser(user):
    """Check if user is a superuser"""
    return user.is_superuser


def borrow_tracking(request):
    """Borrow tracking view for superusers"""
    # Check if user is superuser
    if not request.user.is_superuser:
        messages.error(request, 'You do not have permission to access this page.')
        return redirect('library:index')
    
    # Get all users (students)
    users = User.objects.filter(is_superuser=False).order_by('username')
    
    student_data = []
    
    for user in users:
        # Get active borrowing (not returned)
        active_borrowing = Borrowing.objects.filter(
            student=user,
            is_returned=False
        ).first()
        
        if active_borrowing:
            # Calculate days borrowed
            days_borrowed = (timezone.now() - active_borrowing.borrow_date).days
            
            # Calculate penalty (5 baht per day after 7 days)
            penalty = 0
            if days_borrowed > 7:
                penalty = (days_borrowed - 7) * 5
            
            status = 'Borrowing'
        else:
            days_borrowed = 0
            penalty = 0
            status = 'None'
        
        student_data.append({
            'user': user,
            'status': status,
            'days_borrowed': days_borrowed,
            'penalty': penalty,
            'active_borrowing': active_borrowing,
        })
    
    context = {
        'student_data': student_data,
    }
    
    return render(request, 'library/borrow_tracking.html', context)


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def member_list(request):
    """Member list view for superusers to manage library members"""
    # Get all non-superuser members (students)
    members = User.objects.filter(is_superuser=False).order_by('username')
    
    # Search functionality
    search_query = request.GET.get('search', '')
    if search_query:
        members = members.filter(
            Q(username__icontains=search_query) |
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query) |
            Q(email__icontains=search_query)
        )
    
    # Sort functionality
    sort_by = request.GET.get('sort', 'username')
    members = members.order_by(sort_by)
    
    # Calculate member statistics
    total_members = User.objects.filter(is_superuser=False).count()
    active_borrowers = Borrowing.objects.filter(is_returned=False).values('student').distinct().count()
    total_penalties = 0
    
    for user in User.objects.filter(is_superuser=False):
        active_borrowing = Borrowing.objects.filter(
            student=user,
            is_returned=False
        ).first()
        
        if active_borrowing:
            days_borrowed = (timezone.now() - active_borrowing.borrow_date).days
            if days_borrowed > 7:
                total_penalties += (days_borrowed - 7) * 5
    
    context = {
        'members': members,
        'search_query': search_query,
        'sort_by': sort_by,
        'total_members': total_members,
        'active_borrowers': active_borrowers,
        'total_penalties': total_penalties,
    }
    
    return render(request, 'library/member_list.html', context)


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def create_member(request):
    """Create a new member (superuser only)"""
    if request.method == 'POST':
        import json
        try:
            data = json.loads(request.body)
            username = data.get('username', '').strip()
            first_name = data.get('first_name', '').strip()
            last_name = data.get('last_name', '').strip()
            email = data.get('email', '').strip()
            password = data.get('password', '').strip()
            
            # Validation
            if not username or not password:
                return JsonResponse({
                    'success': False,
                    'message': 'Student ID and password are required.'
                })
            
            if User.objects.filter(username=username).exists():
                return JsonResponse({
                    'success': False,
                    'message': f'Student ID "{username}" already exists.'
                })
            
            if email and User.objects.filter(email=email).exists():
                return JsonResponse({
                    'success': False,
                    'message': f'Email "{email}" is already registered.'
                })
            
            # Create user
            user = User.objects.create_user(
                username=username,
                password=password,
                first_name=first_name,
                last_name=last_name,
                email=email
            )
            
            return JsonResponse({
                'success': True,
                'message': f'Member "{username}" has been created successfully!'
            })
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False,
                'message': 'Invalid JSON data.'
            })
        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': f'Error creating member: {str(e)}'
            })
    else:
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method.'
        })


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def delete_member(request, member_id):
    """Delete a member (superuser only)"""
    if request.method != 'POST':
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method. Only POST is allowed.'
        })
    
    try:
        member = User.objects.get(id=member_id)
        
        # Prevent deletion of superusers
        if member.is_superuser:
            return JsonResponse({
                'success': False,
                'message': 'Cannot delete admin users.'
            })
        
        member_name = f"{member.get_full_name()} ({member.username})"
        member.delete()
        return JsonResponse({
            'success': True,
            'message': f'Member {member_name} has been deleted successfully!'
        })
    except User.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Member not found.'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error deleting member: {str(e)}'
        })


@login_required(login_url='library:login')
@transaction.atomic
def borrow_book(request, book_id):
    """Borrow a book (authenticated users only)"""
    if request.method != 'POST':
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method.'
        })
    
    try:
        # Get fresh book object from database
        book = Book.objects.select_for_update().get(id=book_id)
        
        # Check if user already has an active borrowing of this book
        existing_borrow = Borrowing.objects.filter(
            student=request.user,
            book=book,
            is_returned=False
        ).exists()
        
        if existing_borrow:
            return JsonResponse({
                'success': False,
                'message': 'You already have this book checked out.'
            })
        
        # Check if ANY user has an active borrowing of this book
        any_active_borrow = Borrowing.objects.filter(
            book=book,
            is_returned=False
        ).exists()
        
        if any_active_borrow:
            return JsonResponse({
                'success': False,
                'message': 'This book is currently not available.'
            })
        
        # Create borrowing record
        due_date = timezone.now() + timedelta(days=7)
        borrowing = Borrowing.objects.create(
            student=request.user,
            book=book,
            due_date=due_date,
            is_returned=False
        )
        
        # Mark book as unavailable
        book.is_available = False
        book.save()
        
        return JsonResponse({
            'success': True,
            'message': f'You have successfully borrowed "{book.title}". Due date: {due_date.strftime("%d %b %Y")}'
        })
    except Book.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Book not found.'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error: {str(e)}'
        })


@login_required(login_url='library:login')
def submit_review(request):
    """Submit a review for a book (authenticated users only)"""
    if request.method != 'POST':
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method.'
        })
    
    try:
        import json
        data = json.loads(request.body)
        
        book_id = data.get('book_id')
        rating = data.get('rating')
        comment = data.get('comment', '').strip()
        
        if not book_id or not rating:
            return JsonResponse({
                'success': False,
                'message': 'Book ID and rating are required.'
            })
        
        try:
            rating = int(rating)
            if rating < 1 or rating > 5:
                return JsonResponse({
                    'success': False,
                    'message': 'Rating must be between 1 and 5.'
                })
        except ValueError:
            return JsonResponse({
                'success': False,
                'message': 'Invalid rating value.'
            })
        
        book = Book.objects.get(id=book_id)
        
        # Check if user already reviewed this book
        from .models import Review
        review, created = Review.objects.update_or_create(
            book=book,
            student=request.user,
            defaults={
                'rating': rating,
                'comment': comment
            }
        )
        
        if created:
            message = 'Your review has been submitted successfully!'
        else:
            message = 'Your review has been updated successfully!'
        
        return JsonResponse({
            'success': True,
            'message': message
        })
    
    except Book.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Book not found.'
        })
    except json.JSONDecodeError:
        return JsonResponse({
            'success': False,
            'message': 'Invalid JSON data.'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error: {str(e)}'
        })


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def print_penalty_receipt(request, borrowing_id):
    """Print penalty receipt for a student (superuser only)"""
    try:
        borrowing = Borrowing.objects.get(id=borrowing_id, is_returned=False)
        
        # Calculate penalty
        days_borrowed = (timezone.now() - borrowing.borrow_date).days
        penalty = 0
        if days_borrowed > 7:
            penalty = (days_borrowed - 7) * 5
        
        context = {
            'borrowing': borrowing,
            'days_borrowed': days_borrowed,
            'penalty': penalty,
            'current_date': timezone.now(),
        }
        
        return render(request, 'library/penalty_receipt.html', context)
    except Borrowing.DoesNotExist:
        messages.error(request, 'Borrowing record not found.')
        return redirect('library:borrow_tracking')


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def mark_book_returned(request, borrowing_id):
    """Mark a book as returned (superuser only)"""
    try:
        borrowing = Borrowing.objects.get(id=borrowing_id, is_returned=False)
        borrowing.is_returned = True
        borrowing.return_date = timezone.now()
        borrowing.save()
        
        # Mark book as available again
        book = borrowing.book
        book.is_available = True
        book.save()
        
        messages.success(request, f'Book "{borrowing.book.title}" has been marked as returned.')
        return redirect('library:borrow_tracking')
    except Borrowing.DoesNotExist:
        messages.error(request, 'Borrowing record not found.')
        return redirect('library:borrow_tracking')
    except Exception as e:
        messages.error(request, f'Error: {str(e)}')
        return redirect('library:borrow_tracking')


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def add_book(request):
    """Add a new book view (superuser only)"""
    if request.method == 'POST':
        # Get the comma-separated author IDs from the hidden field
        author_ids_str = request.POST.get('authors', '')
        
        # Convert to list of integers if not empty
        if author_ids_str:
            author_ids = [int(id) for id in author_ids_str.split(',') if id.strip()]
        else:
            author_ids = []
        
        # Create a copy of POST data and modify the authors field
        post_data = request.POST.copy()
        post_data.setlist('authors', author_ids)
        
        form = BookForm(post_data, request.FILES)
        if form.is_valid():
            book = form.save(commit=False)
            # Generate serial number
            book.serial_number = book.generate_serial_number()
            book.save()
            form.save_m2m()  # Save the many-to-many relationship
            messages.success(request, f'Book "{book.title}" has been added successfully! Serial Number: {book.serial_number}')
            return redirect('library:browse')
        else:
            messages.error(request, 'Error adding the book. Please check the form.')
    else:
        form = BookForm()
    
    context = {
        'form': form,
        'title': 'Add New Book'
    }
    return render(request, 'library/add_book.html', context)


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def add_category(request):
    """Add a new category view (superuser only)"""
    if request.method == 'POST':
        form = CategoryForm(request.POST)
        if form.is_valid():
            category = form.save()
            messages.success(request, f'Category "{category.name}" has been added successfully!')
            return redirect('library:browse')
        else:
            messages.error(request, 'Error adding the category. Please check the form.')
    else:
        form = CategoryForm()
    
    context = {
        'form': form,
        'title': 'Add New Category'
    }
    return render(request, 'library/add_category.html', context)


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def add_author(request):
    """Add a new author view (superuser only)"""
    if request.method == 'POST':
        form = AuthorForm(request.POST)
        if form.is_valid():
            author = form.save()
            messages.success(request, f'Author "{author.first_name} {author.last_name}" has been added successfully!')
            return redirect('library:browse')
        else:
            messages.error(request, 'Error adding the author. Please check the form.')
    else:
        form = AuthorForm()
    
    context = {
        'form': form,
        'title': 'Add New Author'
    }
    return render(request, 'library/add_author.html', context)


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def delete_book(request, book_id):
    """Delete a book (superuser only)"""
    if request.method != 'POST':
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method. Only POST is allowed.'
        })
    
    try:
        book = Book.objects.get(id=book_id)
        book_title = book.title  # Save title before deleting
        book.delete()
        return JsonResponse({
            'success': True,
            'message': f'Book "{book_title}" has been deleted successfully!'
        })
    except Book.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Book not found.'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error deleting book: {str(e)}'
        })


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def delete_category(request, category_id):
    """Delete a category (superuser only)"""
    if request.method != 'POST':
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method. Only POST is allowed.'
        })
    
    try:
        category = Category.objects.get(id=category_id)
        category_name = category.name  # Save name before deleting
        category.delete()
        return JsonResponse({
            'success': True,
            'message': f'Category "{category_name}" has been deleted successfully!'
        })
    except Category.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Category not found.'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error deleting category: {str(e)}'
        })


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def delete_author(request, author_id):
    """Delete an author (superuser only)"""
    if request.method != 'POST':
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method. Only POST is allowed.'
        })
    
    try:
        author = Author.objects.get(id=author_id)
        author_name = f"{author.first_name} {author.last_name}"  # Save name before deleting
        author.delete()
        return JsonResponse({
            'success': True,
            'message': f'Author "{author_name}" has been deleted successfully!'
        })
    except Author.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Author not found.'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error deleting author: {str(e)}'
        })


@login_required(login_url='library:login')
@user_passes_test(is_superuser, login_url='library:index')
def create_author_api(request):
    """API endpoint to create a new author (superuser only)"""
    if request.method == 'POST':
        import json
        try:
            data = json.loads(request.body)
            first_name = data.get('first_name', '').strip()
            last_name = data.get('last_name', '').strip()
            bio = data.get('bio', '').strip()
            
            if not first_name or not last_name:
                return JsonResponse({
                    'success': False,
                    'message': 'First name and last name are required.'
                })
            
            # Create the author
            author = Author.objects.create(
                first_name=first_name,
                last_name=last_name,
                bio=bio
            )
            
            return JsonResponse({
                'success': True,
                'message': f'Author "{author.first_name} {author.last_name}" created successfully!',
                'author_id': author.id,
                'author_name': f'{author.first_name} {author.last_name}'
            })
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False,
                'message': 'Invalid JSON data.'
            })
        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': f'Error: {str(e)}'
            })
    
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method.'
    })
    """API endpoint to create a new author (superuser only)"""
    if request.method == 'POST':
        import json
        try:
            data = json.loads(request.body)
            first_name = data.get('first_name', '').strip()
            last_name = data.get('last_name', '').strip()
            bio = data.get('bio', '').strip()
            
            if not first_name or not last_name:
                return JsonResponse({
                    'success': False,
                    'message': 'First name and last name are required.'
                })
            
            # Create the author
            author = Author.objects.create(
                first_name=first_name,
                last_name=last_name,
                bio=bio
            )
            
            return JsonResponse({
                'success': True,
                'message': f'Author "{author.first_name} {author.last_name}" created successfully!',
                'author_id': author.id,
                'author_name': f'{author.first_name} {author.last_name}'
            })
        except json.JSONDecodeError:
            return JsonResponse({
                'success': False,
                'message': 'Invalid JSON data.'
            })
        except Exception as e:
            return JsonResponse({
                'success': False,
                'message': f'Error: {str(e)}'
            })
    
    return JsonResponse({
        'success': False,
        'message': 'Invalid request method.'
    })





@login_required(login_url='library:login')
def toggle_favorite(request, book_id):
    """Toggle favorite status for a book (works for both admin and user)"""
    if request.method != 'POST':
        return JsonResponse({
            'success': False,
            'message': 'Invalid request method.'
        })
    
    try:
        book = Book.objects.get(id=book_id)
        
        # Check if already favorited
        favorite = Favorite.objects.filter(user=request.user, book=book).first()
        
        if favorite:
            # Remove from favorites
            favorite.delete()
            is_favorited = False
            message = f'Removed "{book.title}" from favorites'
        else:
            # Add to favorites
            Favorite.objects.create(user=request.user, book=book)
            is_favorited = True
            message = f'Added "{book.title}" to favorites'
        
        return JsonResponse({
            'success': True,
            'is_favorited': is_favorited,
            'message': message
        })
    
    except Book.DoesNotExist:
        return JsonResponse({
            'success': False,
            'message': 'Book not found.'
        })
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': f'Error: {str(e)}'
        })
