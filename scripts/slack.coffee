_ = require 'lodash'
url = require 'url'
request = require 'request-promise'
Promise = require 'bluebird'
Slack = (require 'slack-api').promisify()

module.exports = (robot) ->
  token = process.env.HUBOT_SLACK_TOKEN

  robot.hear /who is missing (their )?(profile pictures|avatars)/i, (msg) ->
    msg.send "Bzzt! Crunching the numbers..."

    Slack.users.list(token: token)
      .then (resp) ->
        resp.members
      .filter (u) ->
        # Only users that have manually uploaded avatars to Slack have
        # `image_original` set
        true unless _.has u.profile, 'image_original'
      .filter (u) ->
        # Send an HTTP request to Gravatar to see if a Gravatar exists for the
        # user
        avatar_path = url.parse(u.profile.image_24).pathname

        request.head("https://secure.gravatar.com#{avatar_path}?d=404")
          .then ->
            false # Ignore users that have Gravatar pictures set
          .catch (err) ->
            true if err.statusCode == 404
      .then (users_without_avatars) ->
        names = _.pluck users_without_avatars, 'name'
        msg.send "These scoundrels haven't set their avatars yet: " + 
          names.join ', '
      .catch (err) ->
        msg.send "I'm terribly sorry, but I ran into an issue when crunching
        those numbers. Can you check my logs and fix me?"
