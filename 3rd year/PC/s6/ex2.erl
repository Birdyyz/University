-module(myqueue).
-export(create/0, enqueue/2, dequeue/1).


create() -> 
enqueue(PriQueue, Item, Priority) -> 
dequeue(PriQueue) -> 