#import <node.h>
#import "nan.h"
#import "scrollbar-style-observer.h"

using namespace v8;

void ScrollbarStyleObserver::Init(Handle<Object> target) {
  NanScope();
  Local<FunctionTemplate> newTemplate = FunctionTemplate::New(ScrollbarStyleObserver::New);
  newTemplate->SetClassName(NanSymbol("ScrollbarStyleObserver"));
  newTemplate->InstanceTemplate()->SetInternalFieldCount(1);
  Local<ObjectTemplate> proto = newTemplate->PrototypeTemplate();
  NODE_SET_METHOD(proto, "getPreferredScrollbarStyle", ScrollbarStyleObserver::GetPreferredScrollbarStyle);
  target->Set(NanSymbol("ScrollbarStyleObserver"), newTemplate->GetFunction());
}

NODE_MODULE(scrollbar_style_observer, ScrollbarStyleObserver::Init)

NAN_METHOD(ScrollbarStyleObserver::New) {
  NanScope();

  Local<Function> callbackHandle = args[0].As<Function>();
  NanCallback *callback = new NanCallback(callbackHandle);

  ScrollbarStyleObserver *observer = new ScrollbarStyleObserver(callback);
  observer->Wrap(args.This());
  NanReturnUndefined();
}

ScrollbarStyleObserver::ScrollbarStyleObserver(NanCallback *callback) : callback(callback) {
}

ScrollbarStyleObserver::~ScrollbarStyleObserver() {
  delete callback;
};

void ScrollbarStyleObserver::HandleScrollbarStyleChanged() {
}

NAN_METHOD(ScrollbarStyleObserver::GetPreferredScrollbarStyle) {
  NanScope();
  NanReturnValue(String::New("legacy"));
}
