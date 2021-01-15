# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/dll
    REF boost-1.75.0
    SHA512 ae9490fb8fdcad0f350d2e3fa99eae4c72d890503b64f7bf1a2a2fad18babe27c18ddfc5fb0075a3d101ddbc6791df5bb0eaf295d6cc59ea9dcec11ab9fde11b
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
