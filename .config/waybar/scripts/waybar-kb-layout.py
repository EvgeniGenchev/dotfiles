from wlroots import ffi, lib

for d in dir(ffi):
    if "kb" in d:
        print(d)
