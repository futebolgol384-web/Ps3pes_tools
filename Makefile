TARGET = ps3tools
SOURCES = source
INCLUDES = include
CFLAGS = -O2 -Wall -mcpu=cell -std=gnu99
LIBS = -lio -lsysutil -lrt -llv2 -lm
OFILES = $(foreach dir,$(SOURCES),$(patsubst %.c,%.o,$(wildcard $(dir)/*.c)))

TITLE = PS3 Tools
APPID = PSTL00001
CONTENTID = UP0001-$(APPID)_00-0000000000000000
BUILDDIR = build

include $(PSL1GHT)/ppu_rules

pkg: $(TARGET).pkg

clean:
	rm -rf $(TARGET)*.pkg $(TARGET)*.self $(BUILDDIR) $(OFILES)
