# Systolic Array
A systolic array is a specialized hardware architecture designed for high-performance parallel computations, particularly suited for matrix multiplications and convolutions. It consists of a grid of simple, locally connected processing elements (PEs) that perform operations in a synchronized manner, enabling efficient data flow and computation.

## Systolic Array Architecture in the Design
The systolic array in the thesis is implemented as follows:
- Each PE performs a multiply-accumulate (MAC) operation, which is fundamental to convolutional computations.


###### PEs are arranged in an 8x8 grid, totaling 64 PEs per core. With 8 cores, the design uses 512 DSP blocks (60% of the FPGA's DSP resources).
