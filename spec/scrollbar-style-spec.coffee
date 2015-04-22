scrollbarStyle = require '../src/scrollbar-style'

describe "scrollbar-style", ->
  describe "getPreferredScrollbarStyle()", ->
    it "returns the preferred scrollbar style", ->
      style = scrollbarStyle.getPreferredScrollbarStyle()
      expect(style in ['legacy', 'overlay']).toBe true

  describe "onDidChangePreferredScrollbarStyle(callback)", ->
    it "returns a disposable", ->
      disposable = scrollbarStyle.onDidChangePreferredScrollbarStyle ->
      disposable.dispose()

  describe "observePreferredScrollbarStyle(callback)", ->
    it "calls back immediately with the style", ->
      callback = jasmine.createSpy('callback')
      disposable = scrollbarStyle.observePreferredScrollbarStyle(callback)
      disposable.dispose()

      expect(callback.callCount).toBe 1
      [style] = callback.argsForCall[0]
      expect(style in ['legacy', 'overlay']).toBe true
