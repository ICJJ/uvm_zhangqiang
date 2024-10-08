`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class base_sequence extends uvm_sequence #(my_transaction);
   `uvm_object_utils(base_sequence)
   `uvm_declare_p_sequencer(my_sequencer)
   function  new(string name= "base_sequence");
      super.new(name);
   endfunction
   //define some common function and task 
endclass

class case0_sequence extends base_sequence; 
   `uvm_object_utils(case0_sequence)
   my_transaction m_trans;

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      `ifdef UVM_VERSION_1_2
        starting_phase=get_starting_phase();
     `endif
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (10) begin
         `uvm_do(m_trans)
      end
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask
endclass


class my_case0 extends base_test;

   function new(string name = "my_case0", uvm_component parent = null);
      super.new(name,parent);
   endfunction 
   extern virtual function void build_phase(uvm_phase phase); 
   `uvm_component_utils(my_case0)
endclass


function void my_case0::build_phase(uvm_phase phase);
   super.build_phase(phase);

   uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           case0_sequence::type_id::get());
endfunction

`endif
