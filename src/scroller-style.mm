#import <node.h>
#import "nan.h"
#import <AppKit/NSScroller.h>

using namespace v8;

NAN_METHOD(GetPreferredScrollerStyle) {
  NanScope();

  if ([NSScroller preferredScrollerStyle] == NSScrollerStyleOverlay) {
    NanReturnValue(String::New("overlay"));
  } else {
    NanReturnValue(String::New("legacy"));
  }
}

void InitAll(Handle<Object> exports) {
  exports->Set(NanSymbol("getPreferredScrollerStyle"),
    FunctionTemplate::New(GetPreferredScrollerStyle)->GetFunction());
}

NODE_MODULE(scroller_style, InitAll)
