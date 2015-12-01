# Description:
#   A command for reminding people of name changes
#
# Commands:
#   /.*hackEDU.*/i - Promptly reminds the user that we have changed names
#   /^hubot/i - Promptly reminds the user the bot's name has changed
#
# Author:
#   paked

msgs = require './lib/msgs'

module.exports = (robot) ->
  robot.hear /hackedu/i, (msg) ->
    msg.send msg.random msgs.org_name_reminders

  robot.hear /^hubot/i, (msg) ->
    msg.send msg.random msgs.bot_name_reminders
