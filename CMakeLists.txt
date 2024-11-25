cmake_minimum_required(VERSION 3.30)

project(
    hello
    VERSION 0.1.0
    DESCRIPTION "Hello, world!"
    LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS NO)
set(CMAKE_CXX_SCAN_FOR_MODULES ON)

include(GenerateExportHeader)
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
if(PROJECT_IS_TOP_LEVEL)
    include(CTest)
endif()

add_library(hello SHARED)
add_library(hello::hello ALIAS hello)

set_target_properties(
    hello PROPERTIES
    VERSION ${hello_VERSION}
    SOVERSION ${hello_VERSION_MAJOR}
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN ON
)

generate_export_header(
    hello
    EXPORT_FILE_NAME export/hello/hello_export.h
)

target_sources(
    hello
    PUBLIC FILE_SET CXX_MODULES
        FILES hello.cppm
    PUBLIC FILE_SET HEADERS
        BASE_DIRS ${CMAKE_CURRENT_BINARY_DIR}/export
        FILES ${CMAKE_CURRENT_BINARY_DIR}/export/hello/hello_export.h
)

target_include_directories(
    hello
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/export>
    PUBLIC $<INSTALL_INTERFACE:include>
)

add_executable(hello_test hello_test.cpp)
target_link_libraries(hello_test hello::hello)
add_test(NAME hello_test COMMAND hello_test)

install(
    TARGETS hello
    EXPORT hello-targets
    FILE_SET HEADERS
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    FILE_SET CXX_MODULES
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/hello/src
)

install(
    EXPORT hello-targets
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/hello
    NAMESPACE hello::
    CXX_MODULES_DIRECTORY .
)

configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/config.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/hello-config.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/hello
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/hello-config-version.cmake
    COMPATIBILITY SameMajorVersion
)

install(
    FILES
        ${CMAKE_CURRENT_BINARY_DIR}/hello-config.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/hello-config-version.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/hello
)

if(PROJECT_IS_TOP_LEVEL)
    include(InstallRequiredSystemLibraries)
    set(CPACK_PACKAGE_VERSION_MAJOR "${hello_VERSION_MAJOR}")
    set(CPACK_PACKAGE_VERSION_MINOR "${hello_VERSION_MINOR}")
    set(CPACK_PACKAGE_VERSION_PATCH "${hello_VERSION_PATCH}")
    include(CPack)
endif()
