

<b>Getting started with desktop ROS docker containers</b>:


1) Given compose file configures example desktop for the use in example ROS project.
It has configuration for ASUS Xtion PRO Live camera.

P.S: In order to work on given host machine, make sure Xtion camera is properly
installed on this machine first. This rule is also applicable to any device
connected to host and planned to using in docker container (e.g GPU).
For example, for Ubuntu 14.04: follow instructions for Openni2 installation:

<url>http://openni.ru/openni-sdk/index.html</url>

2) Docker compose file for the desktop image uses shared volumes.

This means that these paths are being mounted from the host machine.
When docker container will be rebuilt, everything that resides in this folder
will not be deleted. Otherwise everything in the docker container is deleted.
This is very useful for sharing source code for example. 
In this example, desktop container will share "../../project" folder with project
source code and also X11 folder to be able to display GUI from the container.

Additionaly we mount USB device for our Xtion camera and GPU (for Intel Video 
Card).

3) Checkout needed source code repository from git in the host machine. All 
git changes shall be executed in the host in order for docker container to
provide clean and static runtime environment.

You have to check out the development branch

<code>git checkout development</code>

Init and update submodules

<code>git submodule init</code>
<code>git submodule update</code>


4) Login into desktop as the rosuser:

<code>docker-compose run desktop bash</code>

You also can login inside with root user:

<code>docker-compose run --user=root desktop bash</code>

5) If you haven't yet compiled the source files for the project, compile them as the rosuser (login to the desktop container like in step 4)

6) Now you should be able to run compiled packages from the container.

7) After that you should be able to run

<code>docker-compose up -d --build</code>

This command will rebuild if needed changes to docker images configuration and
start nodes, specified in the compose file automatically.

