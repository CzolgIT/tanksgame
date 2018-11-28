SET(SDL2_SEARCH_PATHS
	~/Library/Frameworks
	/Library/Frameworks
	/usr/local
	/usr
	/sw
	/opt/local
	/opt/csw
	/opt
)
FIND_PATH(SDL2_INCLUDE_DIR SDL.h
	HINTS
	$ENV{SDL2DIR}
	PATH_SUFFIXES include/SDL2 include
	PATHS ${SDL2_SEARCH_PATHS}
)
FIND_LIBRARY(SDL2_LIBRARY_TEMP
	NAMES SDL2
	HINTS
	$ENV{SDL2DIR}
	PATH_SUFFIXES lib64 lib
	PATHS ${SDL2_SEARCH_PATHS}
)
IF(NOT SDL2_BUILDING_LIBRARY)
	IF(NOT ${SDL2_INCLUDE_DIR} MATCHES ".framework")
		FIND_LIBRARY(SDL2MAIN_LIBRARY
			NAMES SDL2main
			HINTS
			$ENV{SDL2DIR}
			PATH_SUFFIXES lib64 lib
			PATHS ${SDL2_SEARCH_PATHS}
		)
	ENDIF(NOT ${SDL2_INCLUDE_DIR} MATCHES ".framework")
ENDIF(NOT SDL2_BUILDING_LIBRARY)
IF(NOT APPLE)
	FIND_PACKAGE(Threads)
ENDIF(NOT APPLE)
IF(MINGW)
	SET(MINGW32_LIBRARY mingw32 CACHE STRING "mwindows for MinGW")
ENDIF(MINGW)
IF(SDL2_LIBRARY_TEMP)
	IF(NOT SDL2_BUILDING_LIBRARY)
		IF(SDL2MAIN_LIBRARY)
			SET(SDL2_LIBRARY_TEMP ${SDL2MAIN_LIBRARY} ${SDL2_LIBRARY_TEMP})
		ENDIF(SDL2MAIN_LIBRARY)
	ENDIF(NOT SDL2_BUILDING_LIBRARY)
	IF(APPLE)
		SET(SDL2_LIBRARY_TEMP ${SDL2_LIBRARY_TEMP} "-framework Cocoa")
	ENDIF(APPLE)
	IF(NOT APPLE)
		SET(SDL2_LIBRARY_TEMP ${SDL2_LIBRARY_TEMP} ${CMAKE_THREAD_LIBS_INIT})
	ENDIF(NOT APPLE)
	IF(MINGW)
		SET(SDL2_LIBRARY_TEMP ${MINGW32_LIBRARY} ${SDL2_LIBRARY_TEMP})
	ENDIF(MINGW)
	SET(SDL2_LIBRARY ${SDL2_LIBRARY_TEMP} CACHE STRING "Where the SDL2 Library can be found")
	SET(SDL2_LIBRARY_TEMP "${SDL2_LIBRARY_TEMP}" CACHE INTERNAL "")
ENDIF(SDL2_LIBRARY_TEMP)
INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL2 REQUIRED_VARS SDL2_LIBRARY SDL2_INCLUDE_DIR)