from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from django.utils import timezone
from datetime import timedelta
from library.models import Borrowing


class Command(BaseCommand):
    help = 'Set a test penalty by adjusting borrow date for a user'

    def add_arguments(self, parser):
        parser.add_argument('username', type=str, help='Username to set penalty for')
        parser.add_argument('penalty_baht', type=int, help='Desired penalty in baht')

    def handle(self, *args, **options):
        username = options['username']
        penalty_baht = options['penalty_baht']
        
        try:
            # Find user
            user = User.objects.get(username=username)
            self.stdout.write(f"Found user: {user.username}")
            
            # Find active borrowing
            borrowing = Borrowing.objects.filter(student=user, is_returned=False).first()
            
            if not borrowing:
                self.stdout.write(self.style.ERROR(f"No active borrowing found for user {username}"))
                return
            
            self.stdout.write(f"Found borrowing: {borrowing.book.title}")
            
            # Calculate required days: penalty = (days - 7) * 5
            # So: days = (penalty / 5) + 7
            required_days = (penalty_baht // 5) + 7
            
            # Set borrow date to required_days ago
            new_borrow_date = timezone.now() - timedelta(days=required_days)
            borrowing.borrow_date = new_borrow_date
            borrowing.save()
            
            # Calculate actual penalty
            actual_days = (timezone.now() - borrowing.borrow_date).days
            actual_penalty = (actual_days - 7) * 5 if actual_days > 7 else 0
            
            self.stdout.write(self.style.SUCCESS(f"\n✓ Success!"))
            self.stdout.write(f"Borrow date set to {required_days} days ago")
            self.stdout.write(f"Days borrowed: {actual_days}")
            self.stdout.write(f"Penalty: {actual_penalty} baht")
            
        except User.DoesNotExist:
            self.stdout.write(self.style.ERROR(f"User {username} not found"))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f"Error: {str(e)}"))
