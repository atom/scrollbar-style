#import <node.h>
#import "nan.h"
#import "scroller-style-observer.h"

using namespace v8;

void ScrollerStyleObserver::Init(Handle<Object> target) {
  NanScope();
  Local<FunctionTemplate> newTemplate = FunctionTemplate::New(ScrollerStyleObserver::New);
  newTemplate->SetClassName(NanSymbol("ScrollerStyleObserver"));
  newTemplate->InstanceTemplate()->SetInternalFieldCount(1);
  Local<ObjectTemplate> proto = newTemplate->PrototypeTemplate();
  NODE_SET_METHOD(proto, "getPreferredScrollerStyle", ScrollerStyleObserver::GetPreferredScrollerStyle);
  target->Set(NanSymbol("ScrollerStyleObserver"), newTemplate->GetFunction());
}

NODE_MODULE(scroller_style_observer, ScrollerStyleObserver::Init)

NAN_METHOD(ScrollerStyleObserver::New) {
  NanScope();

  Local<Function> callbackHandle = args[0].As<Function>();
  NanCallback *callback = new NanCallback(callbackHandle);

  ScrollerStyleObserver *observer = new ScrollerStyleObserver(callback);
  observer->Wrap(args.This());
  NanReturnUndefined();
}

ScrollerStyleObserver::ScrollerStyleObserver(NanCallback *callback) : callback(callback) {
}

ScrollerStyleObserver::~ScrollerStyleObserver() {
  delete callback;
};

void ScrollerStyleObserver::HandleScrollerStyleChanged() {
}

NAN_METHOD(ScrollerStyleObserver::GetPreferredScrollerStyle) {
  NanScope();
  NanReturnValue(String::New("legacy"));
}
