# PS3 FPS Tools - Makefile (PSL1GHT)

TARGET      := ps3tools
TITLE       := PS3 FPS Tools
APPID       := PSTL00001
CONTENTID   := UP0001-$(APPID)_00-0000000000000000

SOURCES     := source
INCLUDES    := include

CFILES      := $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
OFILES      := $(CFILES:.c=.o)

include $(PSL1GHT)/ppu_rules

CFLAGS      = -O2 -Wall -mcpu=cell -std=gnu99 $(MACHDEP) \
              -I$(PSL1GHT)/ppu/include -I$(PS3DEV)/portlibs/ppu/include \
              $(foreach dir,$(INCLUDES),-I$(dir))

LDFLAGS     = $(MACHDEP) -L$(PSL1GHT)/ppu/lib -L$(PS3DEV)/portlibs/ppu/lib
LIBS        = -lio -lsysutil -lrt -llv2 -lm

VPATH       := $(SOURCES)

.PHONY: all clean self pkg

all: $(TARGET).elf

$(TARGET).elf: $(OFILES)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

self: $(TARGET).self

$(TARGET).self: $(TARGET).elf
	ppu-strip $(TARGET).elf
	sprxlinker $(TARGET).elf
	make_self $(TARGET).elf $(TARGET).self

# pkg e gerado principalmente no GitHub Actions (precisa Python 2 + pkg.py)
pkg: self
	@echo "Use o workflow do GitHub Actions para gerar o .pkg"
	@echo "Ou localmente: python2 \$$PS3DEV/bin/pkg.py --contentid $(CONTENTID) pkg/ $(TARGET).pkg"

clean:
	rm -f $(OFILES) $(TARGET).elf $(TARGET).self $(TARGET).pkg
	rm -rf pkg
