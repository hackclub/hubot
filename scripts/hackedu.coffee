msgs = require './lib/msgs'

module.exports = (robot) ->
  robot.hear /hackedu/i, (msg) ->
    msg.send msg.random msgs.name_reminders
