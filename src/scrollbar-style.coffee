{Emitter} = require 'event-kit'
{ScrollbarStyleObserver} = require '../build/Release/scrollbar-style-observer.node'

emitter = new Emitter()
observer = new ScrollbarStyleObserver ->
  emitter.emit 'did-change-preferred-scrollbar-style', exports.getPreferredScrollbarStyle()

exports.getPreferredScrollbarStyle = ->
  observer.getPreferredScrollbarStyle()

exports.onDidChangePreferredScrollbarStyle = (callback) ->
  emitter.on 'did-change-preferred-scrollbar-style', callback

exports.observePreferredScrollbarStyle = (callback) ->
  callback(exports.getPreferredScrollbarStyle())
  exports.onDidChangePreferredScrollbarStyle(callback)
