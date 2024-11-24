# find_package(<Package>) call for consumers to find this project
set(Package ${PROJECT_NAME})
string(TOLOWER ${Package} package)
string(TOUPPER ${Package} PACKAGE)

if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/${Package}-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

install(
    TARGETS ${Package}_${Package}
    EXPORT ${Package}Targets
    RUNTIME #
    COMPONENT ${Package}_Runtime
    LIBRARY #
    COMPONENT ${Package}_Runtime
    NAMELINK_COMPONENT ${Package}_Development
    ARCHIVE #
    COMPONENT ${Package}_Development
    FILE_SET HEADERS
    COMPONENT ${Package}_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

# Allow package maintainers to freely override the path for the configs
set(
    ${PACKAGE}_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${Package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE ${PACKAGE}_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(${PACKAGE}_INSTALL_CMAKEDIR)

configure_package_config_file(
    cmake/install-config.cmake.in
    "${PROJECT_BINARY_DIR}/${package}-config.cmake"
    INSTALL_DESTINATION "${${PACKAGE}_INSTALL_CMAKEDIR}"
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

write_basic_package_version_file(
    "${package}-config-version.cmake"
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
        "${PROJECT_BINARY_DIR}/${package}-config.cmake"
        "${PROJECT_BINARY_DIR}/${package}-config-version.cmake"
    DESTINATION "${${PACKAGE}_INSTALL_CMAKEDIR}"
    COMPONENT ${Package}_Development
)

install(
    EXPORT ${Package}Targets
    NAMESPACE ${Package}::
    DESTINATION "${${PACKAGE}_INSTALL_CMAKEDIR}"
    FILE ${package}-targets.cmake
    COMPONENT ${Package}_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
