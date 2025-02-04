FROM hadoop-base:2.0.0-hadoop3.2.1-java8


HEALTHCHECK CMD curl -f http://localhost:8188/ || exit 1

ENV YARN_CONF_yarn_timeline___service_leveldb___timeline___store_path=/hadoop/yarn/timeline
RUN mkdir -p /hadoop/yarn/timeline
VOLUME /hadoop/yarn/timeline

ADD hadoop-scripts/historyserver-run.sh /historyserver-run.sh
RUN chmod a+x /historyserver-run.sh

EXPOSE 8188

CMD ["/historyserver-run.sh"]
