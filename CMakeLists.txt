cmake_minimum_required(VERSION 3.28)

project(hello LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS NO)
set(CMAKE_CXX_SCAN_FOR_MODULES ON)

include(GenerateExportHeader)

add_library(hello SHARED)
set_target_properties(hello PROPERTIES
    CXX_VISIBILITY_PRESET default
    VISIBILITY_INLINES_HIDDEN OFF)
generate_export_header(hello)
target_sources(hello
    PUBLIC FILE_SET CXX_MODULES
        FILES hello.cppm
    PUBLIC FILE_SET HEADERS
        FILES ${CMAKE_CURRENT_BINARY_DIR}/hello_export.h)
target_include_directories(hello
    PUBLIC ${CMAKE_CURRENT_BINARY_DIR})

add_executable(hello_test hello_test.cpp)
target_link_libraries(hello_test hello)
