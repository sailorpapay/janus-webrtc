FROM ubuntu:18.04

RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y apt-utils bash wget libmicrohttpd-dev \
                        libjansson-dev libnice-dev libssl-dev libsofia-sip-ua-dev \
                        libglib2.0-dev libopus-dev libogg-dev libcurl4-openssl-dev \
                        pkg-config gengetopt libtool automake git cmake libconfig-dev


RUN apt-get -y update && \
	apt-get install -y \
		libmicrohttpd12 \
		libjansson4 \
		libssl1.1 \
		libsofia-sip-ua0 \
		libglib2.0-0 \
		libopus0 \
		libogg0 \
		libcurl4 \
		liblua5.3-0 \
		libconfig9 \
		librabbitmq4

RUN cd /tmp && \
	wget https://github.com/cisco/libsrtp/archive/v2.3.0.tar.gz && \
	tar xfv v2.3.0.tar.gz && \
	cd libsrtp-2.3.0 && \
	./configure --prefix=/usr --enable-openssl && \
	make shared_library && \
	make install

RUN cd /tmp \
  && git clone https://github.com/warmcat/libwebsockets.git \
  && cd libwebsockets \
  && git checkout v2.1.0 \
  && mkdir build \
  && cd build \
  && cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr .. \
  && make \
  && make install

RUN cd ~ \
    && git clone https://github.com/sctplab/usrsctp \
    && cd usrsctp \
    && ./bootstrap \
    && ./configure --prefix=/usr \
    && make \
    && make install


RUN cd ~ \
    && git clone https://github.com/meetecho/janus-gateway.git \
    && cd janus-gateway \
    && sh autogen.sh \
    && ./configure --prefix=/opt/janus --disable-rabbitmq --disable-plugin-sip --disable-mqtt\
    && make CFLAGS='-std=c99' \
    && make install \
    && make configs




RUN apt-get install nginx -y







COPY conf/*.cfg /opt/janus/etc/janus/
COPY nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 7088 8088 8188 8089
EXPOSE 10000-10200/udp

CMD service nginx restart && /opt/janus/bin/janus --nat-1-1=${DOCKER_IP}
