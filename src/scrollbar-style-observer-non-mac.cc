// Copyright (c) 2015 GitHub Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#include "scrollbar-style-observer.h"

using namespace v8; // NOLINT

void ScrollbarStyleObserver::Init(Local<Object> target) {
  Nan::HandleScope scope;
  Local<FunctionTemplate> newTemplate = Nan::New<FunctionTemplate>(ScrollbarStyleObserver::New);
  newTemplate->SetClassName(Nan::New<String>("ScrollbarStyleObserver").ToLocalChecked());
  newTemplate->InstanceTemplate()->SetInternalFieldCount(1);
  Local<ObjectTemplate> proto = newTemplate->PrototypeTemplate();
  Nan::SetMethod(proto, "getPreferredScrollbarStyle", ScrollbarStyleObserver::GetPreferredScrollbarStyle);
  target->Set(Nan::New<String>("ScrollbarStyleObserver").ToLocalChecked(), Nan::GetFunction(newTemplate).ToLocalChecked());
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

ScrollbarStyleObserver::ScrollbarStyleObserver(Nan::Callback *callback) : callback(callback) {
}

ScrollbarStyleObserver::~ScrollbarStyleObserver() {
  delete callback;
}

void ScrollbarStyleObserver::HandleScrollbarStyleChanged() {
}

NAN_METHOD(ScrollbarStyleObserver::GetPreferredScrollbarStyle) {
  Nan::HandleScope scope;
  info.GetReturnValue().Set(Nan::New<String>("legacy").ToLocalChecked());
}
