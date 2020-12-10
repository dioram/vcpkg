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
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH    
    ARCHIVE ${ARCHIVE}
    PATCHES 
        "added_use_intrin_option.patch"
	    "cmakelists_installation_fix.patch"
        "cmakelists_installation_fix2.patch"
)

set(CMAKE_SYSTEM_PROCESSOR ${VCPKG_TARGET_ARCHITECTURE})

if (${TARGET_TRIPLET} STREQUAL "arm64-jetsontx2")
    set(USE_AVX "-DUSE_AVX=OFF")
    set(USE_SSE3 "-DUSE_SSE3=OFF")
    set(USE_INTRIN "-DUSE_INTRIN=OFF")
else()
    set(USE_AVX "-DUSE_AVX=ON")
    set(USE_SSE3 "-DUSE_SSE3=ON")
    set(USE_INTRIN "-DUSE_INTRIN=ON")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS -DBUILD_UTILS=OFF ${USE_AVX} ${USE_SSE3} ${USE_INTRIN}
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/fbow")

configure_file(${CURRENT_PORT_DIR}/copyright.in ${CURRENT_PACKAGES_DIR}/share/fbow/copyright)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
