FROM kalilinux/kali-rolling:latest

LABEL org.hueristiq.image.authors="Alex Munene (enenumxela)"

ARG MHT=/etc/network-hacking-toolkit
ARG HOME=/root
ARG LOCAL_BIN=${HOME}/.local/bin

ARG DEBIAN_FRONTEND=noninteractive

ENV \
	MHT=${MHT} \
	HOME=${HOME} \
	LOCAL_BIN=${LOCAL_BIN}

RUN \
	# up(date|grade)
	apt-get update && \
	apt-get upgrade -qq -y && \
	# create a folder in /etc to store compressed files
	if [ ! -d ${MHT} ];\
	then \
		mkdir -p ${MHT};\
	fi && \
	if [ ! -d ${LOCAL_BIN} ];\
	then \
		mkdir -p ${LOCAL_BIN};\
	fi

# copy the files
COPY scripts.7z ${MHT}/scripts.7z 
COPY configurations.7z ${MHT}/configurations.7z

RUN \
	# install p7zip-full
	apt-get install -y -qq --no-install-recommends \
		p7zip-full && \
	# p7zip extract scripts
	7z x ${MHT}/scripts.7z -o/tmp  && \
	# run setup
	for script in $(find /tmp/scripts -maxdepth 1 -type f -name "*-setup*" -print | sort); \
	do \
		echo ${script}; \
		chmod +x ${script}; \
		${script}; \
	done && \
	# make scrips executable
	chmod +x /tmp/scripts/* && \
	# move scripts to user bin
	mv -f /tmp/scripts/* ${LOCAL_BIN}

WORKDIR $HOME