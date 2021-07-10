#!/bin/bash
git clone https://jenkins@blrgithub.radisys.com/scm/alm/es/mrtool.git /home/jenkins/mrtool
cd /home/jenkins/mrtool/
git checkout AP_master
cp -rf ../dist dist
mkdir -p media

## cronjob schedule changes
service cron status
service cron start
echo "root" > /etc/cron.allow
touch /var/spool/cron/crontabs/root
/usr/bin/crontab /var/spool/cron/crontabs/root
echo "*/5 * * * * /bin/sh /home/jenkins/mrtool/aprequest_create_through_mail.sh" >> /var/spool/cron/crontabs/root
##
#git checkout skillmgmt_dev_int
sudo cp -rf mrconf.conf  /etc/nginx/sites-available/default
pip install uwsgi
python manage.py collectstatic
cp -rf static/css/* dist/mr/static/css
cp -rf static/js/* dist/mr/static/js
cp -rf static/admin static/rest_framework dist/mr/static/
# Restart Ngnix
sudo /etc/init.d/nginx start || sudo /etc/init.d/nginx start
# Running Celery
celery -A MRToolBackEnd worker -l info &

# Running Server
uwsgi --socket mysite.sock --module MRToolBackEnd.wsgi --buffer-size=100000 --chmod-socket=666 --master --processes 4 --threads 2

