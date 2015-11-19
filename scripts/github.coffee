# Description:
#   Commands for interaction with GitHub
#
# Configuration:
#   HUBOT_GITHUB_ORGANIZATION - The GitHub organization to query
#
# Commands:
#   hubot count contributions - Give a report of issues and pull requests closed over the past week.

Octokat = require 'octokat'
_ = require 'lodash'
promiseWhile = require './lib/promise_while'
msgs = require './lib/msgs'

module.exports = (robot) ->

  robot.respond /count contribution[s]?|contribution[s]? count/i, (msg) ->
    DAYS_BACK = 7
    ORG = process.env.HUBOT_GITHUB_ORGANIZATION

    msg.send msg.random msgs.initializing

    countContributions(ORG, DAYS_BACK)
    .then (results) ->
      msg.send results
    .catch (err) ->
      console.log err
      msg.send msg.random msgs.error

# GitHub event description maps. This maps GitHub event names (like IssueEvent)
# to human-readable descriptions
githubEventDescriptions =
  IssuesEvent: "Issues closed"
  PullRequestEvent: "Pull requests closed"

fetchEvents = (org, daysBack, options) ->
  octo = new Octokat

  fetchUntil = new Date
  fetchUntil.setDate(fetchUntil.getDate() - daysBack)

  options = options || {}
  options.page = options.page || 1

  allEvents = []
  keepGoing = true

  promiseWhile(
    -> keepGoing
    ->
      octo.orgs(org).events.fetch(options)
      .then (events) ->
        options.page++

        lastCreatedAt = events[events.length - 1].createdAt
        keepGoing = Date.parse(lastCreatedAt) > Date.parse(fetchUntil)

        allEvents = _.union(allEvents, events)
  )
  .then ->
    allEvents

statEventToString = (count, eventName) ->
  "- #{githubEventDescriptions[eventName]}: #{count}"

statToString = (events, username) ->
  """
  #{username}

  #{_.map(events, statEventToString).join('\n')}
  """

countContributions = (org, daysBack) ->
  fetchEvents(org, daysBack)
  .then (events) ->
    _.filter events, (e) -> e.payload.action == "closed"
  .then (closedEvents) ->
    stats = {}

    _.each closedEvents, (event) ->
      username = event.actor.login

      # Initialize stats for the user if it doesn't already exist
      stats[username] = stats[username] || {}
      stats[username][event.type] = stats[username][event.type] || 0

      # Increment the event type count
      stats[username][event.type]++

    """
    GitHub contributions from the past #{daysBack} days:

    #{_.map(stats, statToString).join('\n\n')}
    """
