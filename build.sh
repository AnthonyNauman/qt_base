#!/bin/bash

PLATFORM=linux
CLEAN=0

IN_DEVCONTAINER=0
if [ -f "/.dockerenv" ] || [ -f "/run/.containerenv" ] || [ -n "$REMOTE_CONTAINERS" ] || [ -n "$DEVCONTAINER" ]; then
    IN_DEVCONTAINER=1
    echo "Running inside devcontainer"
fi

while getopts "cp:" opt; do
  case $opt in
    c) CLEAN=1
    ;;
    p) PLATFORM="$OPTARG"
       echo ${PLATFORM} 
       if [[ $PLATFORM != "win" && $PLATFORM != "linux" ]]; then
            echo "Unsupported platform" 
            exit 1
       fi
       echo "Using Platform=${PLATFORM}"
    ;;
    ?) echo "
Available options:
  -c                  - clean build folder.
  -p                  - using platfom (linux/win)
  "
       exit 1
    ;;
  esac
done

if [ $IN_DEVCONTAINER -eq 0 ]; then
    echo "Running outside devcontainer - building Docker images..."
    
    export COMPOSE_BAKE=true
    
    if [[ "$(docker images -q qt-base:5.15.17-${PLATFORM} 2> /dev/null)" == "" ]]; then
        echo "Building qt-base image..."
        docker build -t qt-base:5.15.17-${PLATFORM} -f qt_base/Dockerfile .
    else
        echo "qt-base image already exists, skipping build..."
    fi
    
    echo "Building qt-app image..."
    docker build \
      --build-arg PLATFORM=${PLATFORM} \
      --cache-from qt-base:5.15.17-${PLATFORM} \
      -t qt-app:${PLATFORM} \
      ./app
    
    echo "Running build in container..."
    docker run -it --rm \
        --user 1000:1000 \
        -v $(pwd)/app/:/app \
        qt-app:${PLATFORM} \
        /bin/bash -c "
        if [[ ${CLEAN} == 1 ]]; then 
            rm -rf /app/build /app/install /app/artifacts
        fi
        mkdir -p /app/build /app/install /app/artifacts && cd /app/build &&
        cmake -S /app -B ${PLATFORM} -DCMAKE_INSTALL_PREFIX=/app/install/${PLATFORM} \
              -DCMAKE_TOOLCHAIN_FILE=/app/toolchain/${PLATFORM}.cmake \
              ..
        cmake --build ${PLATFORM} --target install -j\$(nproc)"
else
    echo "Running inside devcontainer - executing build directly..."
    
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    APP_DIR="${SCRIPT_DIR}/app"
    
    if [[ ${CLEAN} == 1 ]]; then 
        echo "Cleaning build directories..."
        rm -rf ${APP_DIR}/build ${APP_DIR}/install ${APP_DIR}/artifacts
    fi
    
    mkdir -p ${APP_DIR}/build ${APP_DIR}/install ${APP_DIR}/artifacts
    
    cd ${APP_DIR}/build
    
    echo "Configuring CMake for ${PLATFORM}..."
    cmake -S ${APP_DIR} -B ${PLATFORM} \
          -DCMAKE_INSTALL_PREFIX=${APP_DIR}/install/${PLATFORM} \
          -DCMAKE_TOOLCHAIN_FILE=${APP_DIR}/toolchain/${PLATFORM}.cmake \
          ..
    
    echo "Building for ${PLATFORM}..."
    cmake --build ${PLATFORM} --target install -j$(nproc)
    
    echo "Build completed!"
fi