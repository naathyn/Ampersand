gnome-terminal --tab --title="Development" -e "bash -c \"clear;exec bash\"" --tab --title="Guard/Spork" -e "bash -c \"clear;guard;exec bash\"" --tab --title="Rails Server" -e "bash -c \"clear;rails s;exec bash\""
sleep 32;gnome-terminal --tab -e "bash -c \"x-www-browser http://localhost:3000;exit;exec bash\""
