#include <stdio.h>
#include <unistd.h>
#include <io/pad.h>
#include <sysutil/sysutil.h>

static int running = 1;

static void sysutil_cb(u64 status, u64 param, void *usrdata) {
    if (status == SYSUTIL_EXIT_GAME) running = 0;
}

int main(void) {
    padInfo padinfo;
    padData paddata;

    ioPadInit(7);
    sysUtilRegisterCallback(0, sysutil_cb, NULL);

    printf("PS3 Tools - teste OK\n");

    while (running) {
        sysUtilCheckCallback();
        ioPadGetInfo(&padinfo);
        if (padinfo.status[0]) {
            ioPadGetData(0, &paddata);
            if (paddata.BTN_CIRCLE) break;
        }
        usleep(20000);
    }

    ioPadEnd();
    return 0;
}
