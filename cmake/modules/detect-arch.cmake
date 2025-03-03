# ----------------------------------------------------------------------------
# BRIEF -- detect-arch.cmake
# ----------------------------------------------------------------------------
# Detects system architecture and sets ARCH variable accordingly.
#
# Features:
# - Supports x86_64, ARM (32/64-bit), RISC-V, and PowerPC architectures
# - Allows manual override using -DARCH=<value>
# - Issues a warning and defaults to 'generic' for unrecognized architectures
#
# Usage:
# - Include this file in CMakeLists.txt
# - Override architecture manually if necessary (-DARCH=<arch>)
# ----------------------------------------------------------------------------

if(NOT DEFINED ARCH)
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|armv8.*)$")
        set(ARCH aarch64)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(armv7.*|armv6.*)$")
        set(ARCH arm)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86_64|AMD64)$")
        set(ARCH x86_64)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(riscv64)$")
        set(ARCH riscv64)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(ppc64|powerpc64)$")
        set(ARCH ppc64)
    else()
        message(WARNING "Unknown architecture: ${CMAKE_SYSTEM_PROCESSOR}, defaulting to generic.")
        set(ARCH generic)
    endif()
endif()

# *** END OF FILE ***
