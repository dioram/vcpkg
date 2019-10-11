# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/fbow-f897fff260ed5a2c4a8347802749c4d58c48bce6)
vcpkg_download_distfile(ARCHIVE
    URLS "https://github.com/rmsalinas/fbow/archive/f897fff260ed5a2c4a8347802749c4d58c48bce6.zip"
    FILENAME "fbow-1.0.0.zip"
    SHA512 e8c23ed554ddb9c5fca62d4aaa65f55f760b793659c1e39a4a8776daf89a48189693864f93b257e1ab17b50a7a6c1470a1ca42670c588f85383e5bf15e2df02d
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA # Disable this option if project cannot be built with Ninja
    OPTIONS -DBUILD_UTILS=OFF
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
# file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share)
# file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/cmake)
# file(RENAME ${CURRENT_PACKAGES_DIR}/share/cmake ${CURRENT_PACKAGES_DIR}/share/fbow)

configure_file(${CURRENT_PORT_DIR}/copyright.in ${CURRENT_PACKAGES_DIR}/share/fbow/copyright)

# Handle copyright
# file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/fbow RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME fbow)
