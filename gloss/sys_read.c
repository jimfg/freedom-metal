#include <errno.h>
#include <sys/types.h>
#include <metal/tty.h>
#include <unistd.h>

ssize_t _read(int file, void *ptr, size_t len) {
    if (file != STDIN_FILENO){
        errno = ENOSYS;
        return -1;
    }
    char *bptr = (char *)ptr;
    int c;
    size_t i;
    for (i = 0; i < len; ++i){
        metal_tty_getc(&c);
	if (c == '\r')
	    c = '\n';
	*(bptr + i) = (char)c;
	if (c == '\n')
	    return i + 1;
    }
    return i;
}
