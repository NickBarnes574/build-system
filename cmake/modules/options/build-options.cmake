# ----------------------------------------------------------------------------
# BRIEF -- build-options.cmake
# ----------------------------------------------------------------------------
# Configures common compiler options and build settings.
# This file is included in the main CMakeLists.txt.
# ----------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/color-options.cmake)

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
set(CMAKE_C_FLAGS_DEBUG    "-g -Werror -DDEBUG" CACHE STRING "Debug build flags" FORCE)
set(CMAKE_C_FLAGS_RELEASE  "-O3 -DNDEBUG" CACHE STRING "Release build flags" FORCE)
set(CMAKE_C_FLAGS_TEST     "-g" CACHE STRING "Test build flags" FORCE)

# Ensure the correct flag variable is used by explicitly setting it
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_DEBUG}")
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_RELEASE}")
elseif(CMAKE_BUILD_TYPE STREQUAL "Test")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_TEST}")
endif()

# Display build type
message_color(STATUS "*** Building in ${CMAKE_BUILD_TYPE} mode ***")
message_color(STATUS "*** FLAGS - ${CMAKE_C_FLAGS} ***")
