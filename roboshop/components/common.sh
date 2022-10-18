ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[36m Try executing the script with sudo or a root \e[0m"
    exit 1
fi

stat() {
    if [ $1 -eq 0] ; then
        echo -e "\e[36m Success \e[0m"
    else
        echo -e "\e[31m Failure. Look for the log \e[0m"
    fi
}