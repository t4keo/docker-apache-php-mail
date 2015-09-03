FROM debian:jessie
MAINTAINER Cedric ESSLINGER <cedric.esslinger@viacesi.fr>

# Install apache2 and php5
RUN apt-get update && apt-get install -y apache2 php5 && apt-get clean

# Expose needed ports
EXPOSE 80 443

# Run apache at begining
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
