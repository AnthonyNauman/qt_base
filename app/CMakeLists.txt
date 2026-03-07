cmake_minimum_required(VERSION 3.16)
project(AppName)

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

set(SOURCES
    src/main.cpp
    src/mainwindow.cpp
)

set(HEADERS
    src/mainwindow.h
)

set(FORMS
    src/mainwindow.ui
)

set(RESOURCES
    res/resources.qrc
)

if(WIN32)
    file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/app.rc
        "IDI_ICON1 ICON DISCARDABLE \"${CMAKE_CURRENT_SOURCE_DIR}/res/icons/application.ico\"\n"
    )
    set(WINDOWS_RESOURCES ${CMAKE_CURRENT_BINARY_DIR}/app.rc)
endif()

add_executable(${PROJECT_NAME}
    ${SOURCES}
    ${HEADERS}
    ${FORMS}
    ${RESOURCES}
    ${WINDOWS_RESOURCES}
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