cmake_minimum_required(VERSION 3.26.0...3.26.3)

include(CMakeUtils/Handy/DisallowInSourceBuilds.cmake) # Comment out to allow
include(CMakeUtils/Handy/SelectCompilerViaFlagIfNotUsingCMakePresets.cmake) # or else default compiler will be used

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
project(LinkBoostAsStaticOrShared VERSION 0.1.0 LANGUAGES C CXX)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

include(CMakeUtils/Handy/DisplayGenericInfo.cmake) # Comment out to suppress

#[==================================================[
Find or fetch a library and display its cmake targets
#]==================================================]
option(Boost_USE_STATIC_LIBS "ON to link Boost as static libraries, OFF as dynamic - on Windows the latter requires the *.dll to be copied next to the .exe (this is done in the parent CMakeLists.txt)" ON)

if(Boost_USE_STATIC_LIBS)
    set(isThereDllToLink OFF)
    message(STATUS "Boost_USE_STATIC_LIBS: " ${Boost_USE_STATIC_LIBS} " --- Boost will be linked as STATIC library")
else()
    set(isThereDllToLink ON)
    message(STATUS "Boost_USE_STATIC_LIBS: " ${Boost_USE_STATIC_LIBS} " --- Boost will be linked as SHARED library")
endif()

include(CMakeUtils/FindOrFetch/FindDoNotFetchBoost.cmake)

get_property(importTargets1 DIRECTORY ${SOURCE_DIR} PROPERTY IMPORTED_TARGETS)
message(STATUS "importTargets1: ${importTargets1}")

#[==================================================[
Build (sub)project(s)
#]==================================================]
add_subdirectory(LinkBoostAsStaticOrShared)

#[==================================================[
Link executable with found/fetched libraries
#]==================================================]
target_link_libraries(targetExe 
    PRIVATE 
        Boost::serialization
        Boost::regex
        Boost::date_time
)

#[==================================================[
Run the executable 
#]==================================================]
add_custom_target(run
    COMMAND ${CMAKE_COMMAND} -E echo "execute: $<TARGET_FILE:targetExe>"
    COMMAND $<TARGET_FILE:targetExe>
)

#[==================================================[
(Optional) IDE solution name
Must be after all other projects since last project(...) is used as solution name
#]==================================================]
if (CMAKE_GENERATOR MATCHES "Visual Studio" OR  # any VS generator
    CMAKE_GENERATOR MATCHES "Eclipse CDT4")     # any Eclipse generator

    project(LinkBoostAsStaticOrSharedExample)

endif()
