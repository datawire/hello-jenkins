FROM alpine:3.4
MAINTAINER Datawire Inc, <dev@datawire.io>
EXPOSE 5000

LABEL PROJECT_REPO_URL         = "git@github.com:datawire/hello-jenkins.git"
LABEL PROJECT_REPO_BROWSER_URL = "https://github.com/datawire/hello-jenkins"
LABEL DESCRIPTION              = "Datawire hello jenkins"
LABEL VENDOR                   = "Datawire"
LABEL VENDOR_URL               = "https://datawire.io/"

ENV JAVA_HOME=/usr/lib/jvm/default-jvm

RUN apk add --update bash && \
    apk add --no-cache openjdk8 && \
    ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/" && \
    rm -rf /var/cache/apk/*

COPY hello-jenkins-web/build/libs/hello-jenkins-web-*-fat.jar /opt/hello-jenkins/
RUN  ln -s /opt/hello-jenkins/hello-jenkins-web-*-fat.jar /opt/hello-jenkins/hello-jenkins-web.jar

ENTRYPOINT ["java", \
            "-Dvertx.logger-delegate-factory-class-name=io.vertx.core.logging.SLF4JLogDelegateFactory", \
            "-Dlogback.configurationFile="/opt/hello-jenkins/logback.xml", \
            "-jar",  "/opt/hello-jenkins/hello-jenkins-web.jar", \
            "-conf", "/opt/hello-jenkins/hello-jenkins.json"] 
