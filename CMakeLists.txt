﻿cmake_minimum_required(VERSION 3.9)

project(QCatGrayQuickProjects LANGUAGES CXX)

if (UNIX)
add_compile_options(-Wall -fPIC -Wno-stringop-overflow)
endif(UNIX)

message(STATUS "------------------------------------------------------------" )
message(STATUS "[${PROJECT_NAME}] Configuration summary."                     )
message(STATUS "------------------------------------------------------------ ")
message(STATUS " System configuration:"                                       )
message(STATUS " .. Processor type .............. = ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS " .. CMake executable ............ = ${CMAKE_COMMAND}"         )
message(STATUS " .. CMake version ............... = ${CMAKE_VERSION}"         )
message(STATUS " .. System name ................. = ${CMAKE_SYSTEM}"          )
message(STATUS " .. C++ compiler ................ = ${CMAKE_CXX_COMPILER}"    )
message(STATUS " .. C compiler .................. = ${CMAKE_C_COMPILER}"      )
message(STATUS " .. size(void*) ................. = ${CMAKE_SIZEOF_VOID_P}"   )
message(STATUS " .. cmake current source ................. = ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS " .. cmake system name ................. = ${CMAKE_SYSTEM_NAME}")

# build option
option(QCATGRAYQUICKPROJECTS_EXAMPLES "Build examples" OFF)

set(3RDPARTY
    libqrencode
    lottie-qml
)

set(MODULES
    QCatGrayQuickQrenCodeQml
    QCatGrayQuickChatModel
    QCatGrayQuickTableViewModel
    qml
)

set(EXAMPLES
    catgrayquicktest
    qrencodeqml
)

foreach(3rdparty_module ${3RDPARTY})
    if(${3rdparty_module} STREQUAL "libqrencode")
        if(NOT TARGET qrencode)
            if(APPLE)
                set(WITHOUT_PNG CACHE BOOL "WITHOUT_PNG OFF" FORCE OFF)
            else()
                set(WITH_TOOLS NO CACHE BOOL "WITH_TOOLS NO" FORCE)
                set(WITHOUT_PNG CACHE BOOL "WITHOUT_PNG OFF" FORCE OFF)
            endif()
            add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/${3rdparty_module})
        endif()
    else()
        add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/${3rdparty_module})
    endif()
endforeach(3rdparty_module ${3RDPARTY})

foreach(module ${MODULES})
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/src/${module})
endforeach(module ${MODULES})

if(QCATGRAYQUICKPROJECTS_EXAMPLES)
foreach(example ${EXAMPLES})
    add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/examples/${example})
endforeach(example ${EXAMPLES})
endif()

message(STATUS " .. qt version ................. = ${CAT_QT_CURRENT_VERSION}")
message(STATUS " .. qml import path ................. = ${QML_IMPORT_PATH}")
message(STATUS " .. qml2 import path ................. = ${QML2_IMPORT_PATH}")
message(STATUS " .. qml designer import path ................. = ${QML_DESIGNER_IMPORT_PATH}")

message(STATUS "------------------------------------------------------------ ")
