#! /usr/bin/zsh
cd storage/app/Vegifruit/
echo latest database backup is `ls -tr | grep zip | tail -n 1`
unzip `ls -tr | grep zip | tail -n 1`
mysql -u mmkumr -p  hungerrasoi < db-dumps/mysql-vegifruit.sql
if [ $? -eq 0 ]
then
    echo Database restored.
else
    echo Failed to restore.
fi
