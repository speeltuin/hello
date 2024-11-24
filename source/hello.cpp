#include "hello/hello.hpp"

auto hello_get_name() noexcept -> const char*
{
  return "hello";
}
