cmake_minimum_required(VERSION 3.10)

project(QCatGrayQuick LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Gui Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Gui Quick)

set(QCatGrayQuickPath ${CMAKE_CURRENT_SOURCE_DIR}/QCatGrayQt${QT_VERSION_MAJOR}Compat)
if (CMAKE_BUILD_TYPE MATCHES "Release")
    set(QCatGrayQuickImport "qrc:/qcatgrayquick_plugins" )
else()
    set(QCatGrayQuickImport "file:///${QCatGrayQuickPath}")
endif()

add_definitions(-DQCatGrayQuickImportPath="${QCatGrayQuickImport}")

if(NOT QML_IMPORT_PATH MATCHES ${QCatGrayQuickPath})
set(QML_IMPORT_PATH
    "${QML_IMPORT_PATH}"
    "${QCatGrayQuickPath}"
    CACHE STRING "QCatGrayQuick qml import path" FORCE)
set(QML2_IMPORT_PATH
    "${QML_IMPORT_PATH}"
    "${QCatGrayQuickPath}"
    CACHE STRING "QCatGrayQuick qml2 import path" FORCE)
set(QML_DESIGNER_IMPORT_PATH
    "${QML_IMPORT_PATH}"
    "${QCatGrayQuickPath}"
    CACHE STRING "QCatGrayQuick qml designer import path" FORCE)
set(CAT_QT_CURRENT_VERSION ${QT_VERSION} CACHE STRING "" FORCE)
endif()


if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    set(QRC_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/QCatGrayQt6Compat/QCatGrayQuick/QCatGrayQuick.qrc)
    qt_add_resources(QML_QRC_RESOURCE ${QRC_SOURCE_FILES})
else(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    set(QRC_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/QCatGrayQt5Compat/QCatGrayQuick/QCatGrayQuick.qrc)
    qt5_add_resources(QML_QRC_RESOURCE ${QRC_SOURCE_FILES})
endif(${QT_VERSION_MAJOR} GREATER_EQUAL 6)

if(TARGET QCatGrayQuickTableViewModel)
  add_definitions(-DQCATGRAYQUICKTABLEVIEWMODEL_TARGET)
  set(QCATGRAYQUICKTABLEVIEWMODEL_TARGET ON)
endif()


add_library(${PROJECT_NAME} STATIC ${QML_QRC_RESOURCE}
    QCatGrayQuickPlugins.h QCatGrayQuickPlugins.cpp)

target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Gui
        Qt${QT_VERSION_MAJOR}::Quick)

if (DEFINED QCATGRAYQUICKTABLEVIEWMODEL_TARGET)
    target_link_libraries(${PROJECT_NAME}
        PRIVATE QCatGrayQuickTableViewModel
            )
endif()

target_include_directories(${PROJECT_NAME} INTERFACE "${CMAKE_CURRENT_SOURCE_DIR}")
