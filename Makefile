BASE_RAWCODE_ADDR = 0x808E9AF0

#DISC_ID = RMCJ
#DISC_ID = RMCE
DISC_ID = RMCP
#DISC_ID = RMCK

ifeq ($(DISC_ID), RMCE)
BASE_LE_BIN = $(ROOT_DIR)/template/lecode-USA.bin
else
ifeq ($(DISC_ID), RMCP)
BASE_LE_BIN = $(ROOT_DIR)/template/lecode-PAL.bin
else
ifeq ($(DISC_ID), RMCJ)
BASE_LE_BIN = $(ROOT_DIR)/template/lecode-JAP.bin
else
ifeq ($(DISC_ID), RMCK)
BASE_LE_BIN = $(ROOT_DIR)/template/lecode-KOR.bin
endif
endif
endif
endif

# Get directory Makefile runs from
ROOT_DIR := $(shell dirname $(abspath $(lastword $(MAKEFILE_LIST))))

#---------------------------------------------------------------------------------
# Clear the implicit built in rules
#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------
ifeq ($(strip $(DEVKITPPC)),)
$(error "Please set DEVKITPPC in your environment. export DEVKITPPC=<path to>devkitPPC")
endif

include $(DEVKITPPC)/gamecube_rules

#---------------------------------------------------------------------------------
# rules for generating lecode-XXX.bin from .rawcode
#---------------------------------------------------------------------------------

%.bin: %.rawcode
	py $(ROOT_DIR)/rawcode_2_lecode.py $(BASE_LE_BIN) $< $(BASE_RAWCODE_ADDR) $@

%.rawcode: %.elf
	@echo "extracting code from $(notdir $<) ... $(notdir $@)"
	@$(OBJCOPY) -O binary -S $< $@

#---------------------------------------------------------------------------------
# TARGET is the name of the output
# BUILD is the directory where object files & intermediate files will be placed
# SOURCES is a list of directories containing source code
# INCLUDES is a list of directories containing extra header files
# GCI_BUILD is the GCI patch builder YAML config
#---------------------------------------------------------------------------------
TARGET		:=	$(notdir $(CURDIR))
BUILD		:=	build
SOURCES		:=	source source_$(DISC_ID)
DATA		:=	data data_$(DISC_ID)
INCLUDES	:=

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------

CFLAGS		= -g -Og -Wall $(MACHDEP) $(INCLUDE) -ffunction-sections -fno-builtin -nodefaultlibs -nostdlib -nostartfiles -D$(DISC_ID)
CXXFLAGS	= $(CFLAGS)

LDFLAGS		= -g $(MACHDEP) -Wl,-Map,$(notdir $@).map -nostartfiles -T $(ROOT_DIR)/linker_$(DISC_ID).ld

#---------------------------------------------------------------------------------
# any extra libraries we wish to link with the project
#---------------------------------------------------------------------------------
#LIBS	:=	-logc -lm
LIBS    :=

#---------------------------------------------------------------------------------
# list of directories containing libraries, this must be the top level containing
# include and lib
#---------------------------------------------------------------------------------
LIBDIRS	:=

#---------------------------------------------------------------------------------
# no real need to edit anything past this point unless you need to add additional
# rules for different file extensions
#---------------------------------------------------------------------------------
ifneq ($(BUILD),$(notdir $(CURDIR)))
#---------------------------------------------------------------------------------

export OUTPUT	:=	$(CURDIR)/$(TARGET)

export VPATH	:=	$(foreach dir,$(SOURCES),$(CURDIR)/$(dir)) \
			$(foreach dir,$(DATA),$(CURDIR)/$(dir))

export DEPSDIR	:=	$(CURDIR)/$(BUILD)

#---------------------------------------------------------------------------------
# automatically build a list of object files for our project
#---------------------------------------------------------------------------------
CFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES	:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
sFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))
SFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.S)))
BINFILES	:=	$(foreach dir,$(DATA),$(notdir $(wildcard $(dir)/*.*)))

#---------------------------------------------------------------------------------
# use CXX for linking C++ projects, CC for standard C
#---------------------------------------------------------------------------------
ifeq ($(strip $(CPPFILES)),)
	export LD	:=	$(CC)
else
	export LD	:=	$(CXX)
endif

export OFILES_BIN	:=	$(addsuffix .o,$(BINFILES))
export OFILES_SOURCES := $(CPPFILES:.cpp=.o) $(CFILES:.c=.o) $(sFILES:.s=.o) $(SFILES:.S=.o)
export OFILES := $(OFILES_BIN) $(OFILES_SOURCES)

export HFILES := $(addsuffix .h,$(subst .,_,$(BINFILES)))

#---------------------------------------------------------------------------------
# build a list of include paths
#---------------------------------------------------------------------------------
export INCLUDE	:=	$(foreach dir,$(INCLUDES),-I$(CURDIR)/$(dir)) \
			$(foreach dir,$(LIBDIRS),-I$(dir)/include) \
			-I$(CURDIR)/$(BUILD) \
			-I$(LIBOGC_INC)

#---------------------------------------------------------------------------------
# build a list of library paths
#---------------------------------------------------------------------------------
export LIBPATHS	:=	$(foreach dir,$(LIBDIRS),-L$(dir)/lib) \
			-L$(LIBOGC_LIB)

export OUTPUT	:=	$(CURDIR)/$(TARGET)
.PHONY: $(BUILD) clean

#---------------------------------------------------------------------------------
$(BUILD):
	@[ -d $@ ] || mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile

#---------------------------------------------------------------------------------
clean:
	@echo clean ...
	@rm -fr $(BUILD) lecode-JAP.elf lecode-JAP.rawcode lecode-JAP.bin
#---------------------------------------------------------------------------------
else

DEPENDS	:=	$(OFILES:.o=.d)

#---------------------------------------------------------------------------------
# main targets
#---------------------------------------------------------------------------------

ifeq ($(DISC_ID), RMCE)
lecode-USA.bin: lecode-USA.rawcode
lecode-USA.rawcode: lecode-USA.elf
lecode-USA.elf: $(OFILES)
else
ifeq ($(DISC_ID), RMCP)
lecode-PAL.bin: lecode-PAL.rawcode
lecode-PAL.rawcode: lecode-PAL.elf
lecode-PAL.elf: $(OFILES)
else
ifeq ($(DISC_ID), RMCJ)
lecode-JAP.bin: lecode-JAP.rawcode
lecode-JAP.rawcode: lecode-JAP.elf
lecode-JAP.elf: $(OFILES)
else
ifeq ($(DISC_ID), RMCK)
lecode-KOR.bin: lecode-KOR.rawcode
lecode-KOR.rawcode: lecode-KOR.elf
lecode-KOR.elf: $(OFILES)
endif
endif
endif
endif

$(OFILES_SOURCES) : $(HFILES)

#---------------------------------------------------------------------------------
# This rule links in binary data with the .bin extension
#---------------------------------------------------------------------------------
%.bin.o	:	%.bin
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	$(bin2o)

#---------------------------------------------------------------------------------
# This rule links in binary data with the .szs extension
#---------------------------------------------------------------------------------
%.szs.o	:	%.szs
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	$(bin2o)

#---------------------------------------------------------------------------------
# This rule links in binary data with the .gct extension
#---------------------------------------------------------------------------------
%.gct.o	:	%.gct
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	$(bin2o)

-include $(DEPENDS)

#---------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------