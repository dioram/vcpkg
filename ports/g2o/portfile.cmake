vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO RainerKuemmerle/g2o
    REF 1b89597b4e495bef5447c5b8001f5f93ccf32ec4
    SHA512 bafd32746a17e6fab6581c04ce5c74b2a52a0764276a36a30b890ba4537ca98dd9ec0716d1009471a029085231eb849c5fe9aacbd9e82a6a4bd594b072de2031
    HEAD_REF master
    PATCHES 
	find_package_fix.patch
	eigen_solver_fix.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_LGPL_SHARED_LIBS)


if (VCPKG_TRIPLET_TARGET STREQUAL "jetsontx2")
set(ADDITIONAL_OPTIONS
    -DDO_SSE_AUTODETECT:BOOL=OFF
    -DDISABLE_SSE2:BOOL=ON
    -DDISABLE_SSE3:BOOL=ON
    -DDISABLE_SSE4_1:BOOL=ON
    -DDISABLE_SSE4_2:BOOL=ON
    -DDISABLE_SSE4_A:BOOL=ON
    )
else()
set(ADDITIONAL_OPTIONS "")
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    #PREFER_NINJA
    OPTIONS
        -DBUILD_LGPL_SHARED_LIBS=${BUILD_LGPL_SHARED_LIBS}
        -DG2O_BUILD_EXAMPLES=OFF
        -DG2O_BUILD_APPS=OFF
        -DG2O_USE_CHOLMOD=ON
        ${ADDITIONAL_OPTIONS}
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/g2o)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    file(GLOB_RECURSE HEADERS "${CURRENT_PACKAGES_DIR}/include/*")
    foreach(HEADER ${HEADERS})
        file(READ ${HEADER} HEADER_CONTENTS)
        string(REPLACE "#ifdef G2O_SHARED_LIBS" "#if 1" HEADER_CONTENTS "${HEADER_CONTENTS}")
        file(WRITE ${HEADER} "${HEADER_CONTENTS}")
    endforeach()
endif()

file(GLOB EXE ${CURRENT_PACKAGES_DIR}/bin/*.exe)
file(GLOB DEBUG_EXE ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
if(EXE OR DEBUG_EXE)
    file(REMOVE ${EXE} ${DEBUG_EXE})
endif()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/doc/license-bsd.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
