#[==================================================[
Info about generator and platform architecture settings
#]==================================================]
get_property(isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)

if(isMultiConfig)
    set(BUILD_PATH_TO_EXE1 ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/$<CONFIG>)
else()
    set(BUILD_PATH_TO_EXE1 ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
endif()

message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")
message(STATUS "CMAKE_GENERATOR: ${CMAKE_GENERATOR}")
# message("CMAKE_GENERATOR_PLATFORM: ${CMAKE_GENERATOR_PLATFORM}")#
message(STATUS "GENERATOR_IS_MULTI_CONFIG: ${isMultiConfig}")

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    message(STATUS "64 bit archtecture build, CMAKE_SIZEOF_VOID_P: ${CMAKE_SIZEOF_VOID_P}")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    message(STATUS "32 bit archtecture build, CMAKE_SIZEOF_VOID_P: ${CMAKE_SIZEOF_VOID_P}")
endif()

#[==================================================[
Info about compiler
#]==================================================]
if(MSVC)
    message(STATUS "Compiling with MSVC")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    message(STATUS "Compiling with GNU")
elseif(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    message(STATUS "Compiling with Clang")
else()
    message(STATUS "Compiling with ...")
endif()

message(STATUS "CMAKE_C_COMPILER: ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_C_COMPILER_ID: ${CMAKE_C_COMPILER_ID}")
message(STATUS "CMAKE_C_STANDARD: ${CMAKE_C_STANDARD}")
message(STATUS "CMAKE_C_FLAGS: ${CMAKE_C_FLAGS}")

message(STATUS "CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER_ID: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "CMAKE_CXX_COMPILER_VERSION: ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "CMAKE_CXX_STANDARD: ${CMAKE_CXX_STANDARD}")
message(STATUS "CMAKE_CXX_FLAGS: ${CMAKE_CXX_FLAGS}")
message(STATUS "CMAKE_CXX_FLAGS_DEBUG: ${CMAKE_CXX_FLAGS_DEBUG}")
message(STATUS "CMAKE_CXX_FLAGS_RELEASE: ${CMAKE_CXX_FLAGS_RELEASE}")
message(STATUS "CMAKE_CXX_FLAGS_RELWITHDEBINFO: ${CMAKE_CXX_FLAGS_RELWITHDEBINFO}")
message(STATUS "CMAKE_CXX_FLAGS_MINSIZEREL: ${CMAKE_CXX_FLAGS_MINSIZEREL}")
message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

#[==================================================[
Info about CMake's directories (platform agnostic)
#]==================================================]
message(STATUS "CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT: ${CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT}")
message(STATUS "CMAKE_INSTALL_PREFIX: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "CMAKE_INSTALL_INCLUDEDIR: ${CMAKE_INSTALL_INCLUDEDIR}")
message(STATUS "CMAKE_INSTALL_LIBDIR: ${CMAKE_INSTALL_LIBDIR}")
message(STATUS "CMAKE_CURRENT_LIST_DIR: ${CMAKE_CURRENT_LIST_DIR}")
message(STATUS "CMAKE_INSTALL_DATADIR: ${CMAKE_INSTALL_DATADIR}")

# message("CMAKE_FIND_LIBRARY_PREFIXES: ${CMAKE_FIND_LIBRARY_PREFIXES}")#
# message("CMAKE_FIND_LIBRARY_SUFFIXES: ${CMAKE_FIND_LIBRARY_SUFFIXES}")#
# message("CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")#

if (CMAKE_GENERATOR MATCHES "Eclipse CDT4")
    message(STATUS "CMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT: ${CMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT}")
    message(STATUS "CMAKE_ECLIPSE_VERSION: ${CMAKE_ECLIPSE_VERSION}")
    message(STATUS "CMAKE_ECLIPSE_MAKE_ARGUMENTS: ${CMAKE_ECLIPSE_MAKE_ARGUMENTS}")
endif()
