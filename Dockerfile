FROM python

# Install OpenJDK-8
RUN apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  apt-get install -y ant && \
  apt-get clean;

# Fix certificate issues
RUN apt-get update && \
  apt-get install ca-certificates-java && \
  apt-get clean && \
  update-ca-certificates -f;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

EXPOSE 8000

COPY . .

RUN python setup.py install

CMD python -c 'import nlgserv; import sys; s = nlgserv.start_server("0.0.0.0",8000,sys.stdout,sys.stderr,True)'