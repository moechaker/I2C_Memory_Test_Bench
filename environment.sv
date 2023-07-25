class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard sco;
  
  
  mailbox #(transaction) mbxgd;
  mailbox #(transaction) mbxms;
  event done;
  event drvnext;
  event sconext;
  
  
  function new(virtual i2c_if vif, int count);
    mbxgd = new();
    mbxms = new();
    gen = new(mbxgd,done,drvnext,sconext,count);
    drv = new(vif,mbxgd,drvnext);
    mon = new(vif,mbxms);
    sco = new(mbxms,sconext);
  endfunction
  
  task pre_test();
    drv.reset();
  endtask
  
  task test();
    fork
     gen.run();
     drv.run();
     mon.run();
     sco.run();
    join_any
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    $finish;
  endtask
  
  
  task run();
    pre_test();
    test();
    post_test();
  endtask
	  
endclass