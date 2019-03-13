# Get newServer
newServer="$1"
# Get currentServer
currentServer="$(grep -oE 'server +[a-zA-Z0-9_.]+:' /etc/nginx/nginx.conf | grep -oE '[a-zA-Z0-9_.]+:' | grep -oE '[a-zA-Z0-9_.]+')"

# Checks to see currentServer == newServer
if [ "${newServer}" = "${currentServer}" ];
then
    # Prints out message and exits
    echo "Same server, no update has been made"
    exit 0;
else
# Update text, aka find and replace
sed -i "s/server \+[a-zA-Z0-9_.]\+:/server ${newServer}:/g" /etc/nginx/nginx.conf

# Reload configurations
/usr/sbin/nginx -s reload
fi
