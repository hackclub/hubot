# Description:
#   A command for reminding people that our name has changed from hackEDU to Hack Club
#
# Commands:
#   /.*hackEDU.*/i - Promptly reminds the user that we have changed names
#
# Author:
#   paked

msgs = require './lib/msgs'

module.exports = (robot) ->
  robot.hear /hackedu/i, (msg) ->
    msg.send msg.random msgs.name_reminders
