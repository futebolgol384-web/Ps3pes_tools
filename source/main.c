#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <io/pad.h>
#include <sysutil/sysutil.h>
#include <sysutil/msg.h>

static int running = 1;
static int dialog_done = 0;

static void sysutil_cb(u64 status, u64 param, void *usrdata) {
    (void)param;
    (void)usrdata;
    if (status == SYSUTIL_EXIT_GAME)
        running = 0;
}

static void dialog_cb(msgButton button, void *userdata) {
    (void)userdata;
    (void)button;
    dialog_done = 1;
}

int main(void) {
    padInfo padinfo;
    padData paddata;
    msgType dtype;

    ioPadInit(7);
    sysUtilRegisterCallback(0, sysutil_cb, NULL);

    /* Dialogo do sistema aparece NA TV (printf so aparece em debug) */
    dtype = (msgType)(MSG_DIALOG_NORMAL | MSG_DIALOG_BTN_TYPE_OK | MSG_DIALOG_DISABLE_CANCEL_ON);
    msgDialogOpen2(
        dtype,
        "PS3 FPS Tools v0.1\n\n"
        "App base funcionando!\n\n"
        "O unlock de FPS real usa:\n"
        "- Artemis + .ncl\n"
        "- webMAN + PS3MAPI\n"
        "- PSUF\n\n"
        "Aperte OK para sair.",
        dialog_cb,
        NULL,
        NULL
    );

    while (running && !dialog_done) {
        sysUtilCheckCallback();

        ioPadGetInfo(&padinfo);
        if (padinfo.status[0]) {
            ioPadGetData(0, &paddata);
            if (paddata.BTN_CIRCLE || paddata.BTN_CROSS)
                break;
        }

        usleep(30000);
    }

    msgDialogAbort();
    ioPadEnd();
    return 0;
}
