# toolchain/linux.cmake
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(CMAKE_C_COMPILER /usr/bin/gcc)
set(CMAKE_CXX_COMPILER /usr/bin/g++)

set(QT_ROOT "/opt/qt/linux/5.15.17")
set(CMAKE_PREFIX_PATH "${QT_ROOT}" ${CMAKE_PREFIX_PATH})
set(Qt5_DIR "${QT_ROOT}/lib/cmake/Qt5")

set(CMAKE_FIND_ROOT_PATH 
    "${QT_ROOT}"
    /usr
    /usr/local
)