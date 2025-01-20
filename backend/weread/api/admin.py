
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import CustomUser, Token
from .forms import CustomUserChangeForm

class CustomUserAdmin(UserAdmin):
    form = CustomUserChangeForm

    # Add the new fields to the fieldsets
    fieldsets = UserAdmin.fieldsets + (
        (None, {'fields': ('is_site_admin', 'is_library_admin','is_common_user')}),  # Replace with your custom fields
    )

    # Specify the fields to display in the list view
    list_display = ['username', 'email', 'first_name', 'last_name', 'is_staff', 'is_active', 'is_site_admin', 'is_library_admin','is_common_user']  # Add your new fields here

admin.site.register(CustomUser)
admin.site.register(Token)
