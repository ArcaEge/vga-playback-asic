export PDK_ROOT := ../gf180mcuD
export PDK := gf180mcuD
export LIBRELANE_TAG := 3.0.14

TOP_MODULE := $(shell ./tt/tt_tool.py --pdk $(PDK) --print-top-module)

all: config harden

config:
	./tt/tt_tool.py --pdk $(PDK) --create-user-config

harden:
	./tt/tt_tool.py --pdk $(PDK) --harden

view:
	./tt/tt_tool.py --pdk $(PDK) --open-in-openroad

fpga-%:
	$(MAKE) -C fpga $*

test:
	cp ./runs/wokwi/final/pnl/$(TOP_MODULE).pnl.v ./test/gate_level_netlist.v
	$(MAKE) -C test -B 

test-wave:
	surfer test/tb.fst

.PHONY: create-config harden view test test-wave fpga-%