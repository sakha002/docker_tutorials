FROM spark-base:3.1.1-hadoop3.2-m


COPY spark-scripts/spark-worker.sh /

ENV SPARK_WORKER_WEBUI_PORT 8081
ENV SPARK_WORKER_LOG /spark/logs
ENV SPARK_MASTER "spark://spark-master:7077"

EXPOSE 8081

CMD ["/bin/bash", "/spark-worker.sh"]
