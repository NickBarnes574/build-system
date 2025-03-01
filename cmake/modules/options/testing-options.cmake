# ----------------------------------------------------------------------------
# BRIEF -- testing-options.cmake
# ----------------------------------------------------------------------------
# Configures test-related flags and settings.
# ----------------------------------------------------------------------------

if(CMAKE_BUILD_TYPE STREQUAL "Test")
    message(STATUS "*** Enabling Testing Mode ***")
    enable_testing()
    set(CTEST_RERUN_FAILED ON CACHE BOOL "Rerun failed tests automatically")
    set(CTEST_OUTPUT_ON_FAILURE ON CACHE BOOL "Show output on test failure")
endif()
