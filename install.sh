# This file must be run on super user.

help_page() {
    echo
    echo "Usage : $0 [option]"
    echo
    echo "    install   : Install firebox on this system."
    echo "    uninstall : remove firebox from this system."

    exit 1
}

install() {
    echo "!!!WARNING!!! This script will install firebox for all user."
    echo "Please beware of this."
    echo

    # Check for docker installed
    if [ ! -x "/usr/bin/docker" ]; then
        echo "Docker not found. Is docker installed?"
    exit 1
    fi

    if [ -f ./firebox ]; then
        sudo cp ./firebox /bin/ \
    && echo "Succesfully Installed." \
    || echo "You're not permitted. Try 'sudo $0 install'." \

    else
    echo "firebox does not exist."
    fi
}

uninstall() {
    if [ -f /bin/firebox ]; then
        sudo rm /bin/firebox

    else
    echo "File is missing"

    fi
}



if [ $# == 0 ]; then
    help_page

elif [ $1 == "install" ]; then
    install

elif [ $1 == "uninstall" ]; then
    uninstall

else
    echo "Cannot recognize option '$1'."
    help_page
fi
