#! /bin/bash

# --MAC---------------------------------
# MAC設定 need gcloud
gcloud init
STAFF_NAME="$(whoami)"
GCP_STORAGE_NAME=storage-"$STAFF_NAME"
sudo ln -s /usr/local/sbin/mount_gcsfuse /sbin  # For mount(8) support
mkdir -p ~/gcp_storage
echo "gcsfuse $GCP_STORAGE_NAME ~/gcp_storage" | sudo tee -a /etc/rc.local > /dev/null
echo " 📦 ---> gcsfuse mount ~/gcp_storage done ! "
