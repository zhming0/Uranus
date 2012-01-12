#include "sharedmemory.h"
#include <time.h>

SharedMemory::SharedMemory()
{
}

SharedMemory* SharedMemory::get()
{
    static SharedMemory inst;
    return& inst;
}
