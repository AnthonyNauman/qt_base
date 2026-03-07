cmake_minimum_required(VERSION 3.16)
project(gui VERSION 1.0.0 LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

add_subdirectory(framelesswindow)

add_library(gui INTERFACE)
target_link_libraries(gui INTERFACE
    gui::framelesswindow
)

add_library(gui::gui ALIAS gui)