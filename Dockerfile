# Dockerfile to build image from JBoss EAP 6.4
FROM registry.access.redhat.com/jboss-eap-6/eap64-openshift:1.8-21

#FROM artifacts.karops.io/kar/builder/eap64-standard:latest
MAINTAINER  Prasana Korumilli

# Change jvm max and min heap size
ENV _JAVA_OPTIONS -Xms1303m -Xmx1303m 

EXPOSE 8080 8443 9990 9999

# Copy war to deployments folder'
COPY welcome.war   $JBOSS_HOME/standalone/deployments

# Deploy app
#ADD welcome.war "$JBOSS_HOME/standalone/deployments"

# Change to user root to update owner of application binary
USER root

# Change owner to jboss for the war to be deployed
RUN chown jboss:jboss  $JBOSS_HOME/standalone/deployments/welcome.war

#remove xml_history file
RUN rm -rf  $JBOSS_HOME/standalone/configuration/standalone_xml_history

# Expose jboss ports
#EXPOSE 8080 9990 9999

# change user to jboss
USER jboss
