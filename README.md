# Scrollbar Style

This package detects the preferred scroller style for Atom on OS X using the
`+preferredScrollerStyle` method on [`NSScroller`][ns-scroller]. For
compatibility, this library always returns "legacy" on Windows and Linux.

The module exports a reactive-style [behavior][emissary] representing the
current scrollbar style. You can get the behavior's value with `::getValue` or
subscribe to the current and all future values with `::onValue`. Callbacks
passed to `::onValue` are called immediately and then whenever the scrollbar
style preference changes.

```coffee
scrollbarStyle = require 'scrollbar-style'
scrollbarStyle.getValue() # ==> 'legacy' or 'overlay'
scrollbarStyle.onValue (style) -> # ...
```

[ns-scroller]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSScroller_Class/Reference/Reference.html
[emissary]: https://github.com/atom/emissary
