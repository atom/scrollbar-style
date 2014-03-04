{Behavior} = require 'emissary'
{ScrollbarStyleObserver} = require('bindings')('scrollbar-style-observer')

observer = new ScrollbarStyleObserver -> behavior.emitValue(observer.getPreferredScrollbarStyle())
behavior = new Behavior(observer.getPreferredScrollbarStyle())

module.exports = behavior
