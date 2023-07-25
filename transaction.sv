class transaction;
  
  bit newd;
  rand bit wr;
  rand bit [7:0] wdata;
  rand bit [6:0] addr;
  bit [7:0] rdata;
  bit done;

  constraint addr_c {addr inside {[1:10]};}
  
  constraint wr_rd_c {wr dist {1 :/ 50, 0 :/ 50};}

  function void display(string tag);
    $display("[%0s] newd = %0b  wr = %0b  wdata = %0d  addr = %0d  rdata = %0d",tag,newd,wr,wdata,addr,rdata); 
    
  endfunction

  function transaction copy();
    copy = new();
    copy.newd  = this.newd;
    copy.wr    = this.wr;
    copy.wdata = this.wdata;
    copy.addr  = this.addr;
    copy.rdata = this.rdata;
    copy.done  = this.done;
  endfunction

endclass