# BRIEF -- Makefile:
# ----------------------------------------------------------------------------
# This Makefile provides commands to build and deploy the project in various
# configurations.
#
# Targets:
#   all:		Builds the project for all architectures.
#   default:    Builds the project in the release configuration for x86-64.
#   release:    Builds and installs the project in release mode for x86-64.
#   debug:      Builds and installs the project in debug mode for x86-64.
#   aarch64:    Builds and installs the project for the ARM-64 architecture.
#   clean:      Cleans up the build directory.
#   help:       Displays the help menu.
#
# Usage:
#   make [target] - Build the project using the specified target.
#                   If no target is specified, 'default' is used.
# ----------------------------------------------------------------------------

MAKEFLAGS += --no-print-directory # Suppress 'Entering directory' messages.

# Project configuration
BUILD_DIR = build/artifacts

# Toolchains
AARCH64_TOOLCHAIN = cmake/toolchains/aarch64-glibc-toolchain.cmake

default: release

all: 
	@$(MAKE) release
	@$(MAKE) debug
	@$(MAKE) aarch64

# x86-64
release: BUILD_TYPE = Release
release: ARCH = x86_64
release: build

debug: BUILD_TYPE = Debug
debug: ARCH = x86_64
debug: build

# ARM-64
aarch64: BUILD_TYPE = Release
aarch64: ARCH = aarch64
aarch64: TOOLCHAIN = -DCMAKE_TOOLCHAIN_FILE=$(AARCH64_TOOLCHAIN)
aarch64: build

build:
	@cmake -S . -B $(BUILD_DIR)/$(ARCH) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) $(TOOLCHAIN)
	@cmake --build $(BUILD_DIR)/$(ARCH) --target install

clean:
	@rm -rf build tests

help:
	@echo "Available targets:"
	@echo "  make default    - Builds the project in release mode (x86-64)."
	@echo "  make release    - Builds and installs the project in release mode (x86-64)."
	@echo "  make debug      - Builds and installs the project in debug mode (x86-64)."
	@echo "  make aarch64    - Builds and installs the project for ARM-64 architecture."
	@echo "  make all        - Builds the project for all configurations."
	@echo "  make clean      - Cleans up the build directory."
	@echo "  make help       - Displays this help message."

.PHONY: release debug clean aarch64 all build

# *** end of file ***