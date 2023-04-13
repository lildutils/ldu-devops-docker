_doPostInstallVSCode() {
    mkdir -p $DIR_DEVOPS/.tmp/

    curl -sL "$FILE_DEVOPS_VSCODE" -o $DIR_DEVOPS/.tmp/install-vscode.sh
    nano $DIR_DEVOPS/.tmp/postinstall-vscode.sh

    docker cp vscode:/config/install-vscode.sh $DIR_DEVOPS/.tmp/install-vscode.sh
    docker cp vscode:/config/postinstall-vscode.sh $DIR_DEVOPS/.tmp/postinstall-vscode.sh

    docker exec -it vscode sh -c \
        "chmod 755 /config/install-vscode.sh && \
         chmod 755 /config/postinstall-vscode.sh && \
         sudo /bin/sh /config/install-vscode.sh"
}
