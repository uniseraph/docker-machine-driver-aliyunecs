FROM alpine:3.2
#FROM ubuntu:14.04
MAINTAINER zhengtao.wuzt <zhengtao.wuzt@alibaba-inc.com>

RUN mkdir -p /opt/acs
ADD  ./docker-machine-driver-aliyunecs  /opt/acs/api
RUN chmod +x /opt/acs/docker-machine-driver-aliyunecs


CMD ["/opt/acs/docker-machine-driver-aliyunecs"]


