# Variables
SERVICE_NAME="NameOfTheService"
SERVICE_PATH="$PWD/NewService"

# Remove systemd service
echo "Removing $SERVICE_NAME service"
sudo systemctl stop $SERVICE_NAME
sudo systemctl disable $SERVICE_NAME
sudo rm /etc/systemd/system/${SERVICE_NAME}.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
echo "Remove of $SERVICE_NAME service was successful"
echo "----------------------------------------------"

exit 0