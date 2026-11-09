#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <io/pad.h>
#include <sysutil/sysutil.h>

static int running = 1;

static void sysutil_cb(u64 status, u64 param, void *usrdata) {
    (void)param;
    (void)usrdata;
    if (status == SYSUTIL_EXIT_GAME)
        running = 0;
}

static void print_header(void) {
    printf("\n");
    printf("========================================\n");
    printf("   PS3 FPS TOOLS  -  v0.1\n");
    printf("========================================\n");
    printf("\n");
    printf("  Este e um homebrew base.\n");
    printf("  O unlock de FPS real usa:\n");
    printf("\n");
    printf("  1) Artemis + arquivos .ncl\n");
    printf("  2) webMAN MOD + PS3MAPI\n");
    printf("  3) EBOOT pre-patchado\n");
    printf("  4) App PSUF (comunidade)\n");
    printf("\n");
    printf("  Requisitos:\n");
    printf("  - CFW ou HEN\n");
    printf("  - webMAN MOD recomendado\n");
    printf("\n");
    printf("  Pressione CIRCULO para sair.\n");
    printf("========================================\n");
}

int main(void) {
    padInfo padinfo;
    padData paddata;

    ioPadInit(7);
    sysUtilRegisterCallback(0, sysutil_cb, NULL);

    print_header();

    while (running) {
        sysUtilCheckCallback();

        ioPadGetInfo(&padinfo);
        if (padinfo.status[0]) {
            ioPadGetData(0, &paddata);
            if (paddata.BTN_CIRCLE)
                break;
        }

        usleep(20000);
    }

    printf("Saindo...\n");
    ioPadEnd();
    return 0;
}
