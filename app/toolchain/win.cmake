# toolchain/win.cmake
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER /usr/bin/x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER /usr/bin/x86_64-w64-mingw32-g++)
set(CMAKE_RC_COMPILER /usr/bin/x86_64-w64-mingw32-windres)

set(QT_ROOT "/opt/qt/windows/5.15.17")
set(CMAKE_PREFIX_PATH "${QT_ROOT}" ${CMAKE_PREFIX_PATH})

set(Qt5_DIR "${QT_ROOT}/lib/cmake/Qt5")
set(Qt5Core_DIR "${QT_ROOT}/lib/cmake/Qt5Core")
set(Qt5Gui_DIR "${QT_ROOT}/lib/cmake/Qt5Gui")
set(Qt5Widgets_DIR "${QT_ROOT}/lib/cmake/Qt5Widgets")

set(CMAKE_FIND_ROOT_PATH 
    /usr/x86_64-w64-mingw32
    "${QT_ROOT}"
    /usr
)