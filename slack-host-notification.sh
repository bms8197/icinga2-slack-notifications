#!/bin/bash

ICINGA_HOSTNAME="Icinga2Web Hostname"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/TB231Z5XGC2E/B213BZRD3L4B/utiohjrekgns3misebfhk"
SLACK_CHANNEL="#monitor"
SLACK_BOTNAME="Icinga2"

#Set the message icon based on ICINGA Host state
if [ "$HOSTSTATE" = "DOWN" ]
then
    COLOR="danger"
elif [ "$HOSTSTATE" = "UP" ]
then
    COLOR="good"
else
    COLOR=""
fi

#Send message to Slack
read -d '' PAYLOAD << EOF
{
  "channel": "${SLACK_CHANNEL}",
  "username": "${SLACK_BOTNAME}",
  "attachments": [
    {
      "fallback": "${HOSTSTATE}: ${HOSTDISPLAYNAME}",
      "color": "${COLOR}",
      "fields": [
	{
	  "title": "",
          "value": "${LONGDATETIME} - ${SERVICEDESC} on ${HOSTALIAS}",
          "short": false
	},
	{
	  "title": "Type:",
          "value": "${NOTIFICATIONTYPE}",
          "short": false
        },
        {
          "title": "Host:",
          "value": "${HOSTNAME} (${HOSTADDRESS})",
          "short": false
        },
        {
          "title": "State:",
          "value": "${HOSTSTATE}",
          "short": false
        },
	{
          "title": "Info:",
          "value": "${HOSTOUTPUT}",
          "short": false
        }
      ]
    }
  ]
}
EOF

curl --connect-timeout 30 --max-time 60 -s -S -X POST -H 'Content-type: application/json' --data "${PAYLOAD}" "${SLACK_WEBHOOK_URL}"
