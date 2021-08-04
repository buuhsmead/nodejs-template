FROM registry.access.redhat.com/ubi8/nodejs-14:1-35.1626836507
USER root
COPY . /tmp/src
RUN chown -R 1001:0 /tmp/src
USER 1001
RUN /usr/libexec/s2i/assemble
CMD /usr/libexec/s2i/run

