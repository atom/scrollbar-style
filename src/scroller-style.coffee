{Behavior} = require 'emissary'
{ScrollerStyleObserver} = require('bindings')('scroller-style-observer')

observer = new ScrollerStyleObserver -> behavior.emitValue(observer.getPreferredScrollerStyle())
behavior = new Behavior(observer.getPreferredScrollerStyle())

module.exports = behavior
