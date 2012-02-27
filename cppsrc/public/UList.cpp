#include "UList.h"

UList::Node::Node()
{
    data=0;
    next=0;
    prev=0;
}

void UList::Node::destroy()
{
    if(next!=0)
    {
        next->destroy();
        delete next;
    }
}

UList::UList()
{
    head=tail=0;
    _count=0;
}

UList::~UList()
{
    if(head!=0)
    {
        head->destroy();
        delete head;
    }
}

int UList::count()
{
    return _count;
}

void UList::append(void* data)
{
    Node* ins=new Node;
    ins->data=data;
    _count++;
    if(tail==0)
    {
        head=tail=ins;
    }else
    {
        ins->prev=tail;
        tail->next=ins;
        tail=ins;
    }
}

void UList::prepend(void* data)
{
    Node* ins=new Node;
    ins->data=data;
    _count++;
    if(head==0)
    {
        head=tail=ins;
    }else
    {
        head->prev=ins;
        ins->next=head;
        head=ins;
    }
}

void* UList::front()
{
    if(head==0)
        return 0;
    return head->data;
}

void* UList::back()
{
    if(tail==0)
        return 0;
    return tail->data;
}

void UList::pop_front()
{
    if(head!=0)
    {
        _count--;
        Node* tmp=head->next;
        delete head;
        head=tmp;
        if(head==0)
        {
            tail=0;
        }
    }
}

void UList::pop_back()
{
    if(tail!=0)
    {
        _count--;
        Node* tmp=tail->prev;
        delete tail;
        tail=tmp;
        if(tail==0)
        {
            head=0;
        }
    }
}
