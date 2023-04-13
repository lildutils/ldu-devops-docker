_doTerminalClean() {
    _doTerminalPause

    rm -rf ~/.cache/ ~/.config/ ~/.docker/ ~/.gnupg/ ~/.local/ ~/.nano/ ~/.bash_history ~/.selected_editor ~/.sudo_as_admin_successful

    history -c
    clear
}
