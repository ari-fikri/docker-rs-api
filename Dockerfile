FROM fudyartanto/alpine-phalcon-nginx
#FROM mileschou/phalcon

RUN echo "Running Rally Station VS API"
COPY ./config/nginx.conf /etc/nginx/nginx.conf
COPY ./rs-workshop/.env.dist /var/www/html/.env
ADD ./rs-workshop /var/www/html

RUN docker-php-ext-install mysqli
RUN apk upgrade --update && apk add \
  coreutils \
  freetype-dev \
  libjpeg-turbo-dev \
  libltdl \
  libmcrypt-dev \
  libpng-dev \
&& docker-php-ext-install -j$(nproc) iconv mcrypt \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd 

RUN docker-php-ext-install -j$(nproc) zip
RUN "apk" "add" "vim"
RUN "composer" "install"
