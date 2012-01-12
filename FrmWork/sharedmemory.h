#ifndef SHAREDMEMORY_H
#define SHAREDMEMORY_H
#include <QtCore>

class SharedMemory
{
public:
    static SharedMemory* get();
private:
    SharedMemory();
};

#endif // SHAREDMEMORY_H
