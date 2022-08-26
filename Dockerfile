# The Jenkins image runs on Debian 
FROM jenkins/jenkins:lts-jdk11
USER root
# Depending on the underlying OS you may need to use a different package manager like yum, homebrw,  or rpm
RUN apt-get update && apt-get install -y maven
RUN apt-get update && apt-get install -y python3
USER jenkins