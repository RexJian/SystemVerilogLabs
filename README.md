# SystemVerilog Typical Architecture Labs
Use SystemVerilog to build a typical architecture of 16*16 crosspoint switch router, including implementation of functional coverage to measure the progress of testbench, it looks like the following:
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/LabArchitecture.png" width="500" height="400" >
</p> 

## Table of Content
- [Lab1](#lab1)
- [Lab2](#lab2)
- [Lab3](#lab3)
- [Lab4](#lab4)
- [Lab5](#lab5)  
- [Lab6](#lab6)
  
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
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab2/ArchitectureLab2.png" width="480" height="550" alt="Lab2 Architecture">
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
 

## [Lab3](https://github.com/RexJian/SystemVerilogLabs/tree/main/Lab3)
#### Goal : 
#### Develope a monitor to packet payload from the router. Then, use the checker for checking the output of the router     
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab3/ArchitectureLab3.png" width="450" height="550" alt="Lab3 Architecture">
  <br> <strong>Fig8. Lab3 Architecture</strong>
</p>

#### Compare checker's message of wrong rtl and correct rtl:
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab3/WrongCheckResult.png" alt="Lab3 wrong rtl message">
  <br> <strong>Fig9. Lab3 wrong rtl message</strong>
</p>
<br><br>

<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab3/CorrectCheckResult.png" alt="Lab3 correct rtl message">
  <br> <strong>Fig10. Lab3 correct rtl message</strong>
</p>
<br><br>

In Lab3, I completed the following tasks  

1. Develope a monitor to sample the output of the router

2. Develope a checker to  verify the output of the router

3. Run driver and monitor routines concurrently

4. Verify the self-checking mechanism by executing the testbench against a faulty DUT

## [Lab4](https://github.com/RexJian/SystemVerilogLabs/tree/main/Lab4)
#### Goal : 
#### Create random Packet objects in the generator then send, receive and check the correctness of the DUT using these Packet objects.     
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab4/ArchitectureLab4.png" width="450" height="550" alt="Lab4 Architecture">
  <br> <strong>Fig11. Lab4 Architecture</strong>
</p>

#### Compare checker's message of wrong rtl and correct rtl and simulate waveform:
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab4/WrongCheckResult_Lab4.png" alt="Lab4 wrong rtl message">
  <br> <strong>Fig12. Lab4 wrong rtl message</strong>
</p>
<br><br>

<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab4/CorrectCheckResult_Lab4.png" alt="Lab4 correct rtl message">
  <br> <strong>Fig13. Lab4 correct rtl message</strong>
</p>
<br><br>


<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab4/Lab4Waveform.png" alt="Lab4 simulate waveform">
  <br> <strong>Fig14. Lab4 simulate waveform</strong>
</p>
<br><br>

In Lab4, I completed the following tasks  

1. Encapsulate packet information into a Packet class

2. Utilize randomization in Packet class to randomly generate source address, destination address and payload

3. Create two Packet objects, one for the input into the DUT, the other for reconstructing the output of the DUT

4. Use the compare() method embedded in the Packet objects to verify the correctness of DUT operation

## [Lab5](https://github.com/RexJian/SystemVerilogLabs/tree/main/Lab5)
#### Goal : 
#### Build a testbench architecture that is capable of exercising all ports simultaneously.    

<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab5/EncapsulateTransactorArchitectureLab5.png" width="500" height="550" alt="Lab5 Encapsulate Transacotor Architecture">
  <br> <strong>Fig15. Lab5 Transactor Architecture</strong>
</p>

  
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab5/Architecture_Lab5.png" width="450" height="550" alt="Lab5 Architecture">
  <br> <strong>Fig16. Lab5 Architecture</strong>
</p>

#### Compare checker's message of wrong rtl and correct rtl and simulate waveform:
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab5/WrongCheckResult_Lab5.png" alt="Lab5 wrong rtl message">
  <br> <strong>Fig17. Lab5 wrong rtl message</strong>
</p>
<br><br>

  
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab5/CorrectCheckResult_Lab5.png" alt="Lab5 correct rtl message">
  <br> <strong>Fig18. Lab5 correct rtl message</strong>
</p>
<br><br>

  
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab5/Lab5Waveform.png" alt="Lab5 simulate waveform">
  <br> <strong>Fig19. Lab5 simulate waveform</strong>
</p>
<br><br>
In Lab5, I completed the following tasks  

1. Build a generator transactor class  

2. Build a Driver class  

3. Build a Receiver class  

4. Expand the testbench to drive and monitor all input and output ports concurrently

## [Lab6](https://github.com/RexJian/SystemVerilogLabs/tree/main/Lab6)
#### Goal : 
#### Add the functional coverage components in the scoreboard class. Then, use an "Environment" that encapsulates the components and "runs" them  in a standard manner.    

<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab6/ArchitectureLab6.png" width="500" height="380" alt="Lab6 Architecture">
  <br> <strong>Fig20. Lab6 Architecture</strong>
</p>

  

#### Functional coverage message and simulate waveform:
<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab6/CheckResult_Lab6.png" alt="Lab6 functional coverage message">
  <br> <strong>Fig21. Lab6 Functional Coverage message</strong>
</p>
<br><br>


<br>
<p align="center">
  <img src="https://github.com/RexJian/SystemVerilogLabs/blob/main/Lab6/Lab6Waveform.png" alt="Lab6 simulate waveform">
  <br> <strong>Fig22. Lab6 simulate waveform</strong>
</p>
<br><br>

In Lab6, I completed the following tasks  

1. Implement Functional Coverage  

2. Understand the use of Environments and Standardized Test Methodlogies.
