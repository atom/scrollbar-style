{Emitter} = require 'event-kit'
{ScrollbarStyleObserver} = require '../build/Release/scrollbar-style-observer.node'

emitter = new Emitter()
observer = new ScrollbarStyleObserver ->
  emitter.emit 'did-preferred-scrollbar-style-change', observer.getPreferredScrollbarStyle()

module.exports =
  getPreferredScrollbarStyle: ->
    observer.getPreferredScrollbarStyle()

  onDidPreferredScrollbarStyleChange: (callback) ->
    emitter.on 'did-preferred-scrollbar-style-change', callback
