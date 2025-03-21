"""
URL configuration for weread project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from api.views import TestAPIView, home, ProtectedView, UserRegistrationView, LoginView,SendOtpView,sign_in,sign_out,auth_receiver
from django.urls import path, include
from rest_framework_simplejwt import views as jwt_views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('accounts/', include('allauth.urls')),
    path('signup/',TestAPIView.as_view(), name='test-api'),
    path('login/',LoginView.as_view(), name='login'),
    path('api/token/', jwt_views.TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('api/token/refresh/', jwt_views.TokenRefreshView.as_view(), name='token_refresh'),
    path('protected/', ProtectedView.as_view(), name='protected_view'),
    path('register/', UserRegistrationView.as_view(), name='register'),
    path('send-otp/', SendOtpView.as_view(), name='send-otp'),  # ✅ Correct
    path('', sign_in, name='sign_in'),
    path('sign-out', sign_out, name='sign_out'),
    path('auth-redirect', auth_receiver, name='auth_redirect'),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
