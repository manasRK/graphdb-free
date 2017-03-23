FROM openjdk:8-jdk

LABEL maintainer "Manas Ranjan Kar <manasrkar91@gmail.com>"

# Build time arguments
ARG version=8.0.4
ARG edition=free


# Environment variables, to be used for the docker image
ENV GDB_HEAP_SIZE=5g
ENV GDB_MIN_MEM=1g
ENV GDB_MAX_MEM=6g

ENV GRAPHDB_PARENT_DIR=/opt/graphdb
ENV GRAPHDB_HOME=${GRAPHDB_PARENT_DIR}/home
ENV GRAPHDB_INSTALL_DIR=${GRAPHDB_PARENT_DIR}/dist

# Copy the installation file recieved after registration
ADD graphdb-${edition}-${version}-dist.zip /tmp

RUN mkdir -p ${GRAPHDB_PARENT_DIR} && \
    cd ${GRAPHDB_PARENT_DIR} && \
    unzip /tmp/graphdb-${edition}-${version}-dist.zip && \
    mv graphdb-${edition}-${version} dist && \
    mkdir -p ${GRAPHDB_HOME} && \
    rm /tmp/graphdb-${edition}-${version}-dist.zip

ENV PATH=${GRAPHDB_INSTALL_DIR}/bin:$PATH

CMD ["-Dgraphdb.home=/opt/graphdb/home"]

ENTRYPOINT ["/opt/graphdb/dist/bin/graphdb"]

EXPOSE 7200
