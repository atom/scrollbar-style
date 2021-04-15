#include "scrollbar-style-observer.h"

using namespace Napi;

ScrollbarStyleObserver::ScrollbarStyleObserver(const Napi::CallbackInfo& info) : ObjectWrap(info) {
}

ScrollbarStyleObserver::~ScrollbarStyleObserver() {
}

Napi::Value ScrollbarStyleObserver::GetPreferredScrollbarStyle(const Napi::CallbackInfo& info) {
    auto env = info.Env();
    Napi::HandleScope scope(env);

    return Napi::String::New(env, "legacy");
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
