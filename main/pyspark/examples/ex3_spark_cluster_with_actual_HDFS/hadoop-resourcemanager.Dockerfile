FROM hadoop-base:2.0.0-hadoop3.2.1-java8


HEALTHCHECK CMD curl -f http://localhost:8088/ || exit 1

ADD hadoop-scripts/resourcemanager-run.sh /resourcemanager-run.sh
RUN chmod a+x /resourcemanager-run.sh

EXPOSE 8088

CMD ["/resourcemanager-run.sh"]
