vsim ULA
add wave * 

force B "00000010" 0ms;
force C "00000000" 0ms, "00000010" 50ms;
force S_full "101" 0ms;
run 100ms
