include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO jkuhlmann/gainput
    REF v1.0.0
    SHA512 56fdc4c0613d7260861885b270ebe9e624e940175f41e3ac82516e2eb0d6d229e405fbcc2e54608e7d6751c1d8658b5b5e186153193badc6487274cb284a8cd6
    HEAD_REF master
    PATCHES
        "cmakelists_installation_fix.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DGAINPUT_TESTS=OFF
        -DGAINPUT_SAMPLES=OFF
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/gainput")
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
