# ----------------------------------------------------------------------------
# BRIEF -- CMakeLists.txt for Build System
# ----------------------------------------------------------------------------
# Top-level CMake configuration (C, version 1.0.0).
#
# Features: - C17 standard - Includes CMake modules for color, clang-tidy, and
# build options - Defines library and optional executable targets - Configurable
# options: static analysis, warnings as errors, AddressSanitizer
#
# Usage: - Configure and build with provided Makefile
# ----------------------------------------------------------------------------

cmake_minimum_required(VERSION 3.22)

project(
  BUILD_SYSTEM
  VERSION 1.0.0
  LANGUAGES C)

# C Standard
set(CMAKE_C_STANDARD          17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS        OFF)

# Define library names
set(LIB_COMMON      Common)
set(LIB_DSA         DSA)
set(LIB_MATH        Math)
set(LIB_NETWORKING  Networking)
set(LIB_THREADING   Threading)

# Define executable name
set(EXECUTABLE_NAME         my_program)

# Default build type (Release if unspecified)
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose build type: Debug, Release" FORCE)
endif()

# Detect architecture (override with -DARCH=<value>)
if(NOT DEFINED ARCH)
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64")
        set(ARCH aarch64)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64|AMD64")
        set(ARCH x86_64)
    else()
        message(FATAL_ERROR "Unknown architecture: ${CMAKE_SYSTEM_PROCESSOR}")
    endif()
endif()

# Set toolchain for cross-compilation (only if building for ARM)
if(ARCH STREQUAL "aarch64")
    set(AARCH64_TOOLCHAIN "${CMAKE_SOURCE_DIR}/cmake/toolchains/aarch64-glibc-toolchain.cmake")
    set(CMAKE_TOOLCHAIN_FILE ${AARCH64_TOOLCHAIN} CACHE STRING "Toolchain file" FORCE)
endif()

# Output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/${CMAKE_BUILD_TYPE}/remote/${ARCH})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/artifacts)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/artifacts)

# Feature Toggles
option(COMPILE_EXECUTABLE "Compile the executable"            ON)
option(ENABLE_CLANG_TIDY  "Enable clang-tidy static analysis" ON)
option(ENABLE_WARN_AS_ERR "Treat all warnings as errors"      OFF)
option(ENABLE_ADSAN       "Enable Address-Sanitizer"          OFF)
option(STRIP_TARGET       "Strip all symbols from release"    ON)

# Include project structure and libraries
add_subdirectory(apps)
add_subdirectory(cmake)
add_subdirectory(libs)

configure_executable()

message(STATUS "Building for ARCH: ${ARCH}, Mode: ${CMAKE_BUILD_TYPE}")
