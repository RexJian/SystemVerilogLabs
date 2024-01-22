# SystemVerilog Labs
Construct a typical architecture of a SystemVerilog testbench

## Table of Content
- [Lab1](#lab1)
- [Lab2](#lab2)

## [Lab1](https://github.com/RexJian/SystemVerilogLabs/tree/main/Lab1)
#### Goal : Define a task called reset() to reset the DUT per spec
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab1/ArchitectureLab1.png" width="400" height="360" alt="Lab1 Architecture">
  <br> <strong>Fig1.  Lab1 Architecture</strong>
</p> 

#### Predict Waveform and Simulate Waveform :  
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab1/Lab1Waveform.png" alt="Lab1 simulate waveform">
  <br> <strong>Fig2.  Lab1 simulate waveform</strong>
</p>

<br><br>

<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab1/Lab1PredictWaveform.png" alt="Lab1 predict waveform">
  <br> <strong>Fig3.  Lab1 predict waveform</strong>
</p>
  
In Lab1, I completed the following tasks  
  
1. Create the SystemVerilog testbench file for a Device Under Test(DUT)  
  
2. Compile and simulate the SystemVerilog test program

## [Lab2](https://github.com/RexJian/SystemVerilogLabs/tree/main/Lab2)
#### Goal : 
#### Develope a set of routines to drive one packet into input port3 and visually observe the payload of the packet coming out of output port7  
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab2/ArchitectureLab2.png" width="400" height="360" alt="Lab2 Architecture">
  <br> <strong>Fig4. Lab2 Architecture</strong>
</p> 

#### Predict Waveform and Simulate Waveform : 
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab2/Lab2Waveform.png" alt="Lab2 simulate waveform">
  <br> <strong>Fig5. Lab2 simulate waveform</strong>
</p>
<br><br>

<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab2/Lab2PredictWaveform_input.png" alt="Lab2 input predict waveform">
  <br> <strong>Fig6. Lab2 input predict waveform</strong>
</p>
<br><br>

<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab2/Lab2PredictWaveform_output.png" alt="Lab2 output predict waveform">
  <br> <strong>Fig7. Lab2 output predict waveform</strong>
</p>
<br><br>

In Lab2, I completed the following tasks  

1. Extend the SystemVerilog testbench from lab1 to send a packet from an input port through an output port

2. Compile and simulate the router with the updated SystemVerilog testbench
 
