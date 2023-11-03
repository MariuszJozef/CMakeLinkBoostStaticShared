#[==================================================[
Disallow in-source builds
#]==================================================]
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
    message(FATAL_ERROR "In-source builds are discouraged and therefore prevented here! Use distinct source and build directories:\n\tcmake -S <srcDir> -B <buildDir> -G <generator> \nBut first manually remove \n\t<srcDir>/CMakeCache.txt \nand \n\t<srcDir>/CMakeFiles/ \nwhich have already been created and are polluting the source directory.")
endif()
