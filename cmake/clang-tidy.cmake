# ----------------------------------------------------------------------------
# BRIEF -- clang-tidy.cmake
# ----------------------------------------------------------------------------
# Configures and integrates clang-tidy for static analysis in the project.
#
# Features:
# - Defines suppressed clang-tidy checks to tailor analysis for project needs
# - Enables clang-tidy if specified via ENABLE_CLANG_TIDY option
# - Optionally treats warnings as errors in Debug builds or if enabled
#
# Usage:
# - Adjust suppressed checks in CLANG_TIDY_SUPPRESSED_CHECKS as needed
# ----------------------------------------------------------------------------

# Define clang-tidy checks
string(
    CONCAT
        CLANG_TIDY_SUPPRESSED_CHECKS
        "*,-readability-function-cognitive-complexity," # --------------------------Suppress complex func warnings; refactoring may be deferred.
        "-altera*," # --------------------------------------------------------------Suppress Altera-specific checks; not relevant for most projects.
        "-cert-dcl03-c," # ---------------------------------------------------------Suppress CERT rule for block scope declarations.
        "-misc-static-assert," # ---------------------------------------------------Suppress warnings on static asserts; may be intentional.
        "-llvm-include-order," # ---------------------------------------------------Suppress LLVM-specific include order warnings.
        "-llvmlibc-*," # -----------------------------------------------------------Suppress LLVM libc checks; likely unused in most cases.
        "-hicpp-*," # --------------------------------------------------------------Suppress strict High Integrity C++ checks.
        "-concurrency-mt-unsafe," # ------------------------------------------------Suppress multi-threading safety warnings.
        "-bugprone-easily-swappable-parameters," # ---------------------------------Suppress warnings on swappable params.
        "-cppcoreguidelines-*," # --------------------------------------------------Suppress C++ Core Guidelines warnings.
        "-readability-magic-numbers," # --------------------------------------------Suppress warnings on hardcoded values.
        "-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling," # -Suppress deprecated buffer usage warnings.
        "-misc-no-recursion," # ----------------------------------------------------Suppress recursion-related warnings.
        "-performance-no-int-to-ptr" # ---------------------------------------------Suppress int-to-pointer cast warnings.
)

# Clang-tidy setup
find_program(CLANG_TIDY_PROG clang-tidy)

if(ENABLE_CLANG_TIDY AND CLANG_TIDY_PROG)
    set(CMAKE_C_CLANG_TIDY
        "${CLANG_TIDY_PROG};-checks=${CLANG_TIDY_SUPPRESSED_CHECKS}")
    if(CMAKE_BUILD_TYPE STREQUAL "Debug" OR ENABLE_WARN_AS_ERR)
        set(CMAKE_C_CLANG_TIDY "${CMAKE_C_CLANG_TIDY};-warnings-as-errors=*")
    endif()
endif()
