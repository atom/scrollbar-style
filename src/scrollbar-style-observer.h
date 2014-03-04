#ifndef SRC_SCROLLER_STYLE_OBSERVER_H_
#define SRC_SCROLLER_STYLE_OBSERVER_H_

#include "nan.h"

using namespace v8;  // NOLINT

class ScrollbarStyleObserver : public node::ObjectWrap {
 public:
  static void Init(Handle<Object> target);
  void HandleScrollbarStyleChanged();

 private:
  ScrollbarStyleObserver(NanCallback *callback);
  ~ScrollbarStyleObserver();
  static NAN_METHOD(New);
  static NAN_METHOD(GetPreferredScrollbarStyle);

  NanCallback *callback;
};

#endif  // SRC_SCROLLER_STYLE_OBSERVER_H_
