include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/gainput-1.0.0)

vcpkg_download_distfile(ARCHIVE
    URLS "http://github.com/jkuhlmann/gainput/archive/v1.0.0.zip"
    FILENAME "gainput-1.0.0.zip"
    SHA512 dab221290560298693f54bebced1da5ec3dfae2d2adbfd6ceb17b5b28dc2a637a49e479d49fe98680915b29beb5dd2d5c74258598233a053230696186593c88e
)
vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH    
    ARCHIVE ${ARCHIVE}
    PATCHES
	"cmakelists_installation_fix.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA 
    OPTIONS
        -DGAINPUT_TESTS=OFF
        -DGAINPUT_SAMPLES=OFF
    # Disable this option if project cannot be built with Ninja
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/gainput")
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
