# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/poly_collection
    REF boost-1.73.0
    SHA512 6d04153c03634748ebe35509359c882a766dc8ed5a880cd927bfc3488d3364229140e87da6ada157fd7d4ade86a9d1f5d503a098eb2aa3773949722dea6f3ad6
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
