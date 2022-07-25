<h1 align="center">Mobile Hacking ToolKit</h1>

<p align="center">
	<a href="https://github.com/hueristiq/mobile-hacking-toolkit/actions">
		<img alt="GitHub Workflow Status" src="https://img.shields.io/github/workflow/status/hueristiq/mobile-hacking-toolkit/🎉%20CI%20to%20Docker%20Hub">
	</a>
	<a href="https://github.com/hueristiq/mobile-hacking-toolkit/issues?q=is:issue+is:open">
		<img alt="GitHub Open Issues" src="https://img.shields.io/github/issues-raw/hueristiq/mobile-hacking-toolkit.svg">
	</a>
	<a href="https://github.com/hueristiq/mobile-hacking-toolkit/issues?q=is:issue+is:closed">
		<img alt="GitHub Closed Issues" src="https://img.shields.io/github/issues-closed-raw/hueristiq/mobile-hacking-toolkit.svg">
	</a>
	<a href="https://github.com/hueristiq/mobile-hacking-toolkit/graphs/contributors">
		<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/hueristiq/mobile-hacking-toolkit">
	</a>
	<a href="https://github.com/hueristiq/mobile-hacking-toolkit/blob/master/LICENSE">
		<img alt="GitHub" src="https://img.shields.io/github/license/hueristiq/mobile-hacking-toolkit">
	</a>
</p>

<p align="center">
	<a href="https://hub.docker.com/r/hueristiq/mobile-hacking-toolkit/">
		<img alt="Docker Automated build" src="https://img.shields.io/docker/automated/hueristiq/mobile-hacking-toolkit">
	</a>
	<a href="https://hub.docker.com/r/hueristiq/mobile-hacking-toolkit/">
		<img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/hueristiq/mobile-hacking-toolkit">
	</a>
	<a href="https://hub.docker.com/r/hueristiq/mobile-hacking-toolkit/">
		<img alt="Docker Starts" src="https://img.shields.io/docker/stars/hueristiq/mobile-hacking-toolkit">
	</a>
	<a href="https://hub.docker.com/r/hueristiq/mobile-hacking-toolkit/">
		<img alt="Docker Image Size" src="https://img.shields.io/docker/image-size/hueristiq/mobile-hacking-toolkit/latest">
	</a>
</p>

A mobile hacking toolkit (docker image).

## Resources

* [Installation](#installation)
	* [Docker](#docker)
	* [Docker Compose](#docker-compose)
	* [Build from Source](#build-from-source)
* [GUI Support](#gui-support)
	* [Using SSH with X11 forwarding](#using-ssh-with-x11-forwarding)
* [Toolkit Setup](#toolkit-setup)
	* [System](#system)
	* [Tools](#tools)
* [Contribution](#contribution)

## Installation

### Docker

Pull the image from Docker Hub:

```bash
docker pull hueristiq/mobile-hacking-toolkit
```

Run a container and attach a shell:

```bash
docker run \
	-it \
	--rm \
	--shm-size="2g" \
	--name mobile-hacking-toolkit \
	--hostname mobile-hacking-toolkit \
	-p 22:22 \
	-v $(pwd)/data:/root/data \
	hueristiq/mobile-hacking-toolkit \
	/bin/bash
```
### Docker Compose

Docker-Compose can also be used.

```yaml
version: "3.9"

services:
    mobile-hacking-toolkit:
        image: hueristiq/mobile-hacking-toolkit
        container_name: mobile-hacking-toolkit
        hostname: mobile-hacking-toolkit
        stdin_open: true
        shm_size: 2gb # increase shared memory size to prevent firefox from crashing
        ports:
            - "22:22" # exposed for GUI support sing SSH with X11 forwarding
        volumes:
            - ./data:/root/data
        restart: unless-stopped
```

Build and run container:

```bash
docker-compose up
```

Attach shell:

```bash
docker-compose exec mobile-hacking-toolkit /bin/bash
```

### Build from Source

Clone this repository and build the image:

```bash
git clone https://github.com/hueristiq/mobile-hacking-toolkit.git && \
cd mobile-hacking-toolkit && \
make build-image
```

Run a container and attach a shell:

```bash
make run
```

## GUI Support

By default, no GUI tools can be run in a Docker container as no X11 server is available. To run them, you must change that. What is required to do so depends on your host machine. If you:

* run on Linux, you probably have X11
* run on Mac OS, you need Xquartz (`brew install Xquartz`)
* run on Windows, you have a problem

### Using SSH with X11 forwarding

Use X11 forwarding through SSH if you want to go this way. Run `start_ssh` inside the container to start the server, make sure you expose port 22 when starting the container: `docker run -p 127.0.0.1:22:22 ...`, then use `ssh -X ...` when connecting (the script prints the password).

## Toolkit Setup

### System

* Terminal
	- Shell (ZSH)
	- Session Management (TMUX)
* Text Editor
	- vim
* Browser
	- firefox
* Remote Connection
	- SSH

### Tools

Many different Linux and Windows tools are installed. Windows tools are supported with [Wine](https://www.winehq.org/). Some tools can be used on the command line while others require GUI support!

| OS   | Type | Name | Description |
| :--: | :--: | :--- | :---------- |
| Android | - | [adb](https://developer.android.com/studio/command-line/adb) | Android Debug Bridge (adb) is a versatile command-line tool that lets you communicate with a device. |
| Android | Analysis | [apkleaks](https://github.com/dwisiswant0/apkleaks) | Scanning APK file for URIs, endpoints & secrets. |
| Android | RE | [apktool](https://ibotpeaches.github.io/Apktool/) | A tool for reverse engineering Android apk files |
| - | Proxy | [Burp Suite Community](https://portswigger.net/burp) | A swiss army knife for pentesting networks . |
| Android | RE | [bytecode-viewer](https://github.com/Konloch/bytecode-viewer/) | A Java 8+ Jar & Android APK Reverse Engineering Suite (Decompiler, Editor, Debugger & More) |
| - | RE | [frida](https://github.com/frida/frida) | The ultimate WinRM shell for hacking/pentesting. |
| Android | - | [googleplay](https://github.com/89z/googleplay) | Download APK from Google Play or send API requests |
| Android | RE | [jadx](https://github.com/skylot/jadx) | Dex to Java decompiler |
| Android/iOS/Windows | Scanner | [Mobile Security Framework (MobSF)](https://github.com/MobSF/Mobile-Security-Framework-MobSF) | Mobile Security Framework (MobSF) is an automated, all-in-one mobile application (Android/iOS/Windows) pen-testing, malware analysis and security assessment framework capable of performing static and dynamic analysis. |
| iOS/Android | Analysis | [objection](https://github.com/sensepost/objection) | objection is a runtime mobile exploration toolkit, powered by Frida, built to help you assess the security posture of your mobile applications, without needing a jailbreak. |
| Android | Scanner | [qark](https://github.com/linkedin/qark) | Tool to look for several security related Android application vulnerabilities |
| - | - | [Runtime Mobile Security (RMS)](https://github.com/m0bilesecurity/RMS-Runtime-Mobile-Security) | TCP port scanner, spews SYN packets asynchronously, scanning entire Internet in under 5 minutes. |

## Contribution

[Issues](https://github.com/hueristiq/mobile-hacking-toolkit/issues) and [Pull Requests](https://github.com/hueristiq/mobile-hacking-toolkit/pulls) are welcome!
