yosys -import

foreach src $::env(SOURCES) {
    read_verilog $src
}

synth_nexus -nolutram -nowidelut -noccu2 -nodsp

if { $::env(TECHMAP) != "" } {
    techmap -map $::env(TECHMAP)
}

# opt_expr -undriven makes sure all nets are driven, if only by the $undef
# net.
opt_expr -undriven
opt_clean

setundef -zero -params

write_json $::env(OUT_JSON)
write_verilog $::env(OUT_VERILOG)
