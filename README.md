# UART Protocol using verilog 

U – Universal: Applicable across diverse devices
<br>
A – Asynchronous: No clock line is shared
<br>
R – Receiver, T – Transmitter
<br>
Uses a single data line for transmission
<br>
Data integrity depends on accurate baud rate timing
<br>
Common baud rates include:
<br>
4800, 9600, 19200, 57600, 115200-Protocol
<br>

**Objective**
<br>
Design and implement UART Transmitter and Receiver using Verilog HDL
<br>
Simulate the design using Vivado
<br>
Synthesize and deploy on KC705 Kintex-7 FPGA
<br>
Verify correct serial data transmission and reception using testbenches and hardware validation
<br>
**UART Frame Structure**
<br>
A standard UART frame consists of:
<br>
Idle State: Line held HIGH (logic 1)
<br>
Start Bit: Logic 0 indicating beginning of transmission
<br>
Data Bits: 8 bits (LSB first)
<br>
Stop Bit: Logic 1 indicating end of frame



 

