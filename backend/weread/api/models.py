# In your app's models.py
from django.contrib.auth.models import AbstractUser
from django.db import models
from PIL import Image, ImageDraw, ImageFont
import os
from io import BytesIO
from django.core.files.base import ContentFile
from PIL import Image, ImageDraw, ImageFont
import os
from io import BytesIO
from django.core.files.base import ContentFile
from django.conf import settings

class CustomUser(AbstractUser):
    is_site_admin = models.BooleanField(default=False)
    is_library_admin = models.BooleanField(default=False)
    is_common_user = models.BooleanField(default=False)
    profile_pic = models.URLField(default='https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg')
    
    def __str__(self):
        return self.username

class Token(models.Model):
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE)
    token = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    expires_at = models.DateTimeField()
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return f"{self.user.username} - {self.token}"
