#!/bin/bash

BASE_GPIO_PATH=/sys/class/gpio

REC=10

ON="1"
OFF="0"

LAST_STATE=$OFF

exportPin()
{
	if [ ! -e $BASE_GPIO_PATH/gpio$1 ]; then
		echo "$1" > $BASE_GPIO_PATH/export
	fi
}

setOutput()
{
	echo "out" > $BASE_GPIO_PATH/gpio$1/direction
}

setLEDState()
{
	echo $2 > $BASE_GPIO_PATH/gpio$1/value
}

off()
{
	setLEDState $REC $OFF
}

shutdown()
{
	off
	exit 0
}

trap shutdown SIGINT

exportPin $REC
setOutput $REC
off

while [ 1 ]
do
	STATE=0
	if [ -f ".rec" ]; then
		STATE=1
	fi
	
	if [ "$STATE" != "$LAST_STATE" ]; then
		echo "change"
		setLEDState $REC $STATE
		LAST_STATE=$STATE
	fi
	sleep 2
done
