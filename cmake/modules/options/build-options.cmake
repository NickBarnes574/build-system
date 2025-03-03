# ----------------------------------------------------------------------------
# BRIEF -- build-options.cmake
# ----------------------------------------------------------------------------
# Configures common compiler options and build settings.
# This file is included in the main CMakeLists.txt.
#
# Features:
# - Ensures a default build type is set if not provided
# - Configures compile options based on build type (Debug, Release, Test)
# - Uses `message_color` to display configured build flags
# - Supports per-target flag application using `apply_build_flags()`
#
# Usage:
# - Include this file in CMakeLists.txt
# - Call `apply_build_flags(<target>)` to set compile flags per target
# ----------------------------------------------------------------------------

include(${CMAKE_CURRENT_LIST_DIR}/color-options.cmake)

function(set_build_preferences)
    # Default to Release mode if not set
    if(NOT CMAKE_BUILD_TYPE)
        set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose build type (Debug, Release, Test)" FORCE)
    endif()

    # Display build type
    message_color(STATUS "*** Building in ${CMAKE_BUILD_TYPE} mode ***")
endfunction()

# *** END OF FILE ***
