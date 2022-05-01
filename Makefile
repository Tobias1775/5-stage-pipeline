test : CPU.v test_CPU.v
	iverilog -o test_CPU.vvp test_CPU.v
	vvp test_CPU.vvp