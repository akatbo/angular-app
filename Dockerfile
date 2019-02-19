# s2i-angular-build
FROM openshift/base-centos7

LABEL maintainer="Thabo Mpele <akatbo@gmail.com>"

# ENV BUILDER_VERSION 1.0

LABEL io.k8s.description="Platform for building Modern Web Applications that use Node.js" \
      io.k8s.display-name="Nodejs" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,Angular" \
      # io.openshift.s2i.destination="/opt/app" \
      io.openshift.s2i.scripts-url=image:///usr/local/s2i

# RUN yum install -y ... && yum clean all -y
RUN yum install -y curl && \
    yum install -y epel-release && \
    yum -y install gcc, c++, make && \
    #yum curl -sL https://rpm.nodesource.com/setup_10.x | sudo -E bash - && \
    yum curl -sL https://rpm.nodesource.com/setup_10.x | -E bash - && \
    yum install -y nodejs && \
    yum clean all -y
RUN npm install -g @angular/cli

COPY ./s2i/bin/ /usr/local/s2i

RUN chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8080

CMD ["/usr/local/s2i/usage"]
