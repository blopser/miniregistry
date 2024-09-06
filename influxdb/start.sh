set -ex

usermod -u ${USER_ID} influxdb
groupmod -g ${GROUP_ID} influxdb 
