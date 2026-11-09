# PS3 FPS Tools - Makefile (PSL1GHT)

TARGET		:= ps3tools
TITLE		:= PS3 FPS Tools
APPID		:= PSTL00001
CONTENTID	:= UP0001-$(APPID)_00-0000000000000000

SOURCES		:= source
INCLUDES	:= include

CFILES		:= $(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
OFILES		:= $(CFILES:.c=.o)

include $(PSL1GHT)/ppu_rules

CFLAGS		= -O2 -Wall -mcpu=cell -std=gnu99 $(MACHDEP) \
		  -I$(PSL1GHT)/ppu/include -I$(PS3DEV)/portlibs/ppu/include \
		  $(foreach dir,$(INCLUDES),-I$(dir))

LDFLAGS		= $(MACHDEP) -L$(PSL1GHT)/ppu/lib -L$(PS3DEV)/portlibs/ppu/lib
LIBS		= -lio -lsysutil -lrt -llv2 -lm

VPATH		:= $(SOURCES)

.PHONY: all clean pkg

all: $(TARGET).elf

$(TARGET).elf: $(OFILES)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

pkg: $(TARGET).pkg

$(TARGET).pkg: $(TARGET).elf
	@echo "Gerando SELF e PKG..."
	$(STRIP) $(TARGET).elf
	$(SPRX) $(TARGET).elf
	$(MAKE_SELF) $(TARGET).elf $(TARGET).self
	mkdir -p pkg/USRDIR
	cp $(TARGET).self pkg/USRDIR/EBOOT.BIN
	$(PKG) --contentid $(CONTENTID) pkg/ $(TARGET).pkg
	@echo "PKG gerado: $(TARGET).pkg"

clean:
	rm -f $(OFILES) $(TARGET).elf $(TARGET).self $(TARGET).pkg
	rm -rf pkg
