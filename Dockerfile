FROM alpine
WORKDIR /tmp

ENV DOWNLOAD_DIR="https://johnvansickle.com/ffmpeg/builds"
ENV ARCHIVE_NAME="ffmpeg-git-amd64-static.tar.xz"

# Install a few things we'll need
RUN apk add --update \
  wget \
  tar \
  xz

# Download the source files we'll need
RUN echo "Downloading files..." \
  && wget --timestamping "${DOWNLOAD_DIR}/${ARCHIVE_NAME}" \
  && wget --timestamping "${DOWNLOAD_DIR}/${ARCHIVE_NAME}.md5" \
  && echo "Validating..." \
  && md5sum "${ARCHIVE_NAME}" | tee -a "${ARCHIVE_NAME}.generated.md5" \
  && diff "${ARCHIVE_NAME}.generated.md5" "${ARCHIVE_NAME}.md5" || exit \
  && echo "Extracting..." \
  && tar xf "${ARCHIVE_NAME}" \
  && find */ -regex ".*/ff[a-z]*" -type f -exec mv {} /usr/local/bin \;

# Reset the workdir
WORKDIR /workdir
ENTRYPOINT ["/usr/local/bin/ffmpeg"]
