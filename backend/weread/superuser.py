# create_superuser.py

from django.core.management import call_command
from django.contrib.auth import get_user_model

User = get_user_model()

# Check if the superuser already exists to avoid duplicate entries
if not User.objects.filter(username='admin').exists():
    call_command('createsuperuser', '--noinput', username='admin', email='admin@example.com', password='admin')
