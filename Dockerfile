#################################
# Use an existing Nginx image as a base
FROM nginx:latest

# Remove the default nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/

# Copy the entire memorygame directory into the Nginx server root
COPY memory-game /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Command to start Nginx when the container starts
CMD ["nginx", "-g", "daemon off;"]
#################################