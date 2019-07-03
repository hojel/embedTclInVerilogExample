CDS_INST_DIR := $(shell xmroot)
CC = gcc
INCLUDE  = -I$(CDS_INST_DIR)/tools/include
OPT      = -Wall -fpic -shared
ifdef TCL_HOME
INCLUDE  += -I$(TCL_HOME)/include
LIBS     += -L$(TCL_HOME)/lib
endif
CFLAGS   = $(OPT) $(INCLUDE)
LIBS     += -ltcl

SHLIB = libdpi.so
CSRCS = tclEmbedded.c
VSRCS = tclEmbedded.sv

run:: $(SHLIB)
	xrun -sv $(VSRCS) -sv_lib $(SHLIB)

sim:: xcelium.d $(SHLIB)
	xmsim -messages worklib.top

xcelium.d: $(VSRCS)
	xmvlog -messages -sv $(VSRCS)
	xmelab -messages -access +RWC worklib.top
	touch $@

$(SHLIB): $(CSRCS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

clean::
	$(RM) $(SHLIB)
	$(RM) -r xcelium.d
	$(RM) xm*.log
