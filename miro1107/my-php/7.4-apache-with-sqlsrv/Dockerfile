FROM miro1107/my-php:7.4-apache

# install and get key and get list from Microsoft
# Debian 10
RUN apt-get update \
    && apt-get install -y gnupg apt-transport-https \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list 

# install msodbc and mssql-tools
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 mssql-tools 
#\
#    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
#    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
#    && source ~/.bashrc

# install sqlsrv and pdo_sqlsrv
RUN apt-get update \
    && apt-get install -y unixodbc-dev libgssapi-krb5-2 \
    && pecl install sqlsrv \
    && pecl install pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv \
    && docker-php-ext-enable pdo_sqlsrv
