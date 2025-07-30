#This script is used to enable / start the speedtest tool
LOG_FILE=/rdklogs/logs/speedtest-init.log

log_message() {
    echo "$(date +"[%Y-%m-%d %H:%M:%S]") $1" >> $LOG_FILE
}

execute_speedtest() {
    log_message "$1"
    $2
}

log_message "Enabling / Starting speedtest..."
. /etc/device.properties

# If Device.IP.Diagnostics.X_RDKCENTRAL-COM_SpeedTest.ClientType exists, then:
# Device.IP.Diagnostics.X_RDKCENTRAL-COM_SpeedTest.ClientType = 1 implies the C client should run.
ST_CLIENT_TYPE=`dmcli eRT retv Device.IP.Diagnostics.X_RDKCENTRAL-COM_SpeedTest.ClientType`
server_ip=`dmcli eRT retv Device.IP.Diagnostics.X_RDKCENTRAL-COM_SpeedTest.Argument`

if [ "x$ST_CLIENT_TYPE" = 'x1' ]; then
    if [ -f /usr/bin/RefSpeedtestClient ]; then
        if [ ! -z "$server_ip" ]; then  
              execute_speedtest "Executing speedtest-client-c for $Box_Type" "nice -n 19 /usr/bin/RefSpeedtestClient $server_ip"
        else
              execute_speedtest "Executing speedtest-client-c for $BOX_TYPE" "nice -n 19 /usr/bin/RefSpeedtestClient"
        fi     
    else
        log_message "Unsupported device model"
    fi
else
    log_message "Unsupported client"
fi
