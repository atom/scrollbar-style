#import <AppKit/NSScroller.h>
#import "scrollbar-style-observer.h"

using namespace v8;

void ScrollbarStyleObserver::Init(Local<Object> target) {
  Nan::HandleScope scope;
  Local<FunctionTemplate> newTemplate = Nan::New<FunctionTemplate>(ScrollbarStyleObserver::New);
  newTemplate->SetClassName(Nan::New<String>("ScrollbarStyleObserver").ToLocalChecked());
  newTemplate->InstanceTemplate()->SetInternalFieldCount(1);
  Local<ObjectTemplate> proto = newTemplate->PrototypeTemplate();
  Nan::SetMethod(proto, "getPreferredScrollbarStyle", ScrollbarStyleObserver::GetPreferredScrollbarStyle);
  target->Set(Nan::New<String>("ScrollbarStyleObserver").ToLocalChecked(), newTemplate->GetFunction());
}

NODE_MODULE(scrollbar_style_observer, ScrollbarStyleObserver::Init)

NAN_METHOD(ScrollbarStyleObserver::New) {
  Nan::HandleScope scope;

  Local<Function> callbackHandle = info[0].As<Function>();
  Nan::Callback *callback = new Nan::Callback(callbackHandle);

  ScrollbarStyleObserver *observer = new ScrollbarStyleObserver(callback);
  observer->Wrap(info.This());
  return;
}

uv_loop_t *loop = uv_default_loop();
uv_async_t async;

static void notificationHandler(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  async.data = observer;
  uv_async_send(&async);
}

static void asyncSendHandler(uv_async_t *handle) {
  (static_cast<ScrollbarStyleObserver *>(handle->data))->HandleScrollbarStyleChanged();
}

ScrollbarStyleObserver::ScrollbarStyleObserver(Nan::Callback *callback) : callback(callback) {
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
  Nan::HandleScope scope;

  if ([NSScroller preferredScrollerStyle] == NSScrollerStyleOverlay) {
    info.GetReturnValue().Set(Nan::New<String>("overlay").ToLocalChecked());
  } else {
    info.GetReturnValue().Set(Nan::New<String>("legacy").ToLocalChecked());
  }
}
