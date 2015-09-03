FROM debian:jessie
MAINTAINER Cedric ESSLINGER <cedric.esslinger@viacesi.fr>

# Install apache2 and php5
RUN apt-get update && apt-get install -y apache2 php5 exim4 && apt-get clean

# Delete the files that we are gonna replace
RUN rm -rf /etc/exim4/update-exim4.conf.conf && rm -rf /etc/mailname

# Replace the previously deleted files with the good ones
ADD update-exim4.conf.conf /etc/exim4/update-exim4.conf.conf 
ADD mailname /etc/mailname

# Restart Exim to apply the changes
RUN service exim4 restart

# Expose needed ports
EXPOSE 80 443 25

# Run apache at begining
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
