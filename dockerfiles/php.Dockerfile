#php.Dockerfile
FROM php:8.3-fpm-bookworm

WORKDIR /var/www/laravel

# --- base utility ---------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    curl \
    git \
    zip unzip libzip-dev \
    wget \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd
RUN docker-php-ext-install zip

RUN apt-get update && apt-get install -y \
        libldap2-dev \
    && docker-php-ext-configure ldap && docker-php-ext-install ldap
# --- cryptography ---------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    gnupg gnupg2 gnupg1

# --- sqlite ---------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    sqlite3 \
    libsqlite3-dev \
    && docker-php-ext-install pdo_sqlite

# --- mysql ---------------------------------------------------------------
RUN docker-php-ext-install pdo pdo_mysql

# --- sql server ---------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    unixodbc-dev unixodbc

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN echo 'deb [arch=amd64,arm64,armhf] https://packages.microsoft.com/debian/12/prod bookworm main' > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update

RUN ACCEPT_EULA=Y apt-get install -y --allow-unauthenticated msodbcsql17
RUN ACCEPT_EULA=Y apt-get install -y --allow-unauthenticated mssql-tools

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

RUN pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv

# --- openssl ---------------------------------------------------------------
RUN apt-get update -yqq \
    && apt-get install -y --no-install-recommends openssl \
    && rm -rf /var/lib/apt/lists/*

#COPY php/openssl.cnf /etc/ssl/openssl.cnf

# --- composer ---------------------------------------------------------------
COPY --from=composer/composer:2.8-bin /composer /usr/bin/composer

# --- php.ini -----------------------------------------------------------------
#COPY php.ini-development /usr/local/etc/php/php.ini