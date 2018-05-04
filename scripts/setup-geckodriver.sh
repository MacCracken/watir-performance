echo "#### Getting Geckodriver ####"
latest_geckodriver=latest
GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+)".*/\1/'); else echo $GECKODRIVER_VERSION; fi)
echo "Using GeckoDriver version: "$GK_VERSION 
wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz
tar -C /opt -zxf /tmp/geckodriver.tar.gz && rm /tmp/geckodriver.tar.gz 
sudo mv /opt/geckodriver /opt/geckodriver-$GK_VERSION 
sudo chmod 755 /opt/geckodriver-$GK_VERSION 
sudo ln -fs /opt/geckodriver-$GK_VERSION /usr/bin/geckodriver