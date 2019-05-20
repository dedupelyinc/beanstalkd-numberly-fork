FROM ubuntu:bionic

RUN useradd -m -u 1011 -U beanstalkd

RUN apt-get update -y && \
    apt-get install -y build-essential git psmisc

WORKDIR /home/beanstalkd

RUN git clone https://github.com/numberly/beanstalkd.git && \
    cd beanstalkd && make && \
    apt-get remove git build-essential -y && \
    apt-get autoremove -y && \
    mkdir -p /var/beanstalkd && \
    chown beanstalkd:beanstalkd -R /var/beanstalkd

COPY --chown=beanstalkd:beanstalkd ./entrypoint.sh /home/beanstalkd/entrypoint.sh

RUN chmod +x /home/beanstalkd/entrypoint.sh

USER beanstalkd

EXPOSE 11300

ENTRYPOINT ["/home/beanstalkd/entrypoint.sh"]