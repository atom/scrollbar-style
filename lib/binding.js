const {ScrollbarStyleObserver} = require('../build/Release/scrollbar-style-observer-native');
const { Emitter } = require('event-kit')

const emitter = new Emitter();
const observer = new ScrollbarStyleObserver(() => emitter.emit('did-change-preferred-scrollbar-style', exports.getPreferredScrollbarStyle()));

exports.getPreferredScrollbarStyle = () => observer.getPreferredScrollbarStyle();

exports.onDidChangePreferredScrollbarStyle = callback => emitter.on('did-change-preferred-scrollbar-style', callback);

exports.observePreferredScrollbarStyle = (callback) => {
  callback(exports.getPreferredScrollbarStyle());
  return exports.onDidChangePreferredScrollbarStyle(callback);
};
