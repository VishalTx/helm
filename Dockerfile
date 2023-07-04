FROM  centos:7
RUN yum update -y
RUN yum install -y httpd \
zip \
unzip
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
WORKDIR /var/www/html/

RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 9090


# FROM  centos:7
# RUN yum update -y
# RUN yum install -y httpd \
# zip \
# unzip
# RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page265/shine.zip /var/www/html/
# WORKDIR /var/www/html/

# RUN unzip shine.zip
# RUN cp -rvf shine/* .
# RUN rm -rf shine shine.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 9090
