vsim mde
add wave * 

force ck 0 0ms, 1 50ms -repeat 100ms

force opLDR 0 0ms, 1 249ms, 0 256ms
force opSTR 0 0ms, 1 549ms, 0 555ms
force opMOV 0 0ms, 1 849ms, 0 855ms
force opADD 0 0ms, 1 1149ms, 0 1155ms

force opSUB 0 0ms, 1 1749ms, 0 1755ms
force opAND 0 0ms, 1 2049ms, 0 2055ms
force opOR 0 0ms, 1 2349ms, 0 2355ms
force opNOT 0 0ms, 1 2649ms, 0 2655ms
force opXOR 0 0ms, 1 2949ms, 0 2955ms
force opCMP 0 0ms, 1 3249ms, 0 3255ms
force opJMP 0 0ms, 1 3849ms, 0 3855ms
force opJNC 0 0ms, 1 4149ms, 0 4155ms
force opJC 0 0ms, 1 4749ms, 0 4755ms, 1 5049ms, 0 5055ms
force flagCarry 0 0ms, 1 5149ms, 0 5155ms
force flagULA 0 0ms, 1 5649ms, 0 5655ms
force opJNZ 0 0ms, 1 5549ms, 0 5555ms
force opJZ 0 0ms, 1 6049ms, 0 6055ms
force opHLT 0 0ms, 1 6549ms, 0 6555ms
run 8000ms