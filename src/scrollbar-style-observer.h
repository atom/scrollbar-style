#pragma once

#include <napi.h>
#include <uv.h>

class ScrollbarStyleObserver : public Napi::ObjectWrap<ScrollbarStyleObserver>
{
public:
    ScrollbarStyleObserver(const Napi::CallbackInfo&);
    ~ScrollbarStyleObserver();
    void HandleScrollbarStyleChanged();

    static Napi::Function GetClass(Napi::Env);

private:
  Napi::Value GetPreferredScrollbarStyle(const Napi::CallbackInfo&);

  Napi::FunctionReference callback;
};
