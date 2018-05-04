#!/usr/bin/env bash
latest_chromedriver=$(wget -qO- http://chromedriver.storage.googleapis.com/LATEST_RELEASE)

echo "#### Getting Chromedriver $latest_chromedriver ####"
wget https://chromedriver.storage.googleapis.com/${latest_chromedriver}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo cp chromedriver /usr/bin/chromedriver
sudo chown root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
sudo chmod 755 /usr/bin/chromedriver
rm chromedriver*
sudo apt-get autoremove -y
