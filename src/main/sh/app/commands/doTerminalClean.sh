_doTerminalClean() {
    read -s -n 1 -p "Press any key to continue..." && printf "\n"

    rm -rf ~/.cache/ ~/.config/ ~/.docker/ ~/.gnupg/ ~/.local/ ~/.nano/ ~/.bash_history ~/.selected_editor ~/.sudo_as_admin_successful

    history -c
    clear

}
