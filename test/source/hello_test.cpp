#include <string>

#include "hello/hello.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("hello") == exported.name() ? 0 : 1;
}
