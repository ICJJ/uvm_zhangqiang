`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class sequence0 extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "sequence0");
      super.new(name);
   endfunction 
   
   virtual task body();
      `ifdef UVM_VERSION_1_2
        starting_phase=get_starting_phase();
     `endif
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (5) begin
         `uvm_do_pri(m_trans, 100)
         `uvm_info("sequence0", "send one transaction", UVM_MEDIUM)
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(sequence0)
endclass

class sequence1 extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "sequence1");
      super.new(name);
   endfunction 
   
   virtual task body();
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (5) begin
         `uvm_do_pri_with(m_trans, 200, {m_trans.pload.size < 500;})
         `uvm_info("sequence1", "send one transaction", UVM_MEDIUM)
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(sequence1)
endclass


class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   `uvm_component_utils(my_case0)
   extern virtual task main_phase(uvm_phase phase);
endclass

task my_case0::main_phase(uvm_phase phase);
   sequence0 seq0;
   sequence1 seq1;

   seq0 = new("seq0");
   seq0.starting_phase = phase;
   seq1 = new("seq1");
   seq1.starting_phase = phase;
   env.i_agt.sqr.set_arbitration(UVM_SEQ_ARB_STRICT_FIFO);
   fork
      seq0.start(env.i_agt.sqr);
      seq1.start(env.i_agt.sqr);
   join
endtask

`endif
