FROM		ubuntu:18.04
LABEL	    maintainer="ch1keen@protonmail.com"

# Repository update
RUN         apt -y update

# NO TOFU!
RUN         apt -y install fonts-noto fonts-noto-cjk fonts-noto-cjk-extra

# Korean IM
RUN         apt -y install fcitx fcitx-hangul

# Set default IM fcitx
ENV         GTK_IM_MODULE=fcitx
ENV         QT_IM_MODULE=fcitx
ENV         XMODIFIERS=@im=fcitx

# Install browsers!!
RUN         apt -y install firefox

# Install & configure pulseaudio!!
RUN         apt -y install pulseaudio

# For supporting H.264
RUN         apt -y install ubuntu-restricted-extras

# Sudo
RUN         apt -y install sudo

# Firefox must not be run on root user
# Allow sudo without password
RUN         useradd firefox -m -G audio
RUN         echo "firefox ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER        firefox
