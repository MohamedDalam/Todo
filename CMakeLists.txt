cmake_minimum_required(VERSION 3.14)

project(Todo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/$<CONFIG>")

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 COMPONENTS Core Quick Qml Gui QuickControls2 REQUIRED)

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
	ui/qml/qml.qrc
)

add_executable(Todo)

target_sources(Todo
	PRIVATE
		${HEADER_FILES}
		${SOURCE_FILES}
		${RESOURCES_FILES}
)

target_link_libraries(Todo
	PRIVATE
		Qt6::Core
		Qt6::Gui
		Qt6::Qml
		Qt6::Quick
		Qt6::QuickControls2
)

target_include_directories(Todo PRIVATE include)
