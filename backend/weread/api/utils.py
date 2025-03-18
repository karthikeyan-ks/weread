# utils.py
import http.client
import json
from django.conf import settings

def send_otp(phone_number, otp):
    conn = http.client.HTTPSConnection(settings.INFOBIP_BASE_URL)
    
    payload = json.dumps({
        "messages": [
            {
                "destinations": [{"to": phone_number}],
                "from": settings.INFOBIP_SENDER_ID,
                "text": f"Your OTP code is {otp}. It is valid for 10 minutes."
            }
        ]
    })
    
    headers = {
        'Authorization': f'App {settings.INFOBIP_API_KEY}',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
    }
    
    conn.request("POST", "/sms/2/text/advanced", payload, headers)
    res = conn.getresponse()
    data = res.read()
    
    return data.decode("utf-8")
