#!/usr/bin/env bash
echo "#### Getting Chromedriver ####"
latest_chromedriver=$(wget -qO- http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget https://chromedriver.storage.googleapis.com/${latest_chromedriver}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo cp chromedriver /usr/local/bin/chromedriver
sudo chown root /usr/local/bin/chromedriver
sudo chmod +x /usr/local/bin/chromedriver
sudo chmod 755 /usr/local/bin/chromedriver
rm chromedriver*
