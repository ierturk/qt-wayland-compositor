cmake_minimum_required(VERSION 3.16)
project(qwc LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

find_package(Qt5 COMPONENTS Core)
find_package(Qt5 COMPONENTS Gui)
find_package(Qt5 COMPONENTS Qml)

add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME} PRIVATE
    Source/main.cpp
    Source/main.qrc
)

target_link_libraries(${PROJECT_NAME} PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
)
