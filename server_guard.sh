gnome-terminal --tab --title="Guard/Spork" -e "bash -c \"guard;exec bash\"" --tab --title="Rails Server" -e "bash -c \"rails s -p 4200;exec bash\""
