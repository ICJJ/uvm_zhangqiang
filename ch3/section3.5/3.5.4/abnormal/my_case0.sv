`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);
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
      #100;
      if(starting_phase != null) 
         starting_phase.drop_objection(this);
   endtask

   `uvm_object_utils(case0_sequence)
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
   uvm_config_db#(int)::set(uvm_root::get(), 
                            "uvm_test_top.env.i_agt.drv", 
                            "pre_num", 
                            999);
   `uvm_info("my_case0", "in my_case0, env.i_agt.drv.pre_num is set to 999", UVM_LOW)
endfunction

`endif
