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

#home page for web if there is a request from browser
def home(request):
    return HttpResponse("hai")

#check authentication of the token
class ProtectedView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        return Response({"message": "You have access to this protected view!"})


#testing if server work or not 
class TestAPIView(APIView):
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        print("the username and password is :",username,password)
        return Response({"message": "success"})
    


#signup new user and create a token
class UserRegistrationView(APIView):
    def post(self, request):
        serializer = UserRegistrationSerializer(data=request.data)
        if serializer.is_valid():
            # Create the user
            user = serializer.save()

            # Create JWT token for the new user
            refresh = RefreshToken.for_user(user)
            access_token = str(refresh.access_token)

            # Return a success response with the token
            return Response({
                "message": "User created successfully!",
                "access_token": access_token
            }, status=status.HTTP_201_CREATED)
        else:
            return Response({
                "error": serializer.errors
            }, status=status.HTTP_400_BAD_REQUEST)
