# CMakeLists.txt demo of how to link Boost static and shared libraries

The purpose of this project is to demonstrate how to write a CMakeLists.txt script to link Boost static and shared libraries. Boost needs to be preinstalled on the user's computer and a path to BoostConfig.cmake provided either in 
[./CMakeUtils/FindOrFetch/FindDoNotFetchBoost.cmake](./CMakeUtils/FindOrFetch/FindDoNotFetchBoost.cmake)
(adjust it there if necessary), 
or passed in at the CMake configure step via the flag `-D Boost_DIR=/path/to/BoostConfig.cmake/`. 

The program uses Boost Serialization to serialize and deserialize a custom data type:
```
class Data
{
    ...
    private:
        int x1 {};
        double x2 {};
        char x3 {};
        std::string x4{};
};
```
into a binary stream. Boost Regex and Boost Date_Time are also used just for good measure.

## Commands to compile, link, and run the program

It is assumed that both shared and static Boost libraries have been installed. To link
Boost dynamically (as shared libraries), the flag
`-D Boost_USE_STATIC_LIBS=OFF` needs to be provided at the CMake configure step. (On Windows, boost_serialization-*.dll and others will be copied by CMake next to the executable).

To link Boost statically the flag should be set to: 
`-D Boost_USE_STATIC_LIBS=ON`, 
or it can be left off because the default is "ON" - but only at the first configure step.

If building interchangeably several times into the same build directory: static then shared libraries (or vice versa), then in that case it is necessary to also add "--fresh" flag:
`-D Boost_USE_STATIC_LIBS=<ON/OFF> --fresh` to clear settings that were written to CMakeCache.txt at the previous configure step (omit the square brackets below).

### Windows, MSVC compiler

Run in *Developer Command Prompt for VS*

```
cmake --preset NinjaMC-Msvc -D Boost_DIR=/path/to/BoostConfig.cmake/ -D Boost_USE_STATIC_LIBS=<ON/OFF> [ --fresh ]
cmake --build --preset NinjaMC-Msvc --config Debug --target run
cmake --build --preset NinjaMC-Msvc --config Release --target run
cmake --build --preset NinjaMC-Msvc --config RelWithDebInfo --target run
```

### Linux/Mac GNU compiler

```
cmake --preset NinjaMC-Gnu -D Boost_DIR=/path/to/BoostConfig.cmake/ -D Boost_USE_STATIC_LIBS=<ON/OFF> [ --fresh ]
cmake --build --preset NinjaMC-Gnu --config Debug --target run
cmake --build --preset NinjaMC-Gnu --config Release --target run
cmake --build --preset NinjaMC-Gnu --config RelWithDebInfo --target run
```

### Linux/Mac Clang compiler

```
cmake --preset NinjaMC-Clang -D Boost_DIR=/path/to/BoostConfig.cmake/ -D Boost_USE_STATIC_LIBS=<ON/OFF> [ --fresh ]
cmake --build --preset NinjaMC-Clang --config Debug --target run
cmake --build --preset NinjaMC-Clang --config Release --target run
cmake --build --preset NinjaMC-Clang --config RelWithDebInfo --target run
```

Run `cmake --list-presets all` to see a full list of available presets on your platform, they are named according to the forms
- for single-config generators: *generator-compiler-buildType*
- for multi-config generators: *generator-compiler*.

For an example of how in CMakeLists.txt to link header-only libraries, please see: 
[CMakeLinkBoostHeaderOnly](https://github.com/MariuszJozef/CMakeLinkBoostHeaderOnly.git).
