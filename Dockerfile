FROM		ubuntu:18.04
MAINTAINER	ch1keen@protonmail.com

# Repository update
RUN		apt -y update

# NO TOFU!
RUN		apt -y install fonts-noto fonts-noto-cjk fonts-noto-cjk-extra

# Korean IM
RUN		apt -y install fcitx fcitx-hangul

# Set default IM fcitx
ENV		GTK_IM_MODULE=fcitx
ENV		QT_IM_MODULE=fcitx
ENV		XMODIFIERS=@im=fcitx

# Install firefox!!
RUN		apt -y install firefox

# Install & configure pulseaudio!!
RUN		apt -y install pulseaudio

# For supporting H.264
RUN		apt -y install ubuntu-restricted-extras

# Firefox must not be run on root user
RUN		useradd firefox -m -G audio
USER		firefox
