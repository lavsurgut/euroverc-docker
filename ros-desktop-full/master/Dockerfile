FROM osrf/ros:indigo-desktop-full


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

# set PATH
ENV PATH ${PATH}:/usr/local/bin

# copy new extended entry point and set it up
COPY sear_entrypoint.sh /

RUN chmod +x /sear_entrypoint.sh


# clean up apt lists
RUN rm -rf /var/lib/apt/lists/*    

# set default user to rosuser
USER rosuser

# set some variables for ROS 
ENV HOME /home/rosuser

# set ROS environment variables for manual bash session (eg. via exec)
RUN printf "source /opt/ros/indigo/setup.bash" >> /home/rosuser/.bashrc



