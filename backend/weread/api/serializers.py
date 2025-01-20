from rest_framework import serializers
from django.contrib.auth.models import User
from .models import CustomUser

class UserRegistrationSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['username', 'email', 'is_site_admin', 'is_library_admin', 'is_common_user']

    def create(self, validated_data):
        user = CustomUser.objects.create_user(**validated_data)
        return user