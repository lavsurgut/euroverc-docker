FROM ros:indigo-ros-base

RUN apt-get update && \
apt-get install -y wget

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.9
RUN set -x && \
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" && \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
    rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true

# set up gosu to run for other users

RUN chown root:users /usr/local/bin/gosu

RUN chmod +s /usr/local/bin/gosu

# add a non-root user to prevent files being created with root 
# permissions on host machine
# IMPORTANT: change this to your host user id and group id
ARG PUID=1000
ARG PGID=1000

RUN groupadd -g $PGID rosuser && \
    useradd -u $PUID -g rosuser -m rosuser -d /home/rosuser  && \
    chown $PUID:$PGID -R /home/rosuser && \
    echo "rosuser:rosuser" | chpasswd

RUN apt-get install -y build-essential libfreetype6 curl

RUN apt-get -y install libglu1-mesa-dev freeglut3-dev mesa-common-dev


# Python 3.4.2 setup - taken from http://github.com/docker-library/python/blob/master/3.4/Dockerfile

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENV PYTHON_VERSION 3.4.2

RUN set -x \
	&& mkdir -p /usr/src/python \
	&& curl -SL "https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz" \
		| tar -xJC /usr/src/python --strip-components=1 \
	&& cd /usr/src/python \
	&& ./configure --enable-shared \
	&& make -j$(nproc) \
	&& make install \
	&& ldconfig \
	&& find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& rm -rf /usr/src/python

# make some useful symlinks that are expected to exist
RUN cd /usr/local/bin \
	&& ln -s easy_install-3.4 easy_install \
	&& ln -s idle3 idle \
	&& ln -s pip3 pip \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& ln -s python-config3 python-config


# get Blender executable
RUN mkdir /opt/blender
RUN wget -q http://mirror.cs.umn.edu/blender.org/release/Blender2.73/blender-2.73-linux-glibc211-x86_64.tar.bz2 -O /opt/blender/blender-2.73.tar.bz2
WORKDIR /opt/blender
RUN tar jxf blender-2.73.tar.bz2

# Install Morse Robotic simulator, stable release
WORKDIR /usr/src
RUN git clone https://github.com/morse-simulator/morse -b 1.2_STABLE

WORKDIR /usr/src/morse

RUN mkdir build
WORKDIR /usr/src/morse/build
ENV MORSE_BLENDER /opt/blender/blender-2.73-linux-glibc211-x86_64/blender

RUN cmake -DBUILD_ROS_SUPPORT=ON ..
RUN make install

# get PyYAML
RUN wget http://pyyaml.org/download/pyyaml/PyYAML-3.10.tar.gz && \
tar -xvf PyYAML-3.10.tar.gz && \
cd PyYAML-3.10 && \
python3 setup.py install

# get python setup tools
RUN apt-get install -y python3-setuptools

# rospkg installation
RUN git clone git://github.com/ros/rospkg.git && \
cd rospkg && \
python3 setup.py install

# install catkin
RUN git clone git://github.com/ros-infrastructure/catkin_pkg.git -b 0.1.9 && \
cd catkin_pkg && \
python3 setup.py install && \
git clone git://github.com/ros/catkin.git && \
cd catkin && \
python3 setup.py install

RUN apt-get -y install xterm

# set PATH
ENV PATH ${PATH}:/usr/local/bin

# clean up apt lists
RUN rm -rf /var/lib/apt/lists/*    

# set default user to rosuser
USER rosuser

WORKDIR /home/rosuser
# set some variables for ROS and ROS GUI tools
ENV HOME /home/rosuser
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1

# set ROS environment variables for manual bash session (eg. via exec)
RUN printf "source /opt/ros/indigo/setup.bash" >> /home/rosuser/.bashrc

# run MORSE check
RUN morse check


