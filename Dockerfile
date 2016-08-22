############################################################
# Dockerfile to run a Django-based web application
# Based on an Ubuntu Image
############################################################

# Set the base image to use to Ubuntu
FROM django:onbuild

# Set the file maintainer (your name - the file's author)
MAINTAINER Héctor BlisS

# Set env variables used in this Dockerfile (add a unique prefix, such as FIXTER)
# Local directory with project source
ENV FIXTER_SRC=blog
# Directory in container for all project files
ENV FIXTER_SRVHOME=/srv
# Directory in container for project source files
ENV FIXTER_SRVPROJ=/srv/blog

# Update the default application repository sources list
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y python python-pip

# Create application subdirectories
WORKDIR $FIXTER_SRVHOME
RUN mkdir media static logs
VOLUME ["$FIXTER_SRVHOME/media/", "$FIXTER_SRVHOME/logs/"]

# Copy application source code to SRCDIR
COPY $FIXTER_SRC $FIXTER_SRVPROJ

# Install Python dependencies
RUN pip install -r $FIXTER_SRVPROJ/requirements.txt

# Port to expose
EXPOSE 8000

# Copy entrypoint script into the image
WORKDIR $FIXTER_SRVPROJ
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
