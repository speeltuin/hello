cmake_minimum_required(VERSION 3.14)

project(helloTests LANGUAGES CXX)

include(../cmake/project-is-top-level.cmake)
include(../cmake/folders.cmake)

# ---- Dependencies ----

if(PROJECT_IS_TOP_LEVEL)
  find_package(hello REQUIRED)
  enable_testing()
endif()

# ---- Tests ----

add_executable(hello_test source/hello_test.cpp)
target_link_libraries(hello_test PRIVATE hello::hello)
target_compile_features(hello_test PRIVATE cxx_std_20)

add_test(NAME hello_test COMMAND hello_test)

# ---- End-of-file commands ----

add_folders(Test)
