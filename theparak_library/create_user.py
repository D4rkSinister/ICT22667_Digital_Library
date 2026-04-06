import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'theparak_library.settings')
django.setup()

from django.contrib.auth.models import User

username = '68063361'
password = '1119600101237'
email = 'admin@example.com'

if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username, email, password)
    print(f"Superuser '{username}' created successfully!")
else:
    print(f"User '{username}' already exists.")
