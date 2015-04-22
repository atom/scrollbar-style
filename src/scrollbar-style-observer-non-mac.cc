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

void ScrollbarStyleObserver::Init(Handle<Object> target) {
  NanScope();
  Local<FunctionTemplate> newTemplate = NanNew<FunctionTemplate>(ScrollbarStyleObserver::New);
  newTemplate->SetClassName(NanNew<String>("ScrollbarStyleObserver"));
  newTemplate->InstanceTemplate()->SetInternalFieldCount(1);
  Local<ObjectTemplate> proto = newTemplate->PrototypeTemplate();
  NODE_SET_METHOD(proto, "getPreferredScrollbarStyle", ScrollbarStyleObserver::GetPreferredScrollbarStyle);
  target->Set(NanNew<String>("ScrollbarStyleObserver"), newTemplate->GetFunction());
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
}

void ScrollbarStyleObserver::HandleScrollbarStyleChanged() {
}

NAN_METHOD(ScrollbarStyleObserver::GetPreferredScrollbarStyle) {
  NanScope();
  NanReturnValue(NanNew<String>("legacy"));
}
