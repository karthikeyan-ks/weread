import os
import django
from django.contrib.auth import get_user_model

# Set up Django environment
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'weread.settings')
django.setup()

# Get the custom user model
CustomUser = get_user_model()

# Create superuser if it doesn't exist
if not CustomUser.objects.filter(username='admin').exists():
    CustomUser.objects.create_superuser(
        username='admin',
        email='admin@example.com',
        password='adminpassword',
        is_site_admin=True  # Assuming `is_site_admin` is a required field
    )
    print("Superuser created successfully.")
else:
    print("Superuser already exists.")
