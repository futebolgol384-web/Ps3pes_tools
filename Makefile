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

.PHONY: all clean pkg

all: $(TARGET).elf

$(TARGET).elf: $(OFILES)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Gera o SELF a partir do ELF
$(TARGET).self: $(TARGET).elf
	ppu-strip $(TARGET).elf
	sprxlinker $(TARGET).elf
	make_self $(TARGET).elf $(TARGET).self

pkg: $(TARGET).pkg

# Empacota como PKG instalavel no XMB
$(TARGET).pkg: $(TARGET).self
	@echo "Gerando PKG..."
	rm -rf pkg
	mkdir -p pkg/USRDIR
	cp $(TARGET).self pkg/USRDIR/EBOOT.BIN
	@if [ -f $(PS3DEV)/bin/pkg.py ]; then \
		python $(PS3DEV)/bin/pkg.py --contentid $(CONTENTID) pkg/ $(TARGET).pkg ; \
	elif command -v pkg >/dev/null 2>&1; then \
		pkg --contentid $(CONTENTID) pkg/ $(TARGET).pkg ; \
	else \
		echo "AVISO: ferramenta de PKG nao encontrada, gerando apenas SELF" ; \
		cp $(TARGET).self $(TARGET).self.bin ; \
	fi
	@ls -la $(TARGET).* || true

clean:
	rm -f $(OFILES) $(TARGET).elf $(TARGET).self $(TARGET).pkg $(TARGET).self.bin
	rm -rf pkg
