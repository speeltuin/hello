#include <cstring>
#include "hello/hello.hpp"

auto main() -> int
{
  return std::strcmp(hello_get_name(), "hello") == 0 ? 0 : 1;
}
