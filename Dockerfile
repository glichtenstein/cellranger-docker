###############################################
### Dockerfile for 10X Genomics Cell Ranger ###
###############################################

# Based on
# Tiandao Li <litd99@gmail.com>
# https://github.com/litd/docker-cellranger/blob/master/Dockerfile

FROM centos:latest

# File Author / Maintainer
MAINTAINER Gabriel Lichtenstein <gabriel.lichtenstein@gmail.com>

# To migrate from CentOS 8 to CentOS Stream 8, run the following commands:
dnf --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos
dnf distro-sync


# Install some utilities
RUN dnf install -y \
	file \
	git \
	sssd-client \
	which \
	wget \
	unzip

# Install bcl2fastq v2.20.0.422
RUN cd /tmp/ && \
	wget http://regmedsrv1.wustl.edu/Public_SPACE/litd/Public_html/pkg/bcl2fastq2-v2.20.0.422-Linux-x86_64.rpm && \
	yum -y --nogpgcheck localinstall bcl2fastq2-v2.20.0.422-Linux-x86_64.rpm && \
	rm -rf bcl2fastq2-v2.20.0.422-Linux-x86_64.rpm
 	
# Install cellranger 7.0.0
RUN cd /opt/ && \
	wget http://regmedsrv1.wustl.edu/Public_SPACE/litd/Public_html/pkg/cellranger-7.0.0.tar.gz && \	
	tar -xzvf cellranger-6.1.1.tar.gz && \
	rm -f cellranger-6.1.1.tar.gz

# path
ENV PATH /opt/cellranger-7.0.0:$PATH

