# Use the latest version of Ubuntu as the base image
FROM ubuntu:22.04

# Set environment variables to non-interactive (this prevents some prompts)
# Docker build will sometimes not finish without setting this
ENV DEBIAN_FRONTEND=noninteractive

# Update the base image and install Python 3.12, pip, virtualenv, and SSH server
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip git openssh-server && \
    python3.11 -m pip install --upgrade pip && \
    pip install virtualenv

RUN apt-get install -y sudo vim

# Set up SSH for remote connections
RUN mkdir /var/run/sshd

# Disable password authentication for SSH (optional, for security if using keys)
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Add users for the development environment
RUN groupadd -r systemgroup && useradd -rm -d /home/devuser -s /bin/bash -g systemgroup -u 1001 devuser
RUN groupadd developergroup && useradd -m -d /home/ryen -s /bin/bash -g developergroup -G sudo -u 1002 ryen
RUN usermod -aG sudo ryen  #Add ryen to sudo group

COPY ./env/ryen_ecdsa.pub /home/ryen/.ssh/authorized_keys
RUN chown ryen:developergroup -R /home/ryen/.ssh && \
    chmod 700 /home/ryen/.ssh && \
    chmod 600 /home/ryen/.ssh/authorized_keys


# Set up a volume for the application code
WORKDIR /app
RUN chown ryen:developergroup /app

# Copy over a script to initialize the environment and switch to non-root user
# This script should be in the same directory as the Dockerfile.
# It should contain your repo cloning and virtualenv setup commands.
# COPY init_env.sh /usr/local/bin/init_env
# RUN chmod +x /usr/local/bin/init_env

# Expose the port for the SSH server
EXPOSE 22

RUN mkdir /etc/docker-config
RUN chmod 600 /etc/docker-config
COPY ./docker/development_server/docker_entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Start the SSH service (as root)
CMD ["/usr/sbin/sshd", "-D"]
