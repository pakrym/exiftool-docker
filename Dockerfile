FROM alpine:3.12
MAINTAINER Tom Van Herreweghe

ENV EXIFTOOL_VERSION=12.00
ENV SOURCE=/mnt/source
ENV DESTINATION=/mnt/dest/exif.json

RUN apk add --no-cache perl make
RUN cd /tmp \
	&& wget https://exiftool.org/Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
	&& tar -zxvf Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
	&& cd Image-ExifTool-${EXIFTOOL_VERSION} \
	&& perl Makefile.PL \
	&& make test \
	&& make install \
	&& cd .. \
	&& rm -rf Image-ExifTool-${EXIFTOOL_VERSION}

VOLUME /tmp

WORKDIR /tmp

CMD ["bash", "exiftool -G -j -fast4 -r ${SOURCE} > ${DESTINATION}" ]
