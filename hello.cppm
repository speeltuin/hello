module;

#include "hello_export.h"
#include <iostream>

export module hello;

export HELLO_EXPORT void hello() noexcept
{
    std::cout << "Hello, world!\n";
}
