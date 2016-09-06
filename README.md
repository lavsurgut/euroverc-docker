
<b>Getting started with ROS and Docker:</b>

1) Installation.

1.1) Read official getting started manual from docker about docker and docker-compose:

<url>https://docs.docker.com/</url>

P.S: Or find one of the "lighter" tutorials in the web. But be aware that they get a bit outdated very fast.


2) Perform installation of docker and docker-compose

Follow instruction of official docker docs for your OS. 

3) Try out basic ROS Docker rostutorials project with docker and docker-compose in this repository. It follows best practices described in the offical ROS Docker Hub page:

<url>https://hub.docker.com/_/ros/</url>

Folder rostutorials contains configured docker-compose.yml and DockerFile. But you can try from scratch if you want using the instruction in the link above.

Run docker-compose to build and start needed containers from this folder: 

<code>docker-compose up -d</code>

P.S: Add option --build in case you want to rebuild containers. Check help file for docker-compose for other use cases.

P.S: in case of issues with internet access from container, for example, look at official Docker Installation guide (listed above) in "Optional configurations". Often, DNS name resolution is a problem, so check DNS settings as described in the document.

4) You can now see logs from listener or talker:

<code>docker-compose logs listener</code>

5) Also you can login into running master container:

<code>docker-compose exec master bash </code>

<code>source /ros_entrypoint.sh</code>

And observe ROS topics:

<code>rostopic list</code>

6) Other folders, like ros-desktop-full contain installations for other useful images. Follow instructions in the relevant folder.






