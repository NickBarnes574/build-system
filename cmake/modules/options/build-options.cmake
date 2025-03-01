# ----------------------------------------------------------------------------
# BRIEF -- build-options.cmake
# ----------------------------------------------------------------------------
# Configures common compiler options and build settings.
# This file is included in the main CMakeLists.txt.
# ----------------------------------------------------------------------------

# Default to Release mode if not set
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type (default: Release)" FORCE)
endif()

# Common compile options
set(COMMON_COMPILE_OPTIONS
    -std=c17
    -Wall
    -Wextra
    -pedantic)

add_compile_options(${COMMON_COMPILE_OPTIONS})

# Set build-type specific flags
set(CMAKE_C_FLAGS_DEBUG    "-g -Werror" CACHE STRING "Debug build flags" FORCE)
set(CMAKE_C_FLAGS_RELEASE  "-O3 -DNDEBUG" CACHE STRING "Release build flags" FORCE)
set(CMAKE_C_FLAGS_TEST     "-g" CACHE STRING "Test build flags" FORCE)

# Display build type
message(STATUS "*** Building in ${CMAKE_BUILD_TYPE} mode ***")
