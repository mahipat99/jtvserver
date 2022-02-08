# This scripts perform installation of required dependencies on termux

#!/bin/bash

apt update
apt --yes --allow-downgrades -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

# Install nodejs
apt install nodejs-lts -y

if [ $? -eq 0 ]; then
   echo "Installation successful"
else
    echo "Failed to install nodejs. Exiting"
    exit 1
fi

# Get the latest release of code
wget https://github.com/jtvserver/jtvserver.github.io/releases/download/1.2/JTVServer.zip

if [ $? -eq 0 ]; then
   echo "Downloaded the server successfully. "
else
    echo "Failed to download the server. Is wget installed?"
    exit 1
fi

# Unzip the downloaded file
unzip JTVServer.zip

if [ $? -eq 0 ]; then
   echo "File unzipped"
else
    echo "Failed to unzip the file"
    exit 1
fi

rm JTVServer.zip

if [ $? -eq 0 ]; then
   echo "Deleted source"
else
    echo "Failed to delete the source"
fi

cd JTVServer
if [ $? -eq 0 ]; then
   echo "Opened source"
else
    echo "Failed to open source. Is the directory present ? Exiting"
    exit 1
fi

echo "Installing dependencies"
npm install
npm update -g
npm audit fix

if [ $? -eq 0 ]; then
   echo "Dependencies installation successful."
else
    echo "Failed to install dependencies. Exiting"
    exit 1
fi

echo "Downloading start server script"
cd ~
wget https://github.com/jtvserver/jtvserver.github.io/releases/download/1.2/start.sh
if [ $? -eq 0 ]; then
   echo "Script downloaded successfully"
else
    echo "Failed to download start script. Please run wget https://github.com/jtvserver/jtvserver.github.io/releases/download/1.2/start.sh to download"
    exit 1
fi

cd ~
echo "==========================================================="
echo "INSTALLATION COMPLETED"
echo "RUN SERVER START SCRIPT TO START THE SERVER"
echo "==========================================================="
