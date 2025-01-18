# In your app's models.py
from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    is_site_admin = models.BooleanField(default=False)
    is_library_admin = models.BooleanField(default=False)
    is_common_user = models.BooleanField(default=False)
    
    def __str__(self):
        return self.username
