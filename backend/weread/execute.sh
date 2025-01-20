pip install --upgrade mysqlclient
pip show mysqlclient
python manage.py makemigrations
python manage.py migrate
python superuser.py
python manage.py runserver 0.0.0.0:$PORT