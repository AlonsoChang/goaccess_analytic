FROM ruby:2.3

RUN apt-get update -y && apt-get install sudo vim openssh-server git python-pip apache2 goaccess -y && apt-get clean all
RUN pip install supervisor
RUN gem install jekyll

RUN mkdir /var/run/sshd
RUN echo 'root:changeme' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# set root ssh login workdir
RUN echo 'cd /usr/src/app' >> /root/.bash_profile

# == begin to set react workspace ==

EXPOSE 22 8888
