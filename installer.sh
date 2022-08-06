#set IP to 192.168.1.22 for eth0
#set IP to 192.168.1.32 for wlan0

###main dir###
cp -rv * .* */ .*/ ~
rm ~/$0

###whatsapp bot###
sudo apt install nodejs npm
npm install --prefix ~/raspy/WAP/ node-watch fs os qrcode-terminal whatsapp-web.js
sudo npm install forever -g
#write ~/raspy/WAP/WABot.js
printf "\n\n\n_______________________________\n" 
echo "insert your whatsapp number phone to recive info"
read phoneNumber
mkdir /home/phi/raspy/bing-rewards/
touch /home/phi/raspy/bing-rewards/points.txt
sed -i 's/insert-phone-number/'$phoneNumber'/g' ~/raspy/WAP/WABot.js
cd ~/raspy/WAP/
node ~/raspy/WAP/WABot.js
cd -

###set driver and bing rewards###
sudo apt install git
git clone https://github.com/jjjchens235/bing-rewards.git ~/git/bing-rewards
cp -rv ~/git/bing-rewards ~/raspy
sudo apt install chromium-browser chromium-chromedriver python pip
pip install -r ~/raspy/bing-rewards/BingRewards/requirements.txt
printf "\n\n\n_______________________________\n" 
python3 ~/raspy/bing-rewards/setup.py
python3 ~/raspy/bing-rewards/BingRewards/BingRewards.py
#write ~/raspy/BingRewBot.sh (chmod 777)

###crontab###

