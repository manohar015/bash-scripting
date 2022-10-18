ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[36m Try executing the script with sudo or a root \e[0m"
    exit 1
fi