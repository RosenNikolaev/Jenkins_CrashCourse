# This Jenkins image runs on Debian 
FROM jenkins/jenkins:lts-jdk11
USER root
# Install packages used from the Jenkins node
## Depending on the underlying OS you may need to use a different package manager like yum, homebrw,  or rpm
RUN apt-get update && \
    apt-get -y install software-properties-common \
      maven \ 
      python3  


