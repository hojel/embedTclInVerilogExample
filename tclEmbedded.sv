`timescale 1 ns/1 ns
module top;
      import "DPI-C" context task startTcl();
      export "DPI-C" task sv_write;
   
   // Exported SV task.  Can be called by C,SV or Tcl using c_write
   task sv_write(input int data,address);
      begin
	 $display("%t sv_write(data = %d, address = %d)",$time,data,address);
          #100ns;
      end
   endtask
   
   initial 
     begin
	startTcl();
	$display("DONE!!");
     end

endmodule
