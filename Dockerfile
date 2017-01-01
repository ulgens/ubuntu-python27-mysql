FROM ubuntu:trusty
MAINTAINER Ülgen Sarıkavak <ulgensrkvk@gmail.com>

RUN locale-gen en_US en_US.UTF-8 && update-locale
RUN apt-get update

# Install Python dependencies
RUN apt-get install python-pip python-dev -y
RUN pip install virtualenv

# Install MySQL
RUN echo "mysql-server-5.5 mysql-server/root_password password root" | sudo debconf-set-selections
RUN echo "mysql-server-5.5 mysql-server/root_password_again password root" | sudo debconf-set-selections
RUN apt-get install libmysqlclient-dev mysql-server -y --force-yes
RUN service mysql start

# Install PhantomJS
RUN apt-get install wget git -y
RUN chmod +x install_phantomjs.sh && ./install_phantomjs.sh
