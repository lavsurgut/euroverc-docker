FROM ros:indigo-ros-base

# add a non-root user to prevent files being created with root 
# permissions on host machine
# and add User to video group
# IMPORTANT: change this to your host user id and group id
ARG PUID=1000
ARG PGID=1000

RUN groupadd -g $PGID rosuser && \
    useradd -u $PUID -g rosuser -m rosuser -d /home/rosuser  && \
    usermod -a -G video rosuser && \
    adduser rosuser sudo && \
    chown $PUID:$PGID -R /home/rosuser && \
    echo "rosuser:rosuser" | chpasswd

USER rosuser



