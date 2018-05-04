echo "#### Getting Geckodriver ####"
latest_geckodriver=latest
GK_VERSION=$(if [ ${GECKODRIVER_VERSION:-latest} = "latest" ]; then echo $(wget -qO- "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+)".*/\1/'); else echo $GECKODRIVER_VERSION; fi)
echo "Using GeckoDriver version: "$GK_VERSION 
wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GK_VERSION/geckodriver-v$GK_VERSION-linux64.tar.gz
sudo tar -C /usr/local -zxf /tmp/geckodriver.tar.gz 
sudo mv /usr/local/geckodriver /usr/local/geckodriver-$GK_VERSION 
sudo chmod 755 /usr/local/geckodriver-$GK_VERSION 
