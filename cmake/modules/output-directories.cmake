# ----------------------------------------------------------------------------
# BRIEF -- output-directories.cmake
# ----------------------------------------------------------------------------
# Configures output directories for binaries, libraries, and archives.
#
# Features:
# - Organizes output by build type (Debug, Release, etc.)
# - Supports multi-config generators (e.g., Visual Studio, Ninja Multi-Config)
# - Allows users to override output root directory via OUTPUT_DIR
#
# Usage:
# - Include this file in CMakeLists.txt
# - Override default output directory with `-DOUTPUT_DIR=<path>`
# ----------------------------------------------------------------------------

# Ensure a default build type for single-config generators
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose build type (Debug, Release, RelWithDebInfo, MinSizeRel)" FORCE)
endif()

# Allow users to override the output directory
set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/${CMAKE_BUILD_TYPE}/deploy/remote CACHE PATH "Base output directory for build artifacts")

# Configure output directories for single-config generators
if(NOT CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR}/${ARCH}/bin)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${OUTPUT_DIR}/${ARCH}/libs/dynamic)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${OUTPUT_DIR}/${ARCH}/libs/static)
else()
    # Configure multi-config generators (e.g., Visual Studio, Ninja)
    foreach(CONFIG_TYPE ${CMAKE_CONFIGURATION_TYPES})
        set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_${CONFIG_TYPE} ${OUTPUT_DIR}/${CONFIG_TYPE}/${ARCH}/bin)
        set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_${CONFIG_TYPE} ${OUTPUT_DIR}/${CONFIG_TYPE}/${ARCH}/libs/dynamic)
        set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_${CONFIG_TYPE} ${OUTPUT_DIR}/${CONFIG_TYPE}/${ARCH}/libs/static)
    endforeach()
endif()

# # *** END OF FILE ***
