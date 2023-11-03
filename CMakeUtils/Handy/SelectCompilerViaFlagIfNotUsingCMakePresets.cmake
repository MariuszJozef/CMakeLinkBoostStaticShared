#[==================================================[
Compiler can be chosen by any of the following:

#1.
Before the cmake configure step, run in the shell:

export CC=gcc
export CXX=g++

OR

export CC=clang
export CXX=clang++

OR

export CC=cl.exe
export CXX=cl.exe

followed by the cmake configure command proper:

    cmake -S . -B <buildDir> -G <generator> -D CMAKE_BUILD_TYPE=<buildType>

but without providing the two flags:

-D CMAKE_C_COMPILER=<C compiler> -D CMAKE_CXX_COMPILER=<C++ compiler>

#2.
The environment variables CC, CXX can be overriden by CMAKE_C_COMPILER and CMAKE_CXX_COMPILER flags provided at the configure step:

    cmake -S . -B <buildDir> -G <generator> -D CMAKE_C_COMPILER=<C compiler> -D CMAKE_CXX_COMPILER=<C++ compiler>

N.B.
Use the '--fresh' directive if changing to a different compiler within the same build directory, e.g. for debug/release builds (but ideally use different (sub)directories for distinct compilers!):

    cmake -S . -B <buildDir/subDir> -G <generator> -D CMAKE_C_COMPILER=<some C compiler> -D CMAKE_CXX_COMPILER=<some C++ compiler> --fresh

    cmake -S . -B <buildDir/subDir> -G <generator> -D CMAKE_C_COMPILER=<another C compiler> -D CMAKE_CXX_COMPILER=<another C++ compiler> --fresh

#3.
Here convenience nicknames are defined (case sensitive):
    'gnu'   = gcc and g++
    'clang' = clang nad clang++
    'msvc'  = cl.exe

Assuming that these compilers are executable on your path, then:

    cmake -S . -B <buildDir> -G <generator> -D setCompiler=gnu

OR

    cmake -S . -B <buildDir> -G <generator> -D setCompiler=clang

OR

    cmake -S . -B <buildDir> -G <generator> -D setCompiler=msvc


N.B.
Use the '--fresh' directive if changing to a different compiler within the same build directory, e.g. for debug/release builds (but ideally use different (sub)directories for distinct compilers!):

    cmake -S . -B <buildDir/subDir> -G <generator> -D setCompiler=gnu --fresh
    cmake -S . -B <buildDir/subDir> -G <generator> -D setCompiler=clang --fresh
    cmake -S . -B <buildDir/subDir> -G <generator> -D setCompiler=msvc --fresh
#]==================================================]

if(DEFINED CMAKE_CXX_COMPILER)
    # Skip everything here because CMakePresets.json was invoked so compiler was already selected there
    message(STATUS "Skip compiler selection herein because CMakePresets.json was invoked and so compiler is already set")
    return()
endif()

if(NOT DEFINED CC)
    message(STATUS "CC  is undefined therefore will resort to default C compiler unless -D setCompier was used ...")
else()
    message(STATUS "C   compiler set by the environment, CC: ${CC}")
endif()
    
if(NOT DEFINED CXX)
    message(STATUS "CXX is undefined therefore will resort to default C++ compiler unless -D setCompier was used ...")
else()
    message(STATUS "C++ compiler set by the environment, CXX: ${CXX}")
endif()

#[==================================================[
setCompiler covenience flag: -D setCompiler=<gnu|clang|msvc>
If left out, a default compiler will be used, or a compiler that was set in the shell's environment via CC, CXX (as in #1 above)
#]==================================================]
if(NOT DEFINED setCompiler)
    message(STATUS "setCompiler is undefined therefore using default compiler ...")
else()
    string(TOLOWER "${setCompiler}" setCompilerLower)
    message(STATUS "setCompiler: " ${setCompiler})

    if(${setCompilerLower} STREQUAL msvc)

        if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL Windows)
            set(CMAKE_CXX_COMPILER cl.exe CACHE STRING "Visual Studio compiler path" FORCE)
            set(CMAKE_C_COMPILER   cl.exe CACHE STRING "Visual Studio compiler path" FORCE)
            message(STATUS "Selected compiler - MSVC: " ${CMAKE_CXX_COMPILER})
        else()
            message(WARNING "MSVC compiler cannot be used on ${CMAKE_HOST_SYSTEM_NAME}! Resorting to default compiler ...")
        endif()
        
    elseif(${setCompilerLower} STREQUAL gnu)
        set(CMAKE_CXX_COMPILER g++ CACHE STRING "g++ compiler path" FORCE)
        set(CMAKE_C_COMPILER   gcc CACHE STRING "gcc compiler path" FORCE)
        message(STATUS "Selected compiler - GNU: " ${CMAKE_CXX_COMPILER})
    elseif(${setCompilerLower} STREQUAL clang)
        set(CMAKE_CXX_COMPILER clang++ CACHE STRING "clang++ compiler path" FORCE)
        set(CMAKE_C_COMPILER   clang   CACHE STRING "clang compiler path" FORCE)
        message(STATUS "Selected compiler - CLANG: " ${CMAKE_CXX_COMPILER})
    else()
        message(WARNING "Invalid setCompiler option! Resorting to default compiler. Next time use:\n\t-D setCompiler=<compilerNickName>\nwhere compilerNickName is any of (case insensitive): 'msvc', 'gnu', clang'. Or omit this option entirely to use default compiler.")
    endif()
endif()
