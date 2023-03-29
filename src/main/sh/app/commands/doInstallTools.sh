_doInstallTools() {
    __doInstallToolsOSUpgrade
    __doInstallToolsDevTools
    __doInstallToolsUFW
    __doInstallToolsFail2ban
}

__doInstallToolsOSUpgrade() {
    apt-get update -y
    apt-get full-upgrade -y
    apt-get autoremove -y
}

__doInstallToolsDevTools() {
    apt-get install -y curl htop mc nano net-tools ufw fail2ban
}

__doInstallToolsUFW() {
    systemctl start ufw
    systemctl enable ufw
    ufw enable
    ufw default deny incoming
    ufw default deny outgoing
    for rule in ${UFW_ALLOW_IN//,/ }; do
        ufw allow in $rule
    done
    for rule in ${UFW_ALLOW_OUT//,/ }; do
        ufw allow out $rule
    done
    ufw reload
}

__doInstallToolsFail2ban() {
    systemctl start fail2ban
    systemctl enable fail2ban
    echo "[sshd]" >/etc/fail2ban/jail.local
    echo "enabled = true" >>/etc/fail2ban/jail.local
    echo "port = 22" >>/etc/fail2ban/jail.local
    echo "filter = sshd" >>/etc/fail2ban/jail.local
    echo "logpath = /var/log/auth.log" >>/etc/fail2ban/jail.local
    echo "maxretry = $FAIL2BAN_MAX_RETRY" >>/etc/fail2ban/jail.local
    systemctl restart fail2ban
}
