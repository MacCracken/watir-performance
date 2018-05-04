echo "#### Getting Geckodriver ####"
GK_VERSION=0.20.1
echo "Using GeckoDriver version: "$GK_VERSION 
wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz
tar -C /opt -zxf /tmp/geckodriver.tar.gz && rm /tmp/geckodriver.tar.gz 
sudo chmod 755 /opt/geckodriver
export PATH=$PATH:/opt/geckodriver
