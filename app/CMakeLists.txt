cmake_minimum_required(VERSION 3.16)
project(MinimalQtWindow)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(SOURCE_DIR src)

message(STATUS "=== CMake Debug Information ===")
message(STATUS "CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")
message(STATUS "Qt5_DIR: ${Qt5_DIR}")
message(STATUS "CMAKE_PREFIX_PATH: ${CMAKE_PREFIX_PATH}")
message(STATUS "===============================")


find_package(Qt5 REQUIRED COMPONENTS Widgets)


add_subdirectory(${SOURCE_DIR}/gui ${CMAKE_BINARY_DIR}/gui)

add_executable(${PROJECT_NAME}
    src/main.cpp
    src/mainwindow.cpp
    src/mainwindow.ui
)

target_link_libraries(${PROJECT_NAME}
    Qt5::Widgets
    gui::framelesswindow
)

install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)