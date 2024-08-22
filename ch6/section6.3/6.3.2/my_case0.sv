`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 
   
   virtual task body();
      int num = 0;
      int p_sz;
      `ifdef UVM_VERSION_1_2
        starting_phase=get_starting_phase();
     `endif
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (10) begin
         num++;
         `uvm_create(m_trans)
         assert(m_trans.randomize());
         p_sz = m_trans.pload.size();
         {m_trans.pload[p_sz - 4], 
          m_trans.pload[p_sz - 3], 
          m_trans.pload[p_sz - 2], 
          m_trans.pload[p_sz - 1]} 
          = num; 
         `uvm_send(m_trans)
      end
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
endfunction

`endif
