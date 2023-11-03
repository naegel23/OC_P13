# Use the appropriate base image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*  # <--- Removed backslash here

# Correct placement of COPY command
COPY requirements.txt /app/

# Then run pip install
RUN pip install --upgrade pip && pip install -r requirements.txt

# Continue with the rest of the Dockerfile
COPY . /app/

COPY static /path/in/container/static/

# Run gunicorn
CMD ["gunicorn", "oc_lettings_site.wsgi:application", "--bind", "0.0.0.0:8000"]
