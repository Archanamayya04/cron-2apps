# Use a base image with your application dependencies
FROM node:14

# Install Supervisor and cron
RUN apt-get update && apt-get install -y supervisor cron && \
    apt-get clean

# Create a directory for your applications
WORKDIR /app

# Copy app1 files and install dependencies
COPY app1/package.json /app/app1/
RUN cd /app/app1 && npm install
COPY app1/app1.js /app/app1/

# Copy app2 files and install dependencies
COPY app2/package.json /app/app2/
RUN cd /app/app2 && npm install
COPY app2/app2.js /app/app2/

# Copy your Supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy the cron job files
COPY cron_jobs/ /etc/cron.d
RUN crontab -u root -l | cat - /etc/cron.d/* | crontab -u root -
EXPOSE 3001 3002
# Start Supervisor when the container starts, and also start cron
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf", "-n"]

