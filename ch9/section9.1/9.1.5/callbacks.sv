`ifndef CALLBACKS__SV
`define CALLBACKS__SV

class A extends uvm_callback;
   virtual task pre_tran(my_driver drv, ref my_transaction tr);
   endtask

   function  new(string name= "A");
      super.new(name);
   endfunction
   
endclass


`endif
