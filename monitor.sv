class monitor;
  virtual i2c_if vif;
  transaction trans;
  mailbox #(transaction) mbxms;
  
  function new(virtual i2c_if vif, mailbox #(transaction) mbxms);
    this.vif = vif;
    this.mbxms = mbxms;
  endfunction
  
  task run();
    trans = new();
    
    forever begin
      @(posedge vif.sclk_ref);
      
      if(vif.newd == 1'b1) begin
        
        if (vif.wr == 1'b1) begin // write
          
          
          @(posedge vif.sclk_ref);
          wait(vif.done == 1'b1); //wait for done to be high to sample the data
          
          trans.wr = vif.wr;
          trans.wdata = vif.wdata;
          trans.addr = vif.addr;
          
          repeat(2) @(posedge vif.sclk_ref);
          
          $display("[MON] : DATA WRITTEN -> waddr : %0d wdata : %0d", trans.addr, trans.wdata);
          
        end
        
        else if(vif.wr == 1'b0) begin //read
          
          
          
          @(posedge vif.sclk_ref);
          wait(vif.done == 1'b1);//wait for done to be high to sample the data
          
          trans.wr = vif.wr;
          trans.rdata = vif.rdata;
          trans.addr = vif.addr;
          
          repeat(2) @(posedge vif.sclk_ref);
          
          $display("[MON] : DATA READ -> waddr : %0d rdata : %0d", trans.addr, trans.rdata);
        end
        
        mbxms.put(trans);
        
      end
      
    end
    
    
  endtask
 
endclass