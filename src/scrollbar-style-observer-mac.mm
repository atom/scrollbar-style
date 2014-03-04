#import <node.h>
#import "nan.h"
#import <AppKit/NSScroller.h>
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

uv_loop_t *loop = uv_default_loop();
uv_async_t async;

static void notificationHandler(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  async.data = observer;
  uv_async_send(&async);
}

static void asyncSendHandler(uv_async_t *handle, int status /*UNUSED*/) {
  (static_cast<ScrollbarStyleObserver *>(handle->data))->HandleScrollbarStyleChanged();
}

ScrollbarStyleObserver::ScrollbarStyleObserver(NanCallback *callback) : callback(callback) {
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

ScrollbarStyleObserver::~ScrollbarStyleObserver() {
  delete callback;
};

void ScrollbarStyleObserver::HandleScrollbarStyleChanged() {
  callback->Call(0, NULL);
}

NAN_METHOD(ScrollbarStyleObserver::GetPreferredScrollbarStyle) {
  NanScope();

  if ([NSScroller preferredScrollerStyle] == NSScrollerStyleOverlay) {
    NanReturnValue(String::New("overlay"));
  } else {
    NanReturnValue(String::New("legacy"));
  }
}
