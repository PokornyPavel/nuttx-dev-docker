FROM debian:bookworm

ARG UNAME=pavel
ARG UID=1000
ARG GID=1000

# non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# set timezone
ENV TZ=Europe/Prague
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# install applications
RUN apt-get update
RUN apt-get install -y \
    bison flex gettext texinfo libncurses5-dev locales \
    libncursesw5-dev xxd gperf automake libtool pkg-config \
    build-essential genromfs libgmp-dev libmpc-dev \
    libmpfr-dev libisl-dev binutils-dev libelf-dev git \
    libexpat-dev gcc-multilib g++-multilib picocom \
    u-boot-tools util-linux kconfig-frontends sudo \
    gcc-arm-none-eabi binutils-arm-none-eabi\
    python3-kconfiglib openocd vim

# set the locale
RUN locale-gen en_US.UTF-8
RUN update-locale

# create new user
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash -G sudo $UNAME

# set root password
RUN echo "$UNAME:root" | chpasswd

USER $UNAME
WORKDIR /home/$UNAME/src