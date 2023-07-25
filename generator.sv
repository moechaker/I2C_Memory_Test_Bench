class generator;
  
  transaction trans;
  mailbox #(transaction) mbxgd;
  event done;
  event drvnext,sconext;
  int count;
  
  function new(mailbox #(transaction) mbxgd, event done, event drvnext, event sconext, int count);
    
    this.mbxgd = mbxgd;
    this.done = done;
    this.drvnext = drvnext;
    this.sconext = sconext;
    this.count = count;
	
    trans = new();
  endfunction
    
    task run();
      repeat(count) begin
        assert(trans.randomize()) else $error("Randomization Failed");
        mbxgd.put(trans.copy);
        trans.display("GEN");
        wait(drvnext.triggered);
        wait(sconext.triggered);
      end
      -> done;
      
    endtask
endclass