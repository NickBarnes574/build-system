# ----------------------------------------------------------------------------
# BRIEF -- CMakeLists.txt for EmuBox
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
  EmuBox
  VERSION 1.0.0
  LANGUAGES C)

# cmake-format: off
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
set(EXECUTABLE_ADMIN          admin)
set(EXECUTABLE_DOWNSTREAM     downstream)
set(EXECUTABLE_PRETREATMENT   pretreatment)
set(EXECUTABLE_RESIDENTIAL    residential)
set(EXECUTABLE_STORMDRAIN     stormdrain)
set(EXECUTABLE_TREATMENT      treatment)

# Options for enabling various build tools/features
option(COMPILE_EXECUTABLE "Compile the executable"            ON)
option(ENABLE_CLANG_TIDY  "Enable clang-tidy static analysis" ON)
option(ENABLE_WARN_AS_ERR "Treat all warnings as errors"      OFF)
option(ENABLE_ADSAN       "Enable Address-Sanitizer"          OFF)
# cmake-format: on

# Include additional CMake modules
include(cmake/color-options.cmake)
include(cmake/clang-tidy.cmake)
include(cmake/output-directories.cmake)
include(cmake/project-structure.cmake)
include(cmake/build-options.cmake)

configure_admin_executable()
configure_downstream_executable()
configure_pretreatment_executable()
configure_residential_executable()
configure_stormdrain_executable()
configure_treatment_executable()

# *** end of file ***
