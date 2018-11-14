GK_VERSION=0.23.0
echo "#### Getting Geckodriver version: " $GK_VERSION
wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz
tar -C /opt -zxf /tmp/geckodriver.tar.gz && rm /tmp/geckodriver.tar.gz 
sudo chmod 755 /opt/geckodriver
sudo ln -fs /opt/geckodriver-$GK_VERSION /usr/local/bin/geckodriver
export PATH="$PATH:/user/local/bin/geckodriver"