# restore.sh
#!/bin/sh

yum install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

aws s3 cp s3://${backup_bucket_name}/$(date '+%Y-%m-%d')/jenkins_home_backup.zip /restore

unzip  /restore/jenkins_home_backup.zip  -d /restore

chown -R 1000:1000 /restore/var

cp -avr /restore/var/jenkins_home/. /var/jenkins_home




