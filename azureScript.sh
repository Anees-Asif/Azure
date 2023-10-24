#!/bin/bash

# update & upgrade
sudo apt update -y
sudo apt upgrade -y

# install nginx
sudo apt install nginx -y

# setup nginx reverse proxy
sudo apt install sed
# $ and / characters must be escaped by putting a backslash before them
sudo sed -i "s/try_files \$uri \$uri\/ =404;/proxy_pass http:\/\/localhost:3000\/;/" /etc/nginx/sites-available/default

# restart nginx 
sudo systemctl restart nginx

#enable nginx

sudo systemctl enable nginx

# install nodejs 12.x
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y

# install pm2 (only necessary later)
sudo npm install pm2 -g

# clone repo with app folder into folder called 'repo' - only needed if don't have the app folder already
sudo apt install git -y

git clone https://github.com/Anees-Asif/sparta-test-app.git repo

# install the app (must be after db vm is finished provisioning)
cd repo
cd app
npm install

# start the app (could also use 'npm start')
pm2 start app.js