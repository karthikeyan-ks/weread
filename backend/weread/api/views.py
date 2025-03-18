from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.views import APIView
from .serializers import UserRegistrationSerializer
from .models import Token,CustomUser
from datetime import timedelta
from django.utils import timezone
from django.contrib.auth import authenticate    
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.permissions import AllowAny
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from django.http import JsonResponse,HttpResponse
from .utils import send_otp
from google.oauth2 import id_token
from google.auth.transport.requests import Request  # ✅ Corrected
import os
from django.shortcuts import render, redirect
from django.views.decorators.csrf import csrf_exempt


#home page for web if there is a request from browser
def home(request):
    return HttpResponse("hai")

#check authentication of the token
class ProtectedView(APIView):

    def get(self, request):
        return Response({"message": "You have access to this protected view!"})
    
    def post(self, request):
        access_token = request.data.get("access_token")
        
        if not access_token:
            return Response({"error": "Access token is required."}, status=400)
        
        try:
            # Validate the token
            refresh = RefreshToken(access_token)
            if refresh.is_expired():
                return Response({"error": "Token has expired."}, status=401)
            # If the token is valid, it will not raise an error
            return Response({"message": "Token is valid."}, status=200)
        except Exception as e:
            return Response({"error": "Invalid or expired token."}, status=401)



#testing if server work or not 
class TestAPIView(APIView):
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        print("the username and password is :",username,password)
        return Response({"message": "success"})
    


#signup new user and create a token
class UserRegistrationView(APIView):
    permission_classes = [AllowAny]
    def post(self, request):
        serializer = UserRegistrationSerializer(data=request.data)
        if serializer.is_valid():
            # Create the user
            user = serializer.save()

            # Create JWT token for the new user
            refresh = RefreshToken.for_user(user)
            access_token = str(refresh.access_token)
            token = Token(
                user=user,
                token=str(refresh),
                expires_at=timezone.now() + timedelta(days=36500)  # 3 months from now
            )
            token.save()

            # Return a success response with the token
            return Response({
                "message": "User created successfully!",
                "access_token": access_token
            }, status=status.HTTP_201_CREATED)
        else:
            return Response({
                "error": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)


#login to the weread using the refresh token
class LoginView(APIView):
    def post(self, request):
        # Assume you validate the user here (e.g., with a serializer)
        user = authenticate(request.data.get('username'), request.data.get('password'))
        if user:
            # Generate refresh token and access token
            refresh = Token.objects.filter(user=user).first()
            if refresh:
                access_token = str(refresh.access_token)
                refresh_token = str(refresh)
                return Response({
                    "access_token": access_token,
                    "refresh_token": refresh_token
                }, status=status.HTTP_200_OK)
        return Response({"error": "Invalid credentials"}, status=status.HTTP_401_UNAUTHORIZED)
            

#revoke the token from the database
class RevokeTokenView(APIView):
    def post(self, request):
        token = request.data.get("refresh_token")
        try:
            refresh_token = Token.objects.get(token=token, is_active=True)
            refresh_token.is_active = False
            refresh_token.save()
            return Response({"message": "Token revoked successfully"}, status=status.HTTP_200_OK)
        except RefreshToken.DoesNotExist:
            return Response({"error": "Invalid token"}, status=status.HTTP_400_BAD_REQUEST)


from django.conf import settings
import json
import requests

class SendOtpView(APIView):
    permission_classes = [AllowAny]  # Allow public access without authentication

    def post(self, request):
        if request.method == "POST":
            try:
                # Handle both JSON and Form data
                if request.content_type == "application/json":
                    data = json.loads(request.body)
                    phone_number = data.get("phone_number")
                else:
                    phone_number = request.POST.get("phone_number")

                if not phone_number:
                    return JsonResponse({"error": "Phone number is required"}, status=400)

                url = f"{settings.INFOBIP_BASE_URL}/2fa/2/pin"
                headers = {
                    "Authorization": f"App {settings.INFOBIP_API_KEY}",
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                }
                data = {
                    "applicationId": settings.INFOBIP_APPLICATION_ID,
                    "messageId": "YOUR_MESSAGE_ID",  # Replace with actual ID
                    "from": "ServiceSMS",
                    "to": phone_number
                }

                response = requests.post(url, json=data, headers=headers)
                response_data = response.json()

                if "pinId" in response_data:
                    return JsonResponse({"message": "OTP sent", "pinId": response_data["pinId"]})
                else:
                    return JsonResponse({"error": response_data}, status=400)

            except json.JSONDecodeError:
                return JsonResponse({"error": "Invalid JSON format"}, status=400)

        return JsonResponse({"error": "Invalid request"}, status=400)

    def get(self, request):
        """Testing endpoint"""
        
        try:
            otp = send_otp("+918590895632","5673")
            return Response({"message": "OTP sent successfully", "otp": otp})  # OTP should be stored in DB for verification
        except Exception as e:
            return Response({"error": str(e)}, status=500)
        
        
        
        

@csrf_exempt
def sign_in(request):
    return render(request, 'sign_in.html')

@csrf_exempt
def auth_receiver(request):
    token = request.POST.get("credential")  # Get token from frontend

    try:
        # Create a Google request object
        google_request = Request()  # ✅ Corrected

        # Verify token using Google API
        user_data = id_token.verify_oauth2_token(
            token,
            google_request,  # ✅ Now it's correct
            "441312509386-t0lacnkuatvgnaam9gjan1bile77ildb.apps.googleusercontent.com"
        )
        request.session['user_data'] = user_data
        user = CustomUser.objects.filter(email=user_data['email'])
        print(request.session['user_data'],user)
        return JsonResponse({"message": "User authenticated", "user_data": user_data})

    except ValueError as e:
        return JsonResponse({"error": str(e)}, status=400)

def sign_out(request):
    del request.session['user_data']
    return redirect('sign_in')
