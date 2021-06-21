cmake_minimum_required(VERSION 3.14)

project(Todo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 COMPONENTS Core Quick Qml Gui QuickControls2 REQUIRED)
#find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

# list the header files
set(HEADER_FILES
        include/model/modeltodo.h
)

# list the source files
set(SOURCE_FILES
        src/model/modeltodo.cpp
        src/main.cpp
)

# list resources files
set(RESOURCES_FILES
    ui/qml.qrc
)

file(GLOB_RECURSE PROJECT_SOURCES
    "${RESOURCES_FILES}/*.ui"
    "${RESOURCES_FILES}/*.qrc"
)

add_executable(Todo WIN32 ${PROJECT_SOURCES})

target_sources(Todo
        PRIVATE
        ${HEADER_FILES}
        ${SOURCE_FILES}
        ${RESOURCES_FILES}
)

set_target_properties(Todo PROPERTIES FOLDER Todo)

target_link_libraries(Todo
        PUBLIC
        Qt6::Core
        Qt6::Gui
        Qt6::Qml
        Qt6::Quick
        Qt6::QuickControls2
)

#set(RESOURCES_DIR "${CMAKE_SOURCE_DIR}/UI")
#set(INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")
#set(SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")

#include_directories(${RESOURCES_DIR})
#include_directories(${INCLUDE_DIR})
#include_directories(${SOURCE_DIR})

#file(GLOB_RECURSE SOURCES
#    "${RESOURCES_DIR}/*.ui"
#    "${RESOURCES_DIR}/*.qrc"
#    "${INCLUDE_DIR}/*.h"
#    "${SOURCE_DIR}/*.cpp"
#)

#if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
#    qt_add_executable(Todo
#        MANUAL_FINALIZATION
#        ${PROJECT_SOURCES}
#    )
#else()
#    if(ANDROID)
#        add_library(Todo SHARED
#            ${PROJECT_SOURCES}
#        )
#    else()
#        add_executable(Todo
#          ${PROJECT_SOURCES}
#        )
#    endif()
#endif()

#target_compile_definitions(Todo
#  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
#target_link_libraries(Todo
#  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)

##set_target_properties(Todo PROPERTIES
##    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
##    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
##    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
##)

##if(QT_VERSION_MAJOR EQUAL 6)
##    qt_import_qml_plugins(Todo)
##    qt_finalize_executable(Todo)
##endif()

#target_include_directories(Todo PRIVATE ${RESOURCES_FILES})
#target_include_directories(Todo PRIVATE ${INCLUDE_DIR})
#target_include_directories(Todo PRIVATE ${SOURCE_DIR})
