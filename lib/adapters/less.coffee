Adapter = require '../adapter_base'
W = require 'when'

class Less extends Adapter
  constructor: (@compiler) ->
    @name = 'less'
    @extensions = ['less']
    @output = 'css'

  _render: (str, options) ->
    deferred = W.defer()

    parser = new @compiler.Parser(options)
    parser.parse str, (err, tree) ->
      if err then return deferred.reject(err)
      try
        deferred.resolve(tree.toCSS())
      catch err
        deferred.reject(err)

    return deferred.promise

module.exports = Less
