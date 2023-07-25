# I2C_Memory_Test_Bench

This repository contains a SystemVerilog test bench and related files to verify the functionality of an I2C memory device. The test bench utilizes constraint randomization to generate a comprehensive set of test scenarios, focusing on address, write/read, and data in a transaction to validate the I2C memory's behavior under various conditions. newd is kept high and not randomized.


## Introduction

The I2C Memory Verification Test Bench project aims to ensure the proper operation and data integrity of an I2C memory device. The test bench generates random sequences of I2C transactions with varying addresses, write/read, and data covering a wide range of test scenarios. This approach effectively detects potential issues, such as data corruption, bus contention, and address decoding errors.

## Important Notes
- PLEASE NOTE THAT I HAVE NOT WRITTEN THE DESIGN, I HAVE ONLY VERIFIED IT
- design.sv IS NOT WRITTEN BY ME
- EVERYTHING ELSE IS DONE BY ME
- sorry for shouting that out lol, I just wanted it to be seen


## Usage

To run the DAC-SPI verification test bench, perform the following steps:

1. Visit this link https://www.edaplayground.com/x/h3E5
2. Top right, hit login and create an account
3. Eda Playground might open a new playground for you, so go ahead and click on my link again to open my playground
4. On the left, click on "Open EPWave after run" under Tools & Simulators if you wish to analyze the waveforms
5. hit Run
   

During the simulation, the test bench will drive I2C transactions and interact with the memory device. The design's responses will be monitored and compared against the expected behavior, identifying any potential discrepancies or errors.




