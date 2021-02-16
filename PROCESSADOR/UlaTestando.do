vsim comparador8bit
add wave * 

force X_CMP "00000010" 0ms, "11000011" 100ms;
force Y_CMP "00000000" 0ms, "00000010" 50ms;
run 200ms
