gnome-terminal --tab --title="Development" -e "bash -c \"clear;exec bash\"" --tab --title="Guard/Spork" -e "bash -c \"guard;exec bash\"" --tab --title="Rails Server" -e "bash -c \"rails s;exec bash\""
sleep 33;gnome-terminal --tab -e "bash -c \"x-www-browser http://localhost:3000;exit;exec bash\""
