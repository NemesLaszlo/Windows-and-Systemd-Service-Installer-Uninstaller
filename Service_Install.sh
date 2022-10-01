# Variables
SERVICE_NAME="NameOfTheService"
SERVICE_PATH="$PWD/NewService"
REQUIRED_PKG="packageName"

installService() {
# Check if service is active
IS_ACTIVE=$(sudo systemctl is-active $SERVICE_NAME)
if [ "$IS_ACTIVE" == "active" ]; then
    # Restart the service
    echo "Service is running"
    echo "Restarting service"
    sudo systemctl restart $SERVICE_NAME
    echo "Service restarted"
else
    # Create service file
    echo "Creating service file"
    sudo cat > /etc/systemd/system/${SERVICE_NAME}.service << EOF
[Unit]
Description=$SERVICE_NAME service

[Service]
Type=notify
WorkingDirectory=$PWD
ExecStart=$SERVICE_PATH

[Install]
WantedBy=multi-user.target
EOF
    # Restart daemon, enable and start service
    sudo chmod +x $SERVICE_PATH
    echo "Reloading daemon and enabling service"
    sudo systemctl daemon-reload 
    sudo systemctl enable ${SERVICE_NAME//'.service'/} # remove the extension
    sudo systemctl start ${SERVICE_NAME//'.service'/}  # remove the extension
    echo "Service Started"
fi
}

if [[ $1 != "" && $1 == "-f" ]]; then
    installService
else
    echo "Please install the $REQUIRED_PKG package with the available package manager (like apt, yum etc.)"
    read -n 1 -s -r -p "Press any key to continue or run this installer with -f argument to bypass this message"
    echo ""
    installService
fi

exit 0