import os
import django
import random

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'theparak_library.settings')
django.setup()

from django.contrib.auth.models import User

# Get all non-superuser users (keep 68063361 as admin)
users = User.objects.filter(is_superuser=False)

count = 0
for user in users:
    # Generate new username: 6621 + 3 random digits
    new_username = '6621' + ''.join(random.choices('0123456789', k=3))
    
    # Make sure it's unique
    while User.objects.filter(username=new_username).exclude(pk=user.pk).exists():
        new_username = '6621' + ''.join(random.choices('0123456789', k=3))
    
    # Update username and email
    old_username = user.username
    user.username = new_username
    user.email = f"{new_username}@theparak.edu"
    user.save()
    
    count += 1
    print(f"Updated: {old_username} → {new_username} (Email: {user.email})")

print(f"\n✅ Successfully updated {count} users!")
