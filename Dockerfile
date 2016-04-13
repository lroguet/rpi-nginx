FROM resin/rpi-raspbian
MAINTAINER Ludovic Roguet <code@fourteenislands.io>

RUN \
  apt-get update && \
  apt-get install -y -q --no-install-recommends nginx && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx
  
# Forward request and error logs to docker log collector.
RUN \
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 80 443
