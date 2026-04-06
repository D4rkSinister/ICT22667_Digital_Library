import os
import django
import random
import string

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'theparak_library.settings')
django.setup()

from django.contrib.auth.models import User

# Thai-style first names and last names for realistic data
first_names = [
    'สมชาย', 'สมหญิง', 'วิชัย', 'อนันต์', 'จริยา',
    'ประเทศ', 'ศริณ', 'ศิวา', 'เมืองแกน', 'พัฒน์'
]

last_names = [
    'ศรีสัง', 'ดำเนิน', 'กิจวงศ์', 'สิทธิ์', 'วงศ์ศรี',
    'นวลข้าว', 'อมรพันธุ์', 'เจริญวัฒน์', 'อภิชาติ', 'ธนบูรณ์'
]

def generate_username():
    """Generate a random username"""
    return 'user_' + ''.join(random.choices(string.digits, k=8))

def generate_password():
    """Generate a random password"""
    return ''.join(random.choices(string.ascii_letters + string.digits, k=10))

# Create 10 users
count = 0
for _ in range(10):
    username = generate_username()
    # Make sure username is unique
    while User.objects.filter(username=username).exists():
        username = generate_username()
    
    password = generate_password()
    first_name = random.choice(first_names)
    last_name = random.choice(last_names)
    email = f"{username}@theparak.edu"
    
    user = User.objects.create_user(
        username=username,
        password=password,
        first_name=first_name,
        last_name=last_name,
        email=email
    )
    count += 1
    print(f"Created user: {username} ({first_name} {last_name})")

print(f"\n✅ Successfully created {count} users!")
