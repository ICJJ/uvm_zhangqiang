`ifndef MY_CASE0__SV
`define MY_CASE0__SV
class case0_sequence extends uvm_sequence #(my_transaction);
   my_transaction m_trans;
   int num;

   function  new(string name= "case0_sequence");
      super.new(name);
   endfunction 

   virtual task pre_do(bit is_item);
      #100;
      `uvm_info("sequence0", "this is pre_do", UVM_MEDIUM)
   endtask

   virtual function void mid_do(uvm_sequence_item this_item);
      my_transaction tr;
      int p_sz;
      `uvm_info("sequence0", "this is mid_do", UVM_MEDIUM)
      void'($cast(tr, this_item));
      p_sz = tr.pload.size();
      {tr.pload[p_sz - 4],
       tr.pload[p_sz - 3],
       tr.pload[p_sz - 2],
       tr.pload[p_sz - 1]} = num;
      tr.crc = tr.calc_crc();
      tr.print();
   endfunction

   virtual function void post_do(uvm_sequence_item this_item);
      `uvm_info("sequence0", "this is post_do", UVM_MEDIUM)
   endfunction

   virtual task body();
      `ifdef UVM_VERSION_1_2
        starting_phase=get_starting_phase();
     `endif
      if(starting_phase != null) 
         starting_phase.raise_objection(this);
      repeat (10) begin
         num++;
         `uvm_do(m_trans)
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
