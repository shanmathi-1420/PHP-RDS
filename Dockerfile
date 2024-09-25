# Use an official PHP runtime as a base image
FROM php:7.4-apache

# Install mysqli extension
RUN docker-php-ext-install mysqli

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the PHP script and database configuration file to /var/www/html/
COPY index.php /var/www/html/
COPY dbinfo.inc.php /var/www/html/

# Ensure the copied files have the right permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for the web server
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]


