# Run script in background even with closed terminal

nohup ./your_script.sh > output.log 2>&1 & # nohup - ignore signal SIGHUP (close session)