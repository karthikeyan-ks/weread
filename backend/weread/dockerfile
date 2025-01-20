# Use a Python-based image as the base
FROM python:3.12-slim

# Install MySQL development libraries
RUN apt-get update && apt-get install -y libmysqlclient-dev

# Set up your working directory
WORKDIR /app

# Copy your project files
COPY . .

# Install the required Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Specify the default command to run your app
CMD ["python", "app.py"]
