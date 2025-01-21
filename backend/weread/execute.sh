pip install --upgrade mysqlclient
pip show mysqlclient
python manage.py makemigrations
python manage.py migrate
DJANGO_SETTINGS_MODULE=weread.settings python superuser.py
python manage.py runserver 0.0.0.0:$PORT