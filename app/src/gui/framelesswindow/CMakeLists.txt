find_package(Qt5 REQUIRED COMPONENTS Widgets)

add_library(framelesswindow 
STATIC
    framelesswindow.cpp
)

target_link_libraries(framelesswindow 
PRIVATE
    Qt5::Widgets
)

target_include_directories(framelesswindow
    PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}
)

add_library(gui::framelesswindow ALIAS framelesswindow)
