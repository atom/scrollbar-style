{Behavior} = require 'emissary'
{ScrollbarStyleObserver} = require('../build/Release/scrollbar-style-observer.node')

observer = new ScrollbarStyleObserver -> behavior.emitValue(observer.getPreferredScrollbarStyle())
behavior = new Behavior(observer.getPreferredScrollbarStyle())

module.exports = behavior
