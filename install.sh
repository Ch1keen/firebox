# This file must be run on super user.

help_page() {
    echo
    echo "Usage : $0 [option]"
    echo
    echo "    firefox   : Install firebox on this system."
    echo "    uninstall : remove firebox from this system."

    exit 1
}

install_firefox() {
    echo "!!!WARNING!!! This script will install firebox for all user."
    echo "Please beware of this."
    echo

    # Check for docker installed
    if [ ! -x "/usr/bin/docker" ]; then
        echo "Docker not found. Did you installed docker?"
    exit 1
    fi

    # Build the 'firefox' image
    docker build --no-cache -t ch1keen/firebox-firefox ./firefox

    if [ -f ./firebox ]; then
        sudo cp ./firebox /usr/bin/ \
        && echo "Succesfully Installed." \
        || echo "You're not permitted. Installation failed."

    else
        echo "File 'firebox' does not exist. Get this file from my github:"
        echo "$ git clone https://github.com/Ch1keen/firebox"
    fi
}

uninstall() {
    # Container must be stopped
    if [ "$(docker ps -f "name=firefox" | grep firefox)" ]; then
        echo "Firebox : Firefox container is running."
        echo "Firebox : Container must be stopped in order to uninstall"
        exit 1
    fi

    # remove container from docker
    if [ "$(docker ps -af "name=firefox" | grep firefox)" ]; then
        docker rm firefox
        echo "Firebox : Container 'firefox' successfully removed."
    else
        echo "Firebox : Container 'firefox' does not exist"
    fi

    # remove docker image
    if [ "$(docker images | grep firebox-firefox)" ]; then
        docker rmi ch1keen/firebox-firefox
        echo "Firebox : Image 'firefox' successfully removed."
    else
        echo "Firebox : Image 'firebox-firefox' does not exist"
    fi

    # remove /usr/bin/firebox
    if [ -f /usr/bin/firebox ]; then
        sudo rm /usr/bin/firebox
        echo "Firebox : Removed aliased file."
    else
        echo "Firebox : /usr/bin/firebox File is missing"
    fi

    echo "Firebox : Uninstallation complete."
}



if [ $# == 0 ]; then
    help_page

elif [ $1 == "firefox" ]; then
    install_firefox

elif [ $1 == "uninstall" ]; then
    uninstall

else
    echo "Cannot recognize option '$1'."
    help_page
fi
