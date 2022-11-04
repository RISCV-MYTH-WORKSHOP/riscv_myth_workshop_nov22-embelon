\m4_TLV_version 1d: tl-x.org
\SV

   // =================================================
   // Welcome!  New to Makerchip? Try the "Learn" menu.
   // =================================================

   // Default Makerchip TL-Verilog Code Template
   
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   
   |calc
      @0
         $reset = *reset;
         $val2[31:0] = $rand2[3:0];
         
      @1
         // counter
         $cnt[0:0] = $reset ? 0 : (>>1$cnt[0:0] + 1);
         
         $valid = $cnt[0] && !reset;
         
      ?$valid
         @1
            // calculator
            $val1[31:0] = >>2$out[31:0];
            
            $sum[31:0] = $val1[31:0] + $val2[31:0];
            $diff[31:0] = $val1[31:0] - $val2[31:0];
            $prod[31:0] = $val1[31:0] * $val2[31:0];
            $quot[31:0] = $val1[31:0] / $val2[31:0];
            
         @2
            $out[31:0] =
               ($op[1:0] == 0) ? $sum[31:0] :
               ($op[1:0] == 1) ? $diff[31:0] :
               ($op[1:0] == 2) ? $prod[31:0] :
               $quot[31:0];
            
            // (!$valid || $reset) ? 32'h00000000 :
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
