FROM phusion/baseimage:0.9.11

# All our build dependencies, in alphabetical order (to ease maintenance)
RUN apt-get update
RUN apt-get install -y \
	build-essential \
	libgd2-dev \
	libgeoip-dev \
	libpcre3-dev \
	libperl-dev \
	libssl-dev \
	libxslt1-dev \
	perl \
	curl

WORKDIR /tmp
RUN curl -LO http://nginx.org/download/nginx-1.7.3.tar.gz
RUN tar xvzf nginx-1.7.3.tar.gz && \
    mv nginx-1.7.3 /usr/src/nginx

WORKDIR /usr/src/nginx
RUN ./configure \
		--user=www-data \
		--group=www-data \
		--prefix=/usr/local/nginx \
		--conf-path=/etc/nginx/nginx.conf \
		--http-log-path=/proc/self/fd/1 \
		--error-log-path=/proc/self/fd/2 \
		--with-http_addition_module \
		--with-http_auth_request_module \
		--with-http_dav_module \
		--with-http_geoip_module \
		--with-http_gzip_static_module \
		--with-http_image_filter_module \
		--with-http_perl_module \
		--with-http_realip_module \
		--with-http_spdy_module \
		--with-http_ssl_module \
		--with-http_stub_status_module \
		--with-http_sub_module \
		--with-http_xslt_module \
		--with-ipv6 \
		--with-mail \
		--with-mail_ssl_module \
		--with-pcre-jit

RUN make -j"$(nproc)"
RUN make install \
	&& ln -vs ../nginx/sbin/nginx /usr/local/sbin/ \
	&& chown -R www-data:www-data /usr/local/nginx

RUN cp /usr/src/nginx/conf/mime.types /etc/nginx/mime.types

# remember to stay in the foreground so Docker has a process to track.
# To this effect, add this to nginx.conf: 'daemon off;'

WORKDIR /usr/local/nginx/html

RUN mkdir -vp /var/www

CMD ["nginx"]
