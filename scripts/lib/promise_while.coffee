Promise = require 'bluebird'

# From http://blog.victorquinn.com/javascript-promise-while-loop
promiseWhile = (condition, action) ->
  resolver = Promise.defer()

  loopFn = ->
    if !condition()
      return resolver.resolve()
    Promise.cast(action()).then(loopFn).catch resolver.reject

  process.nextTick loopFn
  resolver.promise

module.exports = promiseWhile
