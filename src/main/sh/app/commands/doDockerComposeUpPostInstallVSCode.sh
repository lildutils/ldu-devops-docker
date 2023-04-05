_doDockerComposeUpPostInstallVSCode() {
    cmd="echo \"#!/bin/sh\">/config/install-vscode.sh"
    ## upgrade vscode
    cmd="$cmd ; echo \"apt update\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"apt full-upgrade -y\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"apt autoremove -y\">>/config/install-vscode.sh"
    ## install devtools
    cmd="$cmd ; echo \"apt-get install -y build-essential inotify-tools curl htop mc nano net-tools\">>/config/install-vscode.sh"
    ## install git
    cmd="$cmd ; echo \"apt-get install -y git git-flow\">>/config/install-vscode.sh"
    ## install docker
    cmd="$cmd ; echo \"curl -sL https://get.docker.com -o /config/install-docker.sh\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"chmod 755 /config/install-docker.sh\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"/bin/sh /config/install-docker.sh\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"rm -rf /config/install-docker.sh\">>/config/install-vscode.sh"
    ## install docker-compose
    cmd="$cmd ; echo \"apt-get install -y docker-compose\">>/config/install-vscode.sh"
    ## check versions
    cmd="$cmd ; echo \"echo \$(git --version)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"echo git-flow version \$(git-flow version)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"echo \$(docker --version)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"echo \$(docker-compose --version)\">>/config/install-vscode.sh"
    ## check ownerships
    cmd="$cmd ; echo \"echo \$SUDO_USER, \$(id -u \$SUDO_USER):\$(id -g \$SUDO_USER)\">>/config/install-vscode.sh"
    cmd="$cmd ; echo \"chown -R \$SUDO_USER:\$SUDO_USER /works\">>/config/install-vscode.sh"

    sleep 5
    docker exec -i vscode bash -c "$cmd"
}
