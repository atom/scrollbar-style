# Scrollbar Style [![Build Status](https://travis-ci.org/atom/scrollbar-style.svg?branch=master)](https://travis-ci.org/atom/scrollbar-style)

This package detects the preferred scroller style for Atom on OS X using the
`+preferredScrollerStyle` method on [`NSScroller`][ns-scroller]. For
compatibility, this library always returns "legacy" on Windows and Linux.

```coffee
scrollbarStyle = require 'scrollbar-style'

style = scrollbarStyle.getPreferredScrollbarStyle()
console.log(style) # ==> 'legacy' or 'overlay'

scrollbarStyle.onDidChangePreferredScrollbarStyle (newStyle) ->
  console.log('style changed', newStyle)
```

[ns-scroller]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSScroller_Class/Reference/Reference.html
