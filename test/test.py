# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
  dut._log.info("Start")
  
  # Our example module doesn't use clock and reset, but we show how to use them here anyway.
  clock = Clock(dut.clk, 10, units="us")
  cocotb.start_soon(clock.start())

  # Reset
  dut._log.info("Reset")
  dut.reset.value = 1
  #dut.out.value = 0
  await ClockCycles(dut.clk, 10)
  dut.reset.value = 0

  # Set the input values, wait one clock cycle, and check the output
  dut._log.info("Test")

  test_value = [144, 24, 72, 96, 36, 132, 0, 0]
  for i in range(10):
    await ClockCycles(dut.clk, 1)
    assert dut.out.value == test_value[i%6]
