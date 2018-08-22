install() {
    if [ ! -x "/usr/bin/docker" ]; then
        echo "Docker not found. Is docker installed?"
	exit 1
    fi

    cp ./
}

pulseaudio="-v /var/run/dbus:/var/run/dbus"

if [ $# == 0 ]; then
    echo
    echo "Usage : $0 [option]"
    echo
    echo "    install   : Install firebox on this system."
    echo "    uninstall : remove firebox from this system."

elif [ $1 == "install" ]; then
    install

elif [ $1 == "uninstall" ]; then
    uninstall

fi
