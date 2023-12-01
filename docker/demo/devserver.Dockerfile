# Demo devserver Dockerfile
FROM python:3.11-slim

# Set working directory
WORKDIR /app

### COPY ./docker/demo/startup.sh /startup.sh
### RUN chmod +x /startup.sh

# Copy flask app
COPY ./servers/dev_server /app

# Copy core python module
# Actually, I think it should be in /usr/local/lib/ but I'll fix later
COPY ./python_modules/ampere_core/ /usr/local/lib/app/ampere_core/

# Install core python module
RUN pip install --no-cache-dir -e /usr/local/lib/app/ampere_core/

# Install server dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install nginx and copy configuration
# RUN apt-get update && apt-get install -y nginx && apt-get clean
# COPY ./config/nginx/dev_server/devserver_nginx.conf /etc/nginx/nginx.conf

# Start gunicorn and nginx
# CMD ["bash", "-c", "gunicorn -w 1 -b 0.0.0.0:8000 main:app & nginx -g 'daemon off;'"]

CMD [ "python", "src/main.py" ]

### ENTRYPOINT ["/startup.sh"]