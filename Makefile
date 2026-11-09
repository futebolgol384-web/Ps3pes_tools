#---------------------------------------------------------------------------------
# Clear the implicit built in rules
#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(PSL1GHT)),)
$(error "Please set PSL1GHT in your environment. export PSL1GHT=<path>")
endif

#---------------------------------------------------------------------------------
# Package metadata (must be before ppu_rules)
#---------------------------------------------------------------------------------
TITLE		:=	PS3 FPS Tools
APPID		:=	PSTL00001
CONTENTID	:=	UP0001-$(APPID)_00-0000000000000000

#---------------------------------------------------------------------------------
include $(PSL1GHT)/ppu_rules

#---------------------------------------------------------------------------------
TARGET		:=	ps3tools
BUILD		:=	build
SOURCES		:=	source
INCLUDES	:=	include

BUILDDIR	:=	$(CURDIR)/$(BUILD)

#---------------------------------------------------------------------------------
CFLAGS		=	-O2 -Wall -mcpu=cell $(MACHDEP) $(INCLUDE)
LDFLAGS		=	$(MACHDEP)
LIBS		:=	-lio -lsysutil -lrt -llv2 -lm

#---------------------------------------------------------------------------------
ifneq ($(BUILD),$(notdir $(CURDIR)))
#---------------------------------------------------------------------------------

export OUTPUT	:=	$(CURDIR)/$(TARGET)
export VPATH	:=	$(foreach dir,$(SOURCES),$(CURDIR)/$(dir))
export DEPSDIR	:=	$(CURDIR)/$(BUILD)
export BUILDDIR	:=	$(CURDIR)/$(BUILD)

CFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
export OFILES	:=	$(CFILES:.c=.o)
export LD	:=	$(CC)

export INCLUDE	:=	$(foreach dir,$(INCLUDES),-I$(CURDIR)/$(dir)) \
			$(LIBPSL1GHT_INC) \
			-I$(CURDIR)/$(BUILD)

export LIBPATHS	:=	$(LIBPSL1GHT_LIB) -L$(PORTLIBS)/lib

.PHONY: $(BUILD) clean pkg

#---------------------------------------------------------------------------------
$(BUILD):
	@[ -d $@ ] || mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

pkg: $(BUILD)
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile $(OUTPUT).pkg

clean:
	@echo clean ...
	@rm -rf $(BUILD) $(TARGET).elf $(TARGET).self $(TARGET).pkg $(TARGET).gnpdrm.pkg

#---------------------------------------------------------------------------------
else
#---------------------------------------------------------------------------------

DEPENDS	:=	$(OFILES:.o=.d)

$(OUTPUT).pkg: $(OUTPUT).self
$(OUTPUT).self: $(OUTPUT).elf
$(OUTPUT).elf: $(OFILES)
	@echo linking ... $(notdir $@)
	@$(LD) $(LDFLAGS) $(OFILES) $(LIBPATHS) $(LIBS) -o $@

-include $(DEPENDS)

#---------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------
