#!/bin/sh -l

echo "Host $1" >> /root/.ssh/config

if [ -z $6 ] && [ -z $7 ]
then
    echo "ProxyCommand cloudflared access ssh --hostname %h" >> /root/.ssh/config
else
    echo "ProxyCommand cloudflared access ssh --hostname %h --id $6 --secret $7" >> /root/.ssh/config
fi

echo "$5" > /root/.ssh/$4
chmod 600 /root/.ssh/$4

ssh-keyscan $1 >> /root/.ssh/known_hosts

ssh -T -q -o StrictHostKeyChecking=no $3@$1

scp -p -i /root/.ssh/$4 -P $2 ./$8 $3@$1:$9