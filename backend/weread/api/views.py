from rest_framework.views import APIView
from rest_framework.response import Response
from django.http import HttpResponse

def home(request):
    return HttpResponse("hai")

class TestAPIView(APIView):
    def post(self, request):
        username = request.data.get('username')
        password = request.data.get('password')
        print("the username and password is :",username,password)
        return Response({"message": "success"})
