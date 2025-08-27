cmake_minimum_required(VERSION 3.18.0)

# Include file check macros honor CMAKE_REQUIRED_LIBRARIES.
cmake_policy(SET CMP0075 NEW)
# MSVC runtime library flags are selected by an abstraction.
cmake_policy(SET CMP0091 NEW)

# **************************************************************************** #
#                                   PROJECT                                    #
# **************************************************************************** #

project(dr-quine C)

if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    # Static compilation of runtime library (/MT, /MTd)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

# Set c standard and force it into the cache
set(CMAKE_C_STANDARD 11 CACHE STRING "" FORCE)
set(CMAKE_C_EXTENSIONS OFF)
# Force generation of a compile commands file
set(CMAKE_EXPORT_COMPILE_COMMANDS ON CACHE BOOL "" FORCE)

# **************************************************************************** #
#                                  PROFILES                                    #
# **************************************************************************** #

get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

if(isMultiConfig)
    #if (CMAKE_CONFIGURATION_TYPES)
    #    set(CMAKE_CONFIGURATION_TYPES "Debug;Release;RelWithDebInfo;MinSizeRel" CACHE STRING "Available configurations" FORCE)
    #endif()
    if(NOT "Asan" IN_LIST CMAKE_CONFIGURATION_TYPES)
        list(APPEND CMAKE_CONFIGURATION_TYPES Asan)
    endif()
else()
    set(allowedBuildTypes Debug Release RelWithDebInfo MinSizeRel Asan)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "${allowedBuildTypes}")

    if(CMAKE_BUILD_TYPE AND NOT CMAKE_BUILD_TYPE IN_LIST allowedBuildTypes)
        message(FATAL_ERROR "Invalid build type: ${CMAKE_BUILD_TYPE}")
    endif()
endif()

set(CMAKE_C_FLAGS_ASAN
        "${CMAKE_C_FLAGS_DEBUG}" CACHE STRING
        "Flags used by the C compiler for Asan build type or configuration." FORCE)

set(CMAKE_CXX_FLAGS_ASAN
        "${CMAKE_CXX_FLAGS_DEBUG}" CACHE STRING
        "Flags used by the C++ compiler for Asan build type or configuration." FORCE)

set(CMAKE_EXE_LINKER_FLAGS_ASAN
        "${CMAKE_EXE_LINKER_FLAGS_DEBUG}" CACHE STRING
        "Linker flags to be used to create executables for Asan build type." FORCE)

set(CMAKE_SHARED_LINKER_FLAGS_ASAN
        "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}" CACHE STRING
        "Linker flags to be used to create shared libraries for Asan build type." FORCE)

set(CMAKE_MODULE_LINKER_FLAGS_ASAN
        "${CMAKE_MODULE_LINKER_FLAGS_DEBUG}" CACHE STRING
        "Linker flags to be used to create module libraries for Asan build type." FORCE)

# Function to apply ASan flags if the build type is Asan
function(add_asan_flags target)
    if(CMAKE_BUILD_TYPE STREQUAL "Asan")
        if (MSVC)
            target_compile_options(${target} PRIVATE /fsanitize=address)
            target_link_options(${target} PRIVATE /fsanitize=address)
        else()
            target_compile_options(${target} PRIVATE -fsanitize=address -fsanitize=leak -fno-omit-frame-pointer)
            target_link_options(${target} PRIVATE -fsanitize=address -fsanitize=leak)
        endif()
    endif()
endfunction()

# Function to apply Warning flags
function(add_warn_flags target)
    if(MSVC)
        target_compile_options(${target} PRIVATE /W4 /WX)
    else()
        target_compile_options(${target} PRIVATE -Wall -Wextra -Werror -Wpedantic)
    endif()
endfunction()

# **************************************************************************** #
#                                  EXECUTABLE                                  #
# **************************************************************************** #

# Find every C source in the project root (no subfolders).
file(GLOB ROOT_C_SOURCES "${CMAKE_SOURCE_DIR}/*.c")

if(ROOT_C_SOURCES STREQUAL "")
    message(FATAL_ERROR "No .c files found in project root.")
endif()

set(ALL_ROOT_TARGETS "")
foreach(src ${ROOT_C_SOURCES})
    get_filename_component(name "${src}" NAME_WE)

    add_executable(${name} "${src}")
    add_warn_flags(${name})
    add_asan_flags(${name})

    # Windows properties
    if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
        set_target_properties(${target} PROPERTIES WIN32_EXECUTABLE FALSE)
    endif()

    # Put all built binaries under <build>/bin
    set_target_properties(${name} PROPERTIES
            RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin"
    )

    list(APPEND ALL_ROOT_TARGETS ${name})
endforeach()

# **************************************************************************** #
#                          IDE / WINDOWS QUALITY-OF-LIFE                       #
# **************************************************************************** #

if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    # Set the first discovered target as the startup project in Visual Studio
    list(LENGTH ALL_ROOT_TARGETS _n_targets)
    if(_n_targets GREATER 0)
        list(GET ALL_ROOT_TARGETS 0 _first)
        set_property(DIRECTORY PROPERTY VS_STARTUP_PROJECT ${_first})
        # Make VS debugger working dir the target's output dir
        set_property(TARGET ${_first} PROPERTY VS_DEBUGGER_WORKING_DIRECTORY $<TARGET_FILE_DIR:${_first}>)
    endif()
endif()
