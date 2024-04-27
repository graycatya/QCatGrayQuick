cmake_minimum_required(VERSION 3.5)

project(catgrayquicktest VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Gui Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Gui Quick)


if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    set(QRC_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/resources/resources.qrc)
    qt_add_resources(QML_QRC_RESOURCE ${QRC_SOURCE_FILES})
else(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    set(QRC_SOURCE_FILES ${CMAKE_CURRENT_SOURCE_DIR}/resources/resources.qrc)
    qt5_add_resources(QML_QRC_RESOURCE ${QRC_SOURCE_FILES})
endif(${QT_VERSION_MAJOR} GREATER_EQUAL 6)

set(PROJECT_SOURCES
        main.cpp
)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(${PROJECT_NAME}
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        ${QML_QRC_RESOURCE}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET ${PROJECT_NAME} APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(${PROJECT_NAME} SHARED
            ${PROJECT_SOURCES}
            ${QML_QRC_RESOURCE}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(${PROJECT_NAME}
            ${PROJECT_SOURCES}
            ${QML_QRC_RESOURCE}
        )
    endif()
endif()
target_link_libraries(${PROJECT_NAME}
    PRIVATE
        Qt${QT_VERSION_MAJOR}::Core
        Qt${QT_VERSION_MAJOR}::Gui
        Qt${QT_VERSION_MAJOR}::Quick
        QCatGrayQuick)
