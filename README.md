# Theparak Library - Django Digital Library System

A comprehensive digital library system for high schools built with Django and MySQL.

## Project Overview

Theparak Library is a Django-based digital library management system designed specifically for high schools. It provides functionality for:
- Managing book inventory
- Tracking book borrowing/returns
- Student reviews and ratings
- Author and category management
- Admin interface for library staff

## Database

- **Database Name**: `theparak_library_db`
- **Database Engine**: MySQL (via XAMPP)
- **Host**: localhost
- **Port**: 3306
- **User**: root
- **Password**: (empty)

## Database Tables

### Core Library Tables
- `library_category` - Book categories
- `library_author` - Book authors
- `library_book` - Books in the library
- `library_book_authors` - Many-to-many relationship between books and authors
- `library_borrowing` - Track book borrowing by students
- `library_review` - Student reviews for books

### Django Default Tables
- `auth_user` - User accounts
- `auth_group` - User groups
- `auth_permission` - Permissions
- `django_admin_log` - Admin action logs
- `django_session` - Session data
- And other Django management tables

## Installation & Setup

### Prerequisites
- Python 3.8+
- XAMPP with MySQL running

### Initial Setup (Already Completed)

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
.\venv\Scripts\Activate.ps1  # Windows PowerShell
# or
source venv/bin/activate  # Linux/Mac

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# Create superuser (for admin access)
python manage.py createsuperuser
```

## Running the Development Server

```bash
cd theparak_library
python manage.py runserver
```

Access the application at: `http://localhost:8000/`

## Admin Interface

Access the Django admin panel at: `http://localhost:8000/admin/`

Use superuser credentials to log in and manage:
- Books
- Authors
- Categories
- Borrowing records
- Student reviews

## Models

### Category
- name: CharField
- description: TextField
- created_at: DateTimeField

### Author
- first_name: CharField
- last_name: CharField
- bio: TextField
- created_at: DateTimeField

### Book
- title: CharField
- authors: ManyToManyField (Author)
- category: ForeignKey (Category)
- isbn: CharField
- description: TextField
- publication_date: DateField
- pages: IntegerField
- cover_image: ImageField
- pdf_file: FileField
- is_available: BooleanField
- created_at: DateTimeField
- updated_at: DateTimeField

### Borrowing
- student: ForeignKey (User)
- book: ForeignKey (Book)
- borrow_date: DateTimeField
- return_date: DateTimeField
- due_date: DateTimeField
- is_returned: BooleanField

### Review
- book: ForeignKey (Book)
- student: ForeignKey (User)
- rating: IntegerField (1-5)
- comment: TextField
- created_at: DateTimeField

## Dependencies

- Django 4.2
- mysqlclient
- Pillow

See `requirements.txt` for complete list.

## Project Structure

```
Theparak Library/
├── venv/                          # Virtual environment
├── requirements.txt               # Project dependencies
├── theparak_library/              # Django project folder
│   ├── manage.py                 # Django management script
│   ├── theparak_library/          # Project settings
│   │   ├── settings.py           # Django settings
│   │   ├── urls.py               # URL configuration
│   │   ├── asgi.py               # ASGI config
│   │   └── wsgi.py               # WSGI config
│   └── library/                   # Library app
│       ├── models.py             # Database models
│       ├── admin.py              # Admin configuration
│       ├── views.py              # Views
│       ├── urls.py               # App URLs
│       ├── apps.py               # App configuration
│       └── migrations/           # Database migrations
```

## Next Steps

1. **Create Views and Templates**: Develop web pages for browsing books, viewing details, etc.
2. **Set up URLs**: Configure URL routing in `library/urls.py` and include in project URLs
3. **Create Forms**: Add Django forms for student registration, book borrowing, reviews
4. **Customize Admin**: Add more admin customizations for staff
5. **Add Authentication**: Implement user registration and login for students
6. **Deploy**: Set up for production deployment

## Database Connection Details

The project is configured to use MySQL with the following settings in `settings.py`:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'theparak_library_db',
        'USER': 'root',
        'PASSWORD': '',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

## Support

For questions or issues, refer to:
- Django Documentation: https://docs.djangoproject.com
- MySQL Documentation: https://dev.mysql.com/doc/
