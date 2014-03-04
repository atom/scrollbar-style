#import <node.h>
#import "nan.h"
#import <AppKit/NSScroller.h>
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

uv_loop_t *loop = uv_default_loop();
uv_async_t async;

static void notificationHandler(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  async.data = observer;
  uv_async_send(&async);
}

static void asyncSendHandler(uv_async_t *handle, int status /*UNUSED*/) {
  (static_cast<ScrollerStyleObserver *>(handle->data))->HandleScrollerStyleChanged();
}

ScrollerStyleObserver::ScrollerStyleObserver(NanCallback *callback) : callback(callback) {
  uv_async_init(loop, &async, asyncSendHandler);

  CFNotificationCenterAddObserver(
      CFNotificationCenterGetLocalCenter(),
      this,
      &notificationHandler,
      CFSTR("NSPreferredScrollerStyleDidChangeNotification"),
      NULL,
      CFNotificationSuspensionBehaviorDeliverImmediately
  );
}

ScrollerStyleObserver::~ScrollerStyleObserver() {
  delete callback;
};

void ScrollerStyleObserver::HandleScrollerStyleChanged() {
  callback->Call(0, NULL);
}

NAN_METHOD(ScrollerStyleObserver::GetPreferredScrollerStyle) {
  NanScope();

  if ([NSScroller preferredScrollerStyle] == NSScrollerStyleOverlay) {
    NanReturnValue(String::New("overlay"));
  } else {
    NanReturnValue(String::New("legacy"));
  }
}
