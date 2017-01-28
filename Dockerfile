FROM ubuntu:trusty
MAINTAINER Ülgen Sarıkavak <ulgensrkvk@gmail.com>

RUN locale-gen en_US en_US.UTF-8 && update-locale

# MySQL Setup
RUN echo "mysql-server-5.5 mysql-server/root_password password root" | sudo debconf-set-selections && \
    echo "mysql-server-5.5 mysql-server/root_password_again password root" | sudo debconf-set-selections

# Install packages
RUN apt-get update && apt-get install \
        # Python
        python-pip python-dev \
        # Mysql
        libmysqlclient-dev mysql-server \
        # Phantom.js
        build-essential chrpath libssl-dev libxft-dev libfreetype6 libfreetype6-dev \
        libfontconfig1 libfontconfig1-dev wget git -y && \
    # Clean
    apt-get autoclean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install virtualenv

# Install PhantomJS
ADD install_phantomjs.sh /install_phantomjs.sh
RUN chmod +x /install_phantomjs.sh && ./install_phantomjs.sh
