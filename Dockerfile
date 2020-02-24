FROM ubuntu:18.04

# Setup system locale
ENV DEBIAN_FRONTEND noninteractiv
RUN apt-get update \
  && apt-get install -y locales \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && dpkg-reconfigure --frontend=noninteractive locales \
  && update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 
ENV LC_ALL en_US.UTF-8

# Add must have package
RUN apt update && apt install gnupg2 wget curl vim git -y

# Compile Ruby from source
RUN apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev -y
RUN wget http://ftp.ruby-lang.org/pub/ruby/2.5/ruby-2.5.7.tar.gz
RUN tar -xzvf ruby-2.5.7.tar.gz -C /root/
WORKDIR /root/ruby-2.5.7/
RUN ./configure
RUN make
RUN make install