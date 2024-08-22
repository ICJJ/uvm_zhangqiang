`ifndef CALLBACKS__SV
`define CALLBACKS__SV

class A extends uvm_callback;
   virtual task pre_tran(my_driver drv, ref my_transaction tr);
   endtask

   function  new(string name= "my_callback");
      super.new(name);
   endfunction 

endclass

//typedef uvm_callbacks#(my_driver, A) A_pool;


`endif
