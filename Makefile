CLANG_BIN = `xcrun --sdk iphoneos --find clang`
CLANG_UNIVERSAL = $(CLANG_BASE) -arch armv7 -arch armv7s -arch arm64
SDK = `xcrun --sdk iphoneos --show-sdk-path`

CLANG_BASE = $(CLANG_BIN) -Os -Wimplicit -isysroot $(SDK) \
             -F$(SDK)/System/Library/Frameworks \
             -F$(SDK)/System/Library/PrivateFrameworks

all: dumpdecrypted.dylib

dumpdecrypted.dylib: dumpdecrypted.o 
	$(CLANG_UNIVERSAL) -dynamiclib -o $@ $^

%.o: %.c
	$(CLANG_UNIVERSAL) -Weverything -c -o $@ $<

clean:
	rm -f *.o dumpdecrypted.dylib
