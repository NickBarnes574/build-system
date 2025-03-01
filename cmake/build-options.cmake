# ----------------------------------------------------------------------------
# BRIEF -- build-options.cmake
# ----------------------------------------------------------------------------
# Configures compiler options and build settings for different build types.
#
# Features:
# - Defines common compile options and specific options for Debug, Test,
#   and Release builds
# - Supports Address Sanitizer (if ENABLE_ADSAN is ON)
# - Enables treating warnings as errors if ENABLE_WARN_AS_ERR is set
#
# Usage:
# - Modify options as needed for custom project build configurations
# ----------------------------------------------------------------------------

# Common compile options
set(COMMON_COMPILE_OPTIONS
    -std=c17
    -Wall
    -Wextra
    -pedantic)
set(DEBUG_COMPILE_OPTIONS -Werror -g)
set(ADSAN_COMPILE_OPTIONS -fsanitize=address)
set(TEST_COMPILE_OPTIONS -g)
set(RELEASE_COMPILE_OPTIONS -O3)
set(DEBUG_COMPILE_DEFINITIONS DEBUG)
set(RELEASE_COMPILE_DEFINITIONS NDEBUG)

# Apply common compile options
add_compile_options(${COMMON_COMPILE_OPTIONS})

# Handle different build types
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    message_color(STATUS "*** Building in DEBUG mode ***")
    add_compile_options(${DEBUG_COMPILE_OPTIONS})
    add_compile_definitions(${DEBUG_COMPILE_DEFINITIONS})
    if(ENABLE_ADSAN)
        message_color(STATUS Yellow "Address Sanitizer [ENABLED]")
        add_compile_options(${ADSAN_COMPILE_OPTIONS})
        link_libraries(-fsanitize=address)
    endif()
elseif(CMAKE_BUILD_TYPE STREQUAL "Test")
    message_color(STATUS "*** Building in TEST mode ***")
    enable_testing()
    set(CTEST_RERUN_FAILED ON)
    set(CTEST_OUTPUT_ON_FAILURE ON)
    add_compile_options(${TEST_COMPILE_OPTIONS})
elseif(CMAKE_BUILD_TYPE STREQUAL "Release")
    message_color(STATUS "*** Building in RELEASE mode ***")
    add_compile_options(${RELEASE_COMPILE_OPTIONS})
    add_compile_definitions(${RELEASE_COMPILE_DEFINITIONS})
else()
    message_color(
        WARNING
        "Unknown build type: ${CMAKE_BUILD_TYPE}. Defaulting to RELEASE mode.")
    set(CMAKE_BUILD_TYPE Release)
    add_compile_options(${RELEASE_COMPILE_OPTIONS})
    add_compile_definitions(${RELEASE_COMPILE_DEFINITIONS})
endif()

# Apply -Werror if ENABLE_WARN_AS_ERR is set
if(ENABLE_WARN_AS_ERR)
    message_color(STATUS
                  "Treating warnings as errors (ENABLE_WARN_AS_ERR is ON)")
    add_compile_options(-Werror)
endif()
