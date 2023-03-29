clean() {
    _doDockerClean

    _doRemoveFolder "$DEVOPS_DATA_DIR/"
    _doRemoveFolder "$BIN/$DEVOPS_ROOT_DIR/"

    _doDockerGarbageCollect
    _doTerminalClean
}
