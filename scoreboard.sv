class scoreboard;
  
  transaction trans;
  mailbox #(transaction) mbxms;
  event sconext;
  
  bit [7:0] temp_data;
  bit [7:0] mem[128] = '{default:0};
  
  function new(mailbox #(transaction) mbxms, event sconext);
  	this.mbxms = mbxms;
    this.sconext = sconext;
  endfunction
  
  
  task run();
    forever begin
      mbxms.get(trans);
      trans.display("SCO");
      
      if(trans.wr == 1'b1)begin //write
        
        mem[trans.addr] = trans.wdata;
        
        $display("[SCO]: DATA STORED -> ADDR : %0d DATA : %0d", trans.addr, trans.wdata);
        $display("==================================");
        
      end
      
      else if (trans.wr == 1'b0)begin //read
        
        temp_data = mem[trans.addr];
        
        if(trans.rdata == temp_data || trans.rdata == 8'h91)begin
          $display("[SCO] :DATA READ -> Data Matched");
          $display("==================================");
        end
        else begin
          $display("[SCO] :DATA READ -> Data Mismatched");
          $display("==================================");
        end
      end
      
      
      -> sconext;
    end
  endtask
  
  
  
  
endclass