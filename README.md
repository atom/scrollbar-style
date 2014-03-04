# Scroller Style

This package detects the preferred scroller style for Atom on OS X using the
`+preferredScrollerStyle` method on [`NSScroller`][ns-scroller].

The module exports a reactive-style [behavior][emissary] representing the
current scroller style. You can get the behavior's value with `::getValue` or
subscribe to the current and all future values with `::onValue`. Callbacks
passed to `::onValue` are called immediately and then whenever the scroller
style preference changes.

```coffee
scrollerStyle = require 'scroller-style'
scrollerStyle.getValue() # ==> 'legacy' or 'overlay'
scrollerStyle.onValue (style) -> # ...
```

[ns-scroller]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSScroller_Class/Reference/Reference.html
[emissary]: https://github.com/atom/emissary
