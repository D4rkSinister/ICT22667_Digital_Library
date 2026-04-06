import os
import django
import random
from datetime import timedelta

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'theparak_library.settings')
django.setup()

from django.contrib.auth.models import User
from django.utils import timezone
from library.models import Book, Borrowing

# Get all non-superuser students
students = User.objects.filter(is_superuser=False)[:6]  # Select 6 random users
books = Book.objects.all()[:5]  # Get some books

if not books:
    print("❌ No books found. Add some books first!")
    exit()

count = 0
for student in students:
    # Random chance to create penalty (not all students)
    if random.choice([True, False, False]):  # 33% chance
        book = random.choice(books)
        
        # Generate overdue days (2-8 days = 10-40 baht penalty at 5 baht/day)
        overdue_days = random.randint(2, 8)
        penalty_amount = overdue_days * 5
        
        # Create a borrowing record with past dates
        borrow_date = timezone.now() - timedelta(days=20)
        due_date = borrow_date + timedelta(days=7)
        return_date = due_date + timedelta(days=overdue_days)
        
        borrowing = Borrowing.objects.create(
            student=student,
            book=book,
            borrow_date=borrow_date,
            due_date=due_date,
            return_date=return_date,
            is_returned=True
        )
        
        count += 1
        print(f"✅ {student.username} ({student.first_name}) - Penalty: {penalty_amount} baht (Book: {book.title})")

print(f"\n✅ Created {count} penalty records!")
