const scrollbarStyle = require('../lib/binding.js');

describe("scrollbar-style", function() {
  describe("getPreferredScrollbarStyle()", () => {
    it("returns the preferred scrollbar style", () => {
      const style = scrollbarStyle.getPreferredScrollbarStyle();
      expect(['legacy', 'overlay'].includes(style)).toBe(true);
    });
  });

  describe("onDidChangePreferredScrollbarStyle(callback)", () => {
    it("returns a disposable", () => {
      const disposable = scrollbarStyle.onDidChangePreferredScrollbarStyle(function() {});
      return disposable.dispose();
    });
  });

  describe("observePreferredScrollbarStyle(callback)", () => {
    it("calls back immediately with the style", () => {
      const callback = jasmine.createSpy()
      const disposable = scrollbarStyle.observePreferredScrollbarStyle(callback);
      disposable.dispose();

      expect(callback).toHaveBeenCalledTimes(1);
      const [style] = callback.calls.argsFor(0);
      expect(['legacy', 'overlay'].includes(style)).toBe(true);
    });
  });
});
