if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/hello-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package hello)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT hello_Development
)

install(
    TARGETS hello_hello
    EXPORT helloTargets
    RUNTIME #
    COMPONENT hello_Runtime
    LIBRARY #
    COMPONENT hello_Runtime
    NAMELINK_COMPONENT hello_Development
    ARCHIVE #
    COMPONENT hello_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    hello_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE hello_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(hello_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${hello_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT hello_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${hello_INSTALL_CMAKEDIR}"
    COMPONENT hello_Development
)

install(
    EXPORT helloTargets
    NAMESPACE hello::
    DESTINATION "${hello_INSTALL_CMAKEDIR}"
    COMPONENT hello_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
