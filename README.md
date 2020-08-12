![Anbox Open Source ](/images/anbox.jpeg)

## Getting Started

### Prerequisites

* Anbox puts the Android operating system into a container, abstracts hardware access and integrates core system services into a GNU/Linux system. Every Android application will be integrated with your operating system like any other native application.
* Anbox currently support only Linux 5.4.55-1-LTS.
* `curl` or `wget` should be installed
* `git` should be installed (recommended v2.4.11 or higher)


### Basic Installation

Anbox is installed by running one of the following commands in your Terminal & Konsole. You can install this via the command-line with either `curl` or `wget`, whichever is installed on your machine.

#### via curl
```shell
cd ~/Downloads/
```

```shell
curl http://repo.koompi.org/pix/android-google_20200803.tar.gz -O
```

### Installation Step

```shell
tar -xzvf android-google_20200803.tar.gz
cd android-google
sh installer.sh
```

### Install APK From apk file
![Install APK ](/images/installapk.png)

Go to [Appmirror](https://appmirror.net/) and Download the apk you want to install. Open Dolphin and change directory to where you downloaded the apk file and right click on it and you will see the custom features to install apk file by right click.