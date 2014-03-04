#ifndef SRC_SCROLLER_STYLE_OBSERVER_H_
#define SRC_SCROLLER_STYLE_OBSERVER_H_

#include "nan.h"

using namespace v8;  // NOLINT

class ScrollerStyleObserver : public node::ObjectWrap {
 public:
  static void Init(Handle<Object> target);
  void HandleScrollerStyleChanged();

 private:
  ScrollerStyleObserver(NanCallback *callback);
  ~ScrollerStyleObserver();
  static NAN_METHOD(New);
  static NAN_METHOD(GetPreferredScrollerStyle);

  NanCallback *callback;
};

#endif  // SRC_SCROLLER_STYLE_OBSERVER_H_
