scrollbarStyle = require '../src/scrollbar-style'

describe "scrollbar-style", ->
  describe "getPreferredScrollbarStyle()", ->
    it "returns the preferred scrollbar style", ->
      style = scrollbarStyle.getPreferredScrollbarStyle()
      expect(style is 'legacy' or style is 'overlay').toBe true

  describe "onDidPreferredScrollbarStyleChange(callback)", ->
    it "returns a disposable", ->
      disposable = scrollbarStyle.onDidPreferredScrollbarStyleChange ->
      disposable.dispose()
