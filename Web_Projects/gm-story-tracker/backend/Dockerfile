# Install base Python
FROM python:3.12-slim

# Unbuffered puts logs in the docker logs
# DONTWriteByteCode skips .pyc files
ENV PYTHONUNBUFFERED=1\
    PYTHONDONTWRITEBYTECODE=1

# Creating the directory where this will will be run
WORKDIR /app

# Copying requirements and installing them
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all of the backend
COPY . .
    
# Exposes the port so that it can be used by the app
EXPOSE 8000

# This is the command that starts everything while chaining multiple commands
CMD [\
    "sh",\
    "-c",\
    "python manage.py migrate && (python manage.py createsuperuser --noinput || true) && python manage.py runserver 0.0.0.0:8000"\
]
