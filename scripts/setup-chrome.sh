#!/usr/bin/env bash
#echo "#### Getting Chrome ####"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt-get update 
sudo apt-get install google-chrome-stable

#echo "#### Getting Chromedriver ####"
latest_chromedriver=$(wget -qO- http://chromedriver.storage.googleapis.com/LATEST_RELEASE)
wget https://chromedriver.storage.googleapis.com/${latest_chromedriver}/chromedriver_linux64.zip
unzip chromedriver_linux64.zip
sudo cp chromedriver /usr/bin/chromedriver
sudo chown root /usr/bin/chromedriver
sudo chmod +x /usr/bin/chromedriver
sudo chmod 755 /usr/bin/chromedriver
rm chromedriver*
sudo apt-get autoremove -y
