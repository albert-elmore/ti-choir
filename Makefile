# ti-choir — build TI-83 Plus family ASM programs
#
# Requires spasm-ng: https://github.com/alberthdev/spasm-ng/releases
#   - Install to PATH as `spasm-ng`, or
#   - Run `make tools` to clone and build into tools/spasm-ng/

SPASM      ?= spasm-ng
SPASM_INC  ?= tools/spasm-ng/inc
ASM_FLAGS  ?= -I$(SPASM_INC) -Iasm

PROGRAMS   := BEEP1
BUILDDIR   := build

.PHONY: all clean tools check-spasm

all: check-spasm $(addprefix $(BUILDDIR)/,$(addsuffix .8xp,$(PROGRAMS)))

check-spasm:
	@command -v $(SPASM) >/dev/null 2>&1 || { \
		echo "error: $(SPASM) not found."; \
		echo "  Install spasm-ng from https://github.com/alberthdev/spasm-ng/releases"; \
		echo "  or run: make tools"; \
		exit 1; \
	}

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(BUILDDIR)/%.8xp: asm/%.asm | $(BUILDDIR)
	$(SPASM) $(ASM_FLAGS) -o $@ $<

# Clone and build spasm-ng locally (no OpenSSL/GMP when NO_APPSIGN=1).
tools:
	@test -d tools/spasm-ng/.git || git clone --depth 1 https://github.com/alberthdev/spasm-ng.git tools/spasm-ng
	$(MAKE) -C tools/spasm-ng NO_APPSIGN=1
	@echo ""
	@echo "Built tools/spasm-ng/spasm-ng"
	@echo "Run: make SPASM=tools/spasm-ng/spasm-ng"

clean:
	rm -rf $(BUILDDIR)
