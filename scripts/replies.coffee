# Description:
#   A command that replies to things as specified in scripts/lib/messages
#
# Commands:
#   /.*hackEDU.*/i - Promptly reminds the user that we have changed names
#   /^hubot/i - Promptly reminds the user the bot's name has changed
#
# Author:
#   paked

msgs = require './lib/msgs'

module.exports = (robot) ->
  for reply in msgs.replies
    do (reply) ->
      robot.hear reply.regex, (msg) ->
        msg.send msg.random reply.cases
