FROM python:3.9-slim

WORKDIR /app

# Copy application files
ADD . /app

# Install general dependencies
RUN apt-get update && apt-get install -y curl gnupg nodejs npm r-base r-base-dev openjdk-17-jre-headless openssh-server supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    R -e "install.packages(c('IRkernel','ggplot2', 'dplyr'), repos='https://cloud.r-project.org/')" && \
    pip install --no-cache-dir -r requirements.txt && \
    pip install jupyter jupyter-lsp && \
    npm install -g pyright && \
    mkdir -p /var/run/sshd && \
    echo 'root:Sivanandan19' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Install and set up R kernel
RUN R -e "IRkernel::installspec(user = FALSE)"

# Install and set up Spark
ARG SPARK_VERSION=3.4.1
ARG HADOOP_VERSION=3
RUN curl -O https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -C /usr/local/ && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

ENV SPARK_HOME=/usr/local/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}
ENV PATH="$SPARK_HOME/bin:$PATH"
ENV PYTHONPATH="$SPARK_HOME/python:$PYTHONPATH"
ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=python3
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64/

# Jupyter configuration
EXPOSE 8888
EXPOSE 22
# RUN jupyter notebook --generate-config && \
#     echo "c.InteractiveShellApp.extensions.append('rpy2.ipython')" >> /root/.jupyter/jupyter_notebook_config.py

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]