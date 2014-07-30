# jekyll container
#
# VERSION		0.0.2

FROM ubuntu:14.04
MAINTAINER Keishi Tanaka <https://github.com/toieeKC>

# Set Environment
ENV PATH /.rbenv/bin:$PATH
ENV PATH /.rbenv/shims:$PATH

# Update All Packages
RUN apt-get update -y

# Install rbenv With git
RUN apt-get install -y git
RUN git clone https://github.com/sstephenson/rbenv.git /.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /.rbenv/plugins/ruby-build

# Install Packages For Build Ruby
RUN apt-get install -y curl wget
RUN apt-get install -y gcc make
RUN apt-get install -y libssl-dev 

# Build Ruby
RUN rbenv install 2.1.2
RUN rbenv global 2.1.2

# Set Path For SSH Login User
RUN echo 'export PATH="/.rbenv/bin:$PATH"' >> /root/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> /root/.bash_profile
RUN echo 'export PATH="/.rbenv/shims:$PATH"' >> /root/.bash_profile

# Install jekyll
RUN apt-get install -y nodejs
RUN gem update --system
RUN gem install jekyll
RUN rbenv rehash

# Install nginx & openssh
RUN apt-get install -y nginx
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:yourpassword' |chpasswd

# Change SSH Setting
RUN sed -ri 's/^PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

# Install supervisord
RUN apt-get install -y supervisor
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN rm -v /etc/nginx/sites-enabled/default
ADD default /etc/nginx/sites-enabled/default

# Install Vim
RUN apt-get install -y vim

# Expose Ports
EXPOSE 80 22

# Command
CMD    ["/usr/bin/supervisord"]




