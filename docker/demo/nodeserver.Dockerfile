# Demo nodeserver Dockerfile
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy flask app
COPY ./servers/node_server /app

# Copy core python module
COPY ./python_modules/ampere_core/ /usr/lib/app/ampere_core/

# Install core python module
RUN pip install --no-cache-dir /usr/lib/app/ampere_core/

# Install server dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install nginx and copy configuration
RUN apt-get update && apt-get install -y nginx && apt-get clean
COPY ./config/nginx/node_server/nodeserver_nginx.conf /etc/nginx/nginx.conf

# Start gunicorn and nginx
CMD ["bash", "-c", "gunicorn -w 1 -b 0.0.0.0:8001 main:app & nginx -g 'daemon off;'"]