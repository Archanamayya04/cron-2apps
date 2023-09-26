# Use a base image with your application dependencies
FROM node:14

# Install Supervisor and cron
RUN apt-get update && apt-get install -y supervisor cron

# Create a directory for your applications
WORKDIR /app

# Copy app1 files and install dependencies
COPY app1/app1.js /app/app1/
COPY app1/package.json /app/app1/
RUN cd /app/app1 && npm install

# Copy app2 files and install dependencies
COPY app2/app2.js /app/app2/
COPY app2/package.json /app/app2/
RUN cd /app/app2 && npm install

# Copy your Supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add your cron jobs to the crontab
RUN crontab -u root -l | { cat; echo "*/5 * * * * /usr/local/bin/node /app/app1/app1.js"; echo "*/10 * * * * /usr/local/bin/node /app/app2/app2.js"; } | crontab -u root -

EXPOSE 3001 3002

# Start Supervisor when the container starts
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

