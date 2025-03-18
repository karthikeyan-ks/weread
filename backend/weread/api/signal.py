import requests
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.core.files.base import ContentFile
from django.conf import settings
from .models import CustomUser

@receiver(post_save, sender=CustomUser)
def set_default_profile_pic(sender, instance, created, **kwargs):
    print('Changes captured...')
    if created and not instance.profile_pic:  # If new user & no profile pic
        google_avatar_url = f"https://ui-avatars.com/api/?name={instance.username}&size=200"
        
        # Download and save the image
        response = requests.get(google_avatar_url)
        if response.status_code == 200:
            file_name = f"profile_{instance.username}.jpg"
            instance.profile_pic.save(file_name, ContentFile(response.content), save=False)
            instance.save()
