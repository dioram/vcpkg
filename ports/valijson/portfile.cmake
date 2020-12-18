#header-only library
include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO tristanpenman/valijson
    REF dd084d747448bb56ddfeab5946b4f2f4617b99c4
    SHA512 ee241eefc816360608f86792a4c25abadea79cbffc94d7e31a2dbd0a483ed4d7a303b6d2410b99ab7694e58a3d299f0df0baa52fa16f89e9233d90b190a4d799
    HEAD_REF master
    PATCHES fix-nlohmann-json.patch
            fix-picojson.patch
            fix-optional.patch
            fix-installation.patch
)

# Copy the header files
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -Dvalijson_BUILD_EXAMPLES=OFF
        -Dvalijson_BUILD_TESTS=OFF
)

vcpkg_install_cmake()

# Remove excess files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug)

# Put the licence file where vcpkg expects it
file(COPY ${SOURCE_PATH}/LICENSE
     DESTINATION ${CURRENT_PACKAGES_DIR}/share/valijson)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/valijson/LICENSE ${CURRENT_PACKAGES_DIR}/share/valijson/copyright)
