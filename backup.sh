# backup.sh
#!/bin/sh

yum install zip unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install

zip -r /backup/jenkins_home_backup.zip /var/jenkins_home

aws s3 cp /backup/jenkins_home_backup.zip s3://${backup_bucket_name}/$(date '+%Y-%m-%d')/jenkins_home_backup.zip


