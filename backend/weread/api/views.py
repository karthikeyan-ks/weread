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
from .models import Token
from datetime import timedelta
from django.utils import timezone
from django.contrib.auth import authenticate    
from rest_framework_simplejwt.authentication import JWTAuthentication
from rest_framework.permissions import AllowAny



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
