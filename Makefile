TARGET   := ps3tools
TITLE    := PS3 Tools
APPID    := PS3TL00001
CONTENTID := UP0001-$(APPID)_00-0000000000000000

include $(PSL1GHT)/ppu_rules

SOURCES  := source
CFLAGS   := -O2 -Wall
LIBS     := -lio -lsysutil -lrt -llv2

OBJS := source/main.o

$(TARGET).elf: $(OBJS)
	$(CC) $(OBJS) -o $@ $(LIBS)

pkg: $(TARGET).elf
	$(SELF) $(TARGET).elf
	$(SFO) --title "$(TITLE)" --appid "$(APPID)" PARAM.SFO
	$(PKG) --contentid $(CONTENTID) pkg/ $(TARGET).pkg
