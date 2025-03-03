# ----------------------------------------------------------------------------
# BRIEF -- CMakeLists.txt for Build System
# ----------------------------------------------------------------------------
# Top-level CMake configuration (C, version 1.0.0).
#
# Features:
# - C17 standard with strict compliance
# - Modular CMake structure for colorized output, static analysis, and build options
# - Feature toggles: static analysis, warnings as errors, AddressSanitizer
# - Supports dynamic/static library builds
#
# Usage:
# - Configure and build using the provided Makefile
# - Enable optional features using `-D<OPTION>=ON` flags
#
# TODO:
# - Add options for clang-format and cmake-format
# - Improve shared library installation and linking
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

# Define executable name
set(EXECUTABLE_NAME         my_program)

# Set universal compile options indedpentent of configuration type
add_compile_options(-Wall -Wextra -pedantic)

# Configuration specific compile options
set(CMAKE_C_FLAGS_DEBUG "-g -Werror -DDEBUG")
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG")
set(CMAKE_C_FLAGS_TEST "-g")

# Feature Toggles
option(COMPILE_EXECUTABLE "Compile the executable"            ON)
option(ENABLE_CLANG_TIDY  "Enable clang-tidy static analysis" ON)
option(ENABLE_WARN_AS_ERR "Treat all warnings as errors"      OFF)
option(ENABLE_ADSAN       "Enable Address-Sanitizer"          OFF)
option(STRIP_TARGET       "Strip all symbols from release"    ON)
option(BUILD_SHARED_LIBS  "Build dynamic library (.so) files" OFF)

include(cmake/modules/options/color-options.cmake)
include(cmake/modules/options/build-options.cmake)
include(cmake/modules/clang-tidy.cmake)
include(cmake/modules/detect-arch.cmake)
include(cmake/modules/output-directories.cmake)
include(cmake/modules/project-structure.cmake)

set_build_preferences()

# Include project structure and libraries
add_subdirectory(apps)
add_subdirectory(cmake)
add_subdirectory(libs)

configure_executable()

message_color(STATUS "Building for ARCH: ${ARCH}, Mode: ${CMAKE_BUILD_TYPE}")

# *** END OF FILE ***
