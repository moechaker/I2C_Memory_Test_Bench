class driver;
  virtual i2c_if vif;
  transaction trans;
  mailbox #(transaction) mbxgd;
  event drvnext;
  
  function new(virtual i2c_if vif, mailbox #(transaction) mbxgd, event drvnext);
    this.vif = vif;
    this.mbxgd = mbxgd;
    this.drvnext = drvnext;
  endfunction
  
  task reset();
    vif.rst <= 1'b1;
    vif.newd <=1'b0;
    vif.wdata <= 0;
    vif.addr <= 0;
    repeat(10) @(posedge vif.clk);
    vif.rst <= 1'b0;
    repeat(5) @(posedge vif.clk);
    $display("[DRV] RESET DONE");
  endtask
  
  task run();
    forever begin
      mbxgd.get(trans);
      @(posedge vif.sclk_ref);
      vif.newd <=1'b1;
      vif.wr <= trans.wr;
      vif.wdata <= trans.wdata;
      vif.addr <= trans.addr;
      @(posedge vif.sclk_ref);
      vif.newd <= 1'b0;
      
      wait(vif.done == 1'b1);
      @(posedge vif.sclk_ref);
      wait(vif.done == 1'b0);
	  
      $display("[DRV] wr = %0b  wdata = %0d  addr = %0d",vif.wr,vif.wdata,vif.addr);
      
      -> drvnext;
      
    end
    
    
  endtask
  
  
  
endclass