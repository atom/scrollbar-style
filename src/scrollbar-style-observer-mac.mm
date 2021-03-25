#import <AppKit/NSScroller.h>
#import "scrollbar-style-observer.h"

using namespace Napi;

uv_loop_t *loop = uv_default_loop();
uv_async_t async;

static void notificationHandler(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  async.data = observer;
  uv_async_send(&async);
}

static void asyncSendHandler(uv_async_t *handle) {
  (static_cast<ScrollbarStyleObserver *>(handle->data))->HandleScrollbarStyleChanged();
}

ScrollbarStyleObserver::ScrollbarStyleObserver(const Napi::CallbackInfo& info) : ObjectWrap(info) {
  auto env = info.Env();
  Napi::HandleScope scope(env);

  callback = Napi::Persistent(info[0].As<Napi::Function>());

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

Napi::Value ScrollbarStyleObserver::GetPreferredScrollbarStyle(const Napi::CallbackInfo& info) {
    auto env = info.Env();
    Napi::HandleScope scope(env);

    if ([NSScroller preferredScrollerStyle] == NSScrollerStyleOverlay) {
      return Napi::String::New(env, "overlay");
    } else {
      return Napi::String::New(env, "legacy");
    }
}

void ScrollbarStyleObserver::HandleScrollbarStyleChanged() {
  callback.Call({});
}

ScrollbarStyleObserver::~ScrollbarStyleObserver() {
  delete &callback;
}

Napi::Function ScrollbarStyleObserver::GetClass(Napi::Env env) {
    return DefineClass(env, "ScrolstyleObserver", {
        ScrollbarStyleObserver::InstanceMethod("getPreferredScrollbarStyle", &ScrollbarStyleObserver::GetPreferredScrollbarStyle),
    });
}

Napi::Object Init(Napi::Env env, Napi::Object exports) {
    Napi::String name = Napi::String::New(env, "ScrollbarStyleObserver");
    exports.Set(name, ScrollbarStyleObserver::GetClass(env));
    return exports;
}

NODE_API_MODULE(addon, Init)
