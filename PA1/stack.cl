(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)
class Node {
   element : String;
   next : Node;

   init (ele : String, nil : Node) : Node {
      {
         element <- ele;
         next <- nil;
         self;
      }
   };

   getElement() : String {
      element
   };

   getNext() : Node {
      next
   };

   setNext(temp : Node) : Object {
      next <- temp
   };

};

class Stack inherits IO{
   top : Node;

   init(nil : Node) : Stack {
      {
         top <- (new Node).init("head", nil);
         self;
      }
   };

   push (element : String) : Object {
      let temp : Node <- top.getNext(),
          nil : Node,
          pushNode : Node  <- (new Node).init(element, nil)
      in {
         top.setNext(pushNode);
         pushNode.setNext(temp);     
      }
   };

   pop () : Node {
      let res : Node <- top.getNext(),
          nil : Node
      in {
         top.setNext(res.getNext());
         res.setNext(nil);
         res;
      }
   };

   getHeader() : Node {
      top
   };

   peek() : Node {
      top.getNext()
   };

   display() : Object {
      let temp : Node <- top.getNext() in {
         while (not (isvoid temp)) loop {
            out_string(temp.getElement().concat("\n"));
            temp <- temp.getNext();
         }
         pool;
      }
   };


};
class Main inherits IO {

   add(stack : Stack) : Stack {
      let op1 : Int,
          op2 : Int in {
             op1 <- (new A2I).a2i(stack.pop().getElement());
             op2 <- (new A2I).a2i(stack.pop().getElement());
             stack.push((new A2I).i2a(op1 + op2));
             stack;
          }
   };
   swap(stack : Stack) : Stack {
      let header : Node <- stack.getHeader(),
          topNode : Node <- stack.peek(),
          secondNode : Node <- topNode.getNext() 
      in { 
         header.setNext(secondNode);
         topNode.setNext(secondNode.getNext());
         secondNode.setNext(topNode);
         stack;
      }
          
   };

   executeStack(input : String, stack : Stack) : Stack {
      {
         if (input = "e") then {
               if (not (isvoid stack.peek())) then {
                  let topElement : String <- stack.peek().getElement(),
                      temp : Node in {
                     if (topElement = "+") then {
                           temp = stack.pop();
                           stack <- add(stack);
                     } else if (topElement = "s") then {
                           temp = stack.pop();
                           stack <- swap(stack);
                        } else {
                           out_string("");
                        } 
                        fi
                     fi;
                  };
               } else {
                  out_string("");
               }
               fi;
            } else if (input = "d") then {
                  stack.display();
               } else if (input = "x") then {
                     abort();
                  } else {
                     stack.push(input);
                  }
               fi
            fi
         fi;          
         stack;
      }
   }; 
   main() : Object {
      let input : String,
          nil : Node,
          stack : Stack <- (new Stack).init(nil) in {
         while (true) loop
         {
            out_string(">");
            input <- in_string();
            stack <- executeStack(input, stack);
         }
         pool;
      }
   };

};
