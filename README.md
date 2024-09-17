# Hardware Binary Search Implementation

This design uses a controller datapath split enabled by the "Algorithmic State Machine Datapath" (ASMD) modeling technique to implement the binary search algorithm via specialized hardware on an FPGA. Special attention is paid to edge cases and wrapping the design for upload to physical FPGA development board. This approach vastly improves computational efficiency when compared to a traditional CPU powered alternative.

Functional verification and static timing analysis was performed to ensure adherence to architectural specification and to analyze potential optimizations in reducing the number of states. A walkthrough of the process is available in pdf form: ![verification](functional-verification.pdf)
