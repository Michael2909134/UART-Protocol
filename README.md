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
-Idle State: Line held HIGH (logic 1)
<br>
-Start Bit: Logic 0 indicating beginning of transmission
<br>
-Data Bits: 8 bits (LSB first)
<br>
-Stop Bit: Logic 1 indicating end of frame

**Oversampling Technique (Receiver)**
<br>
To ensure accurate sampling without a shared clock, the receiver employs 16× oversampling:
<br>
1.Detect falling edge (start bit)
<br>
2.Sample at the midpoint of the start bit
<br>
3.Sample each data bit at its midpoint
<br>
4.Shift received bits into a register
<br>
5.Sample stop bit to complete the frame
<br>
This technique minimizes timing errors and improves noise immunity.

**Tools & Platform**
<br>
HDL: Verilog
<br>
Simulation & Synthesis: Vivado
<br>
Target FPGA: KC705 (Kintex-7)
<br>

**Key Highlights**
<br>
-Fully asynchronous serial communication
<br>
-Robust FSM-based design
<br>
-Optimized baud rate generation
<br>
-FPGA-validated implementation



 

