#[==================================================[
Find preinstaled Boost package
Do NOT fetch because building takes too long!
#]==================================================]
set(packageName Boost)
set(Boost_NO_SYSTEM_PATHS ON)
set(Boost_USE_MULTITHREADED ON)

#[==================================================[
Point the path to ${packageName}Config.cmake or ${packageName}-config.cmake
if the package is not on the standard search path nor in CMAKE_INSTALL_PREFIX
#]==================================================]
if(Boost_USE_STATIC_LIBS)

    if (WIN32 OR MSVC)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
        set(${packageName}_DIR C:/Packages/Boost1.82.0/static/lib/cmake/Boost-1.82.0)
        set(packageVersion 1.82.0)
    elseif(LINUX)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
        set(${packageName}_DIR /usr/lib64/cmake/Boost-1.78.0)
        set(packageVersion 1.78.0)
    elseif(APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
        set(${packageName}_DIR /usr/local/Cellar/boost/1.71.0/lib/cmake/Boost-1.71.0)
        set(packageVersion 1.71.0)
        set(${packageName}_DIR )
    elseif (UNIX AND NOT APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
        set(${packageName}_DIR )
    endif()

else()

    if (WIN32 OR MSVC)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll")
        set(${packageName}_DIR C:/Packages/Boost1.82.0/shared/lib/cmake/Boost-1.82.0)
        set(packageVersion 1.82.0)
    elseif(LINUX)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".so")
        set(${packageName}_DIR /usr/lib64/cmake/Boost-1.78.0)
        set(packageVersion 1.78.0)
    elseif(APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".dylib")
        set(${packageName}_DIR /usr/local/Cellar/boost/1.71.0/lib/cmake/Boost-1.71.0)
        set(packageVersion 1.71.0)
        set(${packageName}_DIR )
    elseif (UNIX AND NOT APPLE)
        set(CMAKE_FIND_LIBRARY_SUFFIXES ".so")
        set(${packageName}_DIR )
    endif()

endif()

find_package(${packageName} ${packageVersion} COMPONENTS serialization regex date_time REQUIRED)

if(${packageName}_FOUND)
    message(STATUS "${packageName}_FOUND: ${${packageName}_FOUND}")
    message(STATUS "${packageName}_VERSION: ${${packageName}_VERSION}")
    message(STATUS "${packageName}_INCLUDE_DIRS: ${${packageName}_INCLUDE_DIRS}")
    message(STATUS "${packageName}_LIBRARIES: ${${packageName}_LIBRARIES}")

    include_directories("${Boost_INCLUDE_DIRS}")    
endif()
