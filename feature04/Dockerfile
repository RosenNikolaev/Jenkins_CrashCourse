# This Jenkins image runs on Debian 
FROM jenkins/jenkins:lts-jdk11
USER root
# Install packages used from the Jenkins node
## Depending on the underlying OS you may need to use a different package manager like yum, homebrw,  or rpm
RUN apt-get update && \
    apt-get -y install software-properties-common \
      maven  

# Remove initial jenkins configuration
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Copy the plugins.txt file inside of the container and install the plugins
COPY ./plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Make sure the /var/jenkins_home/ folder exists 
RUN mkdir -p /var/tmp/
# Copy the configuration in casc.yml to the Jenkins host
COPY ./casc.yaml /var/tmp/casc.yaml
# Set jenkins config path
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# Set the usr and pass for the admin user  
ENV JENKINS_ADMIN_USR admin
ENV JENKINS_ADMIN_PASS admin