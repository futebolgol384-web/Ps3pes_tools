TARGET = ps3tools
SOURCES = source
INCLUDES = include
OFILES = $(foreach dir,$(SOURCES),$(patsubst %.c,%.o,$(wildcard $(dir)/*.c)))

TITLE = PS3 Tools
APPID = PSTL00001
CONTENTID = UP0001-$(APPID)_00-0000000000000000
BUILDDIR = build

include $(PSL1GHT)/ppu_rules

CFLAGS = -O2 -Wall -mcpu=cell -std=gnu99 $(MACHDEP) -I$(PSL1GHT)/ppu/include -I$(PS3DEV)/portlibs/ppu/include
LDFLAGS = $(MACHDEP) -L$(PSL1GHT)/ppu/lib -L$(PS3DEV)/portlibs/ppu/lib
LIBS = -lio -lsysutil -lrt -llv2 -lm

pkg: $(TARGET).pkg

clean:
	rm -rf $(TARGET)*.pkg $(TARGET)*.self $(BUILDDIR) $(OFILES)
