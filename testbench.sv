`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module tb;
  
  environment env;
  const int count = 20;
  
  i2c_if vif();
  
  i2c_top dut(vif.clk, vif.rst,  vif.newd, vif.wr, vif.wdata, vif.addr, vif.rdata, vif.done);
  
  initial begin
    vif.clk <= 0;
  end

  always #5 vif.clk <= ~vif.clk;
  
  initial begin
    env = new(vif,count);
    env.run();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
  assign vif.sclk_ref = dut.e1.sclk_ref; 
  
endmodule