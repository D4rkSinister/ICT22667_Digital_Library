# 📚 Theparak Library - Django Digital Library System

A comprehensive digital library system for high schools built with **Django** and **MySQL**.

---

## 🚀 Project Overview
Theparak Library is a Django-based digital library management system designed specifically for high schools. It provides functionality for:
* **Managing book inventory**
* **Tracking book borrowing/returns**
* **Student reviews and ratings**
* **Author and category management**
* **Admin interface for library staff**

---

## 🗄️ Database Configuration
* **Database Name:** `theparak_library_db`
* **Database Engine:** MySQL (via XAMPP)
* **Host:** `localhost`
* **Port:** `3306`
* **User:** `root`
* **Password:** (empty)

### Core Library Tables
* `library_category`: Book categories
* `library_author`: Book authors
* `library_book`: Books in the library
* `library_book_authors`: Many-to-many relationship (Books & Authors)
* `library_borrowing`: Track book borrowing by students
* `library_review`: Student reviews for books

---

## 🛠️ Installation & Setup

### 1. Prerequisites
* Python 3.8+
* XAMPP with MySQL running
* Git

### 2. Clone the Repository
```bash
git clone https://github.com/D4rkSinister/ICT22667_Digital_Library.git
cd Theparak-Library
```

### 3. Create Virtual Environment
```bash
python -m venv venv

# Activate virtual environment
.\venv\Scripts\Activate.ps1  # Windows
source venv/bin/activate     # Linux/Mac
```

### 4. Install Dependencies
```bash
pip install -r requirements.txt
```

### 5. Database Setup
#### Option A: Using the SQL dump (Recommended)
```bash
# Start XAMPP MySQL service
# Import the database using MySQL command line or phpMyAdmin
mysql -u root < theparak_library_db.sql
```

#### Option B: Create from migrations
```bash
cd theparak_library
python manage.py migrate

# Create a superuser account
python manage.py createsuperuser
```

### 6. Run the Development Server
```bash
cd theparak_library
python manage.py runserver
```

The application will be available at `http://localhost:8000/`

---

## 📖 Usage

### Access the Application
* **Main Site:** http://localhost:8000/
* **Admin Panel:** http://localhost:8000/admin/
  - Username: `root`
  - Password: (as set during superuser creation)

### Features
1. **Browse Books** - View all available books with filters
2. **Borrow Books** - Students can borrow books and track due dates
3. **My Borrowings** - View your current and past borrowings
4. **Penalties** - Track and pay library penalties
5. **Reviews** - Leave ratings and reviews for books
6. **Member List** - View library members and their borrowing history
7. **Admin Interface** - Manage books, authors, categories, and users

---

## 📁 Project Structure
```
Theparak-Library/
├── theparak_library/
│   ├── library/                 # Main Django app
│   │   ├── models.py           # Database models
│   │   ├── views.py            # View functions
│   │   ├── urls.py             # URL routing
│   │   ├── forms.py            # Django forms
│   │   ├── admin.py            # Admin configuration
│   │   ├── static/             # CSS, JS, images
│   │   ├── templates/          # HTML templates
│   │   └── migrations/         # Database migrations
│   ├── theparak_library/        # Project settings
│   │   ├── settings.py         # Django settings
│   │   ├── urls.py             # Main URL config
│   │   ├── wsgi.py             # WSGI config
│   │   └── asgi.py             # ASGI config
│   ├── manage.py               # Django management script
│   ├── db.sqlite3              # Database (SQLite backup)
│   └── media/                  # User uploads (book covers)
├── requirements.txt            # Python dependencies
├── theparak_library_db.sql    # MySQL database dump
└── README.md                   # This file
```

---

## 🔧 Utility Scripts
The project includes several management utilities:
* `create_user.py` - Bulk create user accounts
* `generate_users.py` - Generate test user data
* `add_penalties.py` - Add penalty records
* `update_usernames.py` - Update user information

---

## 🐛 Troubleshooting

### Virtual Environment Activation Issues (Windows PowerShell)

#### Error: "cannot be loaded because running scripts is disabled"
```powershell
# Enable script execution for current user
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Then activate venv
.\venv\Scripts\Activate.ps1
```

#### Virtual Environment folder not found
```powershell
# Ensure you're in the correct directory
cd Theparak-Library

# Recreate virtual environment
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

#### Using Command Prompt instead (Alternative)
```cmd
# If PowerShell doesn't work, use Command Prompt instead
venv\Scripts\activate.bat
```

### MySQL Connection Error
- Ensure XAMPP MySQL service is running
- Verify database credentials in `theparak_library/settings.py`
- Check `DATABASES` configuration
- Test connection: `mysql -u root -p` (password is empty, just press Enter)

### Port 8000 Already in Use
```bash
python manage.py runserver 8001  # Use different port
```

### Migration Errors
```bash
python manage.py makemigrations
python manage.py migrate --run-syncdb
```

### Python Not Found
```bash
# Check Python installation
python --version

# If not found, install Python 3.8+ from python.org
# Ensure "Add Python to PATH" is checked during installation
```

### "No module named 'django'"
```bash
# Make sure virtual environment is activated, then reinstall
pip install -r requirements.txt
```

---

## 📝 License
This project is developed as part of ICT22667 Digital Library coursework.

---

## 👤 Author
D4rkSinister

## 🤝 Contributing
Pull requests are welcome. For major changes, please open an issue first.
