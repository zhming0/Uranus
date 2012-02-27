#ifndef URANUS_LIST_INC
#define URANUS_LIST_INC

class UList
{
public:
    UList();
    ~UList();
    int count();
    void append(void*);
    void prepend(void*);
    void* front();
    void* back();
    void pop_front();
    void pop_back();
private:
    int _count;
    class Node
    {
    public:
        Node();
        void destroy();
        void* data;
        Node *next,*prev;
    }*head,*tail;
};

#endif
