FROM osrf/ros:indigo-desktop-full
# add OpenCV
# add drivers for INTEL video cards support
# add move-it package
# add openni2

# OpenCV installation

RUN apt-get update && \
apt-get install -y wget unzip

RUN wget -c -O opencv-2.4.13.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.13/opencv-2.4.13.zip/download && \
unzip opencv-2.4.13.zip

RUN cd opencv-2.4.13 && \
mkdir release && cd release && \
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=\/usr\/local \
-D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON \
-D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=OFF -D WITH_OPENGL=ON -D WITH_OPENCL=OFF .. && \
make -j 4 && make install && \
sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf' && \
ldconfig



RUN apt-get -y install software-properties-common

RUN add-apt-repository -y ppa:v-launchpad-jochen-sprickerhof-de/pcl

RUN apt-get update && \
apt-get -y install libpcl-all 

RUN apt-get -y install libgl1-mesa-glx libgl1-mesa-dri

RUN apt-get -y install ros-indigo-moveit-full


RUN apt-get -y install ros-indigo-libg2o

RUN apt-get -y install libserial-dev    

RUN apt-get -y install ros-indigo-openni2-launch

RUN apt-get -y install vim

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


# fix the issue with usb camera connection

RUN sed -i 's/;UsbInterface=2/UsbInterface=0/' /etc/openni/GlobalDefaults.ini


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

USER rosuser

ENV HOME /home/rosuser
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1
ENV QT_GRAPHICSSYSTEM native



RUN printf "source /opt/ros/indigo/setup.bash" >> /home/rosuser/.bashrc

ENTRYPOINT ["/sear_entrypoint.sh"]










