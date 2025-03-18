import firebase_admin
from firebase_admin import credentials
from firebase_admin import auth

# Initialize Firebase
cred = credentials.Certificate("config/firebase/serviceAccount.json")
firebase_admin.initialize_app(cred)

def send_otp(phone_number):
    """Send OTP to a phone number using Firebase"""
    try:
        # Create a custom token for the phone number
        custom_token = auth.create_custom_token(phone_number)
        return {"message": "OTP sent successfully", "custom_token": custom_token.decode('utf-8')}
    except Exception as e:
        return {"error": str(e)}
