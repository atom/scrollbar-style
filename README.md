# Scroller Style

This package detects the preferred scroller style for Atom on OS X using the
`+preferredScrollerStyle` method on [`NSScroller`][ns-scroller].

```coffee
{getPreferredScrollerStyle} = require 'scroller-style'
getPreferredScrollerStyle() # ==> "legacy" or "overlay"
```

[ns-scroller]: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSScroller_Class/Reference/Reference.html
