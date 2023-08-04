FROM python:3.9-slim

WORKDIR /app

ADD . /app

RUN apt-get update && apt-get install -y curl gnupg

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs npm

RUN apt-get update && \
    apt-get install -y --no-install-recommends openjdk-17-jre-headless && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN pip install --no-cache-dir -r requirements.txt

ARG SPARK_VERSION=3.4.1
ARG HADOOP_VERSION=3
RUN curl -O https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz \
    && tar xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local/ \
    && rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz


ENV SPARK_HOME=/usr/local/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV PATH="$SPARK_HOME/bin:$PATH"
ENV PYTHONPATH="$SPARK_HOME/python:$PYTHONPATH"
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/

RUN pip install jupyter jupyter-lsp
RUN npm install -g pyright

EXPOSE 8888

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--NotebookApp.password=fb6df7c13e87:06137efb48ae21142033fca385f177a061bcc542"]

