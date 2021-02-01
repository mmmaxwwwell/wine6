FROM debian:buster
WORKDIR /root
RUN mkdir /scripts

RUN \
  dpkg --add-architecture i386 &&\
  apt update && apt upgrade -y &&\
  apt install curl gnupg2 software-properties-common -y &&\
  curl https://dl.winehq.org/wine-builds/winehq.key | apt-key add - &&\
  apt-add-repository https://dl.winehq.org/wine-builds/debian/ &&\
  apt-add-repository non-free &&\
  apt update &&\
  curl -L https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/i386/libfaudio0_20.01-0~buster_i386.deb > libfaudio0_20.01-0~buster_i386.deb &&\
  curl -L https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/amd64/libfaudio0_20.01-0~buster_amd64.deb > libfaudio0_20.01-0~buster_amd64.deb &&\
  dpkg -i --force-depends libfaudio0_20.01-0~buster_i386.deb &&\
  dpkg -i --force-depends libfaudio0_20.01-0~buster_amd64.deb &&\
  apt install -f -y &&\
  apt install --install-recommends winehq-stable -y &&\
  rm *.deb &&\
  echo steam steam/question select "I AGREE" | debconf-set-selections &&\
  apt install steamcmd xvfb cabextract unzip -y &&\
  apt purge software-properties-common gnupg2 python* -y &&\
  apt autoclean &&\
  apt autoremove -y &&\
  curl -L https://raw.githubusercontent.com/Winetricks/winetricks/master/src/winetricks > /scripts/winetricks &&\
  chmod +x /scripts/winetricks &&\
  adduser wine --disabled-password --gecos "" 