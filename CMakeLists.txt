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

# Define executable name
set(EXECUTABLE_NAME         my_program)

# Set common compile flags regardless of configuration type
set(FLAGS_COMMON -std=c17 -Wall -Wextra -pedantic)

# Set configuration specific compile flags
set(FLAGS_DEBUG -g -Werror -DDEBUG)
set(FLAGS_RELEASE -O3 -DNDEBUG)
set(FLAGS_TEST -g)

# Feature Toggles
option(COMPILE_EXECUTABLE "Compile the executable"            ON)
option(ENABLE_CLANG_TIDY  "Enable clang-tidy static analysis" ON)
option(ENABLE_WARN_AS_ERR "Treat all warnings as errors"      OFF)
option(ENABLE_ADSAN       "Enable Address-Sanitizer"          OFF)
option(STRIP_TARGET       "Strip all symbols from release"    ON)
option(BUILD_SHARED_LIBS  "Build dynamic library (.so) files" OFF)

#TODO: add option to run clang-tidy on libraries and/or executables
#TODO: add option to run clang-format without need for VS Code extensions
#TODO: add option to run cmake-format
#TODO: fix shared libraries installation and linking

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
