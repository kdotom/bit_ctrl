# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")
    
    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())
    
    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)
    
    dut._log.info("Test project behavior")
    
    # Set the input values, wait one clock cycle, and check the output
    #dut._log.info("Test")
    
    test_value = [144, 24, 72, 96, 36, 132, 0, 0]
    for i in range(20):
        await ClockCycles(dut.clk, 1)
        #assert 20 == test_value[(i)%6]
        assert dut.uo_out.value == test_value[(i)%6]
