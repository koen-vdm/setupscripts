#!/bin/bash

echo "setup script; keep credentials at hand"

ssh_setup=false

print_ssh_key() {
    if [ "$ssh_setup" = false ] ; then
        read -p "Enter passphrase (empty for no passphrase) " passphrase
        ssh-keygen -t ecdsa -f ~/.ssh/id_ecdsa -q -N "$passphrase"
        ssh_setup=true
    fi
    echo "SSH key:"
    echo $(cat ~/.ssh/id_ecdsa.pub)
}

setup_bitbucket(){
    echo "add your key here: https://bitbucket.diasemi.com/plugins/servlet/ssh/account/keys"
    print_ssh_key
}

setup_github(){
    echo "add your key here: https://github.com/settings/keys"
    print_ssh_key
}

read -p "Do you want to install LPC-CS Python toolkit (you will need to setup bitbucket ssh key)? [Y/n] " ynAnswer

if [[ "$ynAnswer" = "" || "$ynAnswer" = "y" || "$ynAnswer" = "Y" ]]; then
    setup_bitbucket
    read -p "Press any key to continue after you copied the ssh key" continueKey
    echo "installing lpc-cs python tookit..."
    pip install git+ssh://git@bitbucket.diasemi.com:7999/lpc_cs/lpc_cs_toolkit.git
fi

read -p "You need to setup ssh in order to work with GitHub. Do you want to set this up now? [Y/n] " ynAnswer

if [[ "$ynAnswer" = "" || "$ynAnswer" = "y" || "$ynAnswer" = "Y" ]]; then
    setup_github
fi


echo "exiting..."