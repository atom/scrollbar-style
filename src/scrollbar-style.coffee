{Emitter} = require 'event-kit'
{ScrollbarStyleObserver} = require '../build/Release/scrollbar-style-observer.node'

emitter = new Emitter()
observer = new ScrollbarStyleObserver ->
  emitter.emit 'did-preferred-scrollbar-style-change', exports.getPreferredScrollbarStyle()

exports.getPreferredScrollbarStyle = ->
  observer.getPreferredScrollbarStyle()

exports.onDidPreferredScrollbarStyleChange = (callback) ->
  emitter.on 'did-preferred-scrollbar-style-change', callback
