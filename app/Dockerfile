# app/Dockerfile

FROM qt-base:5.15.17
ARG DEBIAN_FRONTEND=noninteractive
ARG PLATFORM=linux

LABEL maintainer="Maintainer name"
LABEL description="Qt Application Builder"

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    ninja-build \
    zlib1g-dev \
    libicu-dev \
    libssl-dev \
    libzstd-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libxcb1-dev \
    libxcb-util-dev \
    libxcb-icccm4-dev \
    libxcb-image0-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-render-util0-dev \
    libxcb-shape0-dev \
    libxcb-sync-dev \
    libxcb-xfixes0-dev \
    libxcb-xinerama0-dev \
    libxcb-xkb-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["/bin/bash"]