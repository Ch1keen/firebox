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
RUN         apt -y install chromium-browser

# Install & configure pulseaudio!!
RUN         apt -y install pulseaudio

# For supporting H.264
RUN         apt -y install chromium-codecs-ffmpeg

# Sudo
RUN         apt -y install sudo

# Firefox must not be run on root user
# Allow sudo without password
RUN         useradd chromium -m -G audio
RUN         echo "chromium ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER        chromium
