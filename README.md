# icinga2-slack-notifications
Integrate Icinga2 with Slack and send notifications to a Slack channel #monitor

Example:

![Icinga2 Service Issue Notification](https://club3d.ro/git/icinga1.png "Icinga2 Slack screenshot")
![Icinga2 Service Recovery Notification](https://club3d.ro/git/icinga2.png "Icinga2 Slack screenshot")

The scripts were initially taken from this repo: https://github.com/jjethwa/icinga2-slack-notification

I've modified them to suit my needs and also for a better output to Slack since the default output was pretty hard to read and also I wanted more details, for each notification, to be displayed on the Slack channel

Step by step instructions:

You need to setup an Incoming Webhook on your Slack (https://api.slack.com/incoming-webhooks). Select a Slack #channel that you're going to use for Icinga2 notifications (the notifications will be sent to that specific Slack #channel).

When you're done with that, an URL like this will be generated: https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX

This url has to be used in the slack-host-notification.sh and slack-service-notification.sh scripts (replace the SLACK_WEBHOOK_URL from those files with your own generated Webhook URL from Slack).

By default, Icinga2 configuration files are in /etc/icinga2/conf.d folder.

1) Edit /etc/icinga2/conf.d/commands.conf file and place, at the end, the content of commands.conf file from this repo
2) Edit /etc/icinga2/conf.d/templates.conf file and place, at the end, the content of templates.conf file from this repo
3) Edit /etc/icinga2/conf.d/notifications.conf file and place, at the end, the content of notifications.conf file from this repo
4) Save slack-host-notification.sh script from this repo and place it to /etc/icinga2/scripts
5) Save slack-service-notification.sh script from this repo and place it to /etc/icinga2/scripts
6) Make the above 2 scripts executable by issuing this command: chmod +x /etc/icinga2/scripts/slack*

Reload your Icinga2 service by issuing: systemctl reload icinga2

Test and see if it works!
