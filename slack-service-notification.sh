#!/bin/bash

ICINGA_HOSTNAME="Icinga2Web Hostname"
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/TB231Z5XGC2E/B213BZRD3L4B/utiohjrekgns3misebfhk"
SLACK_CHANNEL="#monitor"
SLACK_BOTNAME="Icinga2"

#Set the message icon based on ICINGA service state
if [ "$SERVICESTATE" = "CRITICAL" ]
then
    COLOR="danger"
elif [ "$SERVICESTATE" = "WARNING" ]
then
    COLOR="warning"
elif [ "$SERVICESTATE" = "OK" ]
then
    COLOR="good"
elif [ "$SERVICESTATE" = "UNKNOWN" ]
then
    COLOR="#800080"
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
      "fallback": "${SERVICESTATE}: ${HOSTDISPLAYNAME} - ${SERVICEDISPLAYNAME}",
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
          "value": "${SERVICESTATE}",
          "short": true
        },
	{
          "title": "Info:",
          "value": "${SERVICEOUTPUT}",
          "short": false
        }
      ]
    }
  ]
}
EOF

curl --connect-timeout 30 --max-time 60 -s -S -X POST -H 'Content-type: application/json' --data "${PAYLOAD}" "${SLACK_WEBHOOK_URL}"slack-service-notification.sh
