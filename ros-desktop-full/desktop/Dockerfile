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

# rights 755?
# video?


# fix the issue with usb camera connection

RUN sed -i 's/;UsbInterface=2/UsbInterface=0/' /etc/openni/GlobalDefaults.ini


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

# COPY 557-primesense-usb.rules /etc/udev/rules.d/

RUN rm -rf /var/lib/apt/lists/*    

USER rosuser

ENV HOME /home/rosuser
ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1


RUN printf "export QT_GRAPHICSSYSTEM=native\nsource /opt/ros/indigo/setup.bash" >> /home/rosuser/.bashrc







