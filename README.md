# Systolic Array
A systolic array is a specialized hardware architecture designed for high-performance parallel computations, particularly suited for matrix multiplications and convolutions. It consists of a grid of simple, locally connected processing elements (PEs) that perform operations in a synchronized manner, enabling efficient data flow and computation.

## Systolic Array Architecture in the Design
The systolic array in the thesis is implemented as follows:
### Processing Elements (PEs):
- Each PE performs a multiply-accumulate (MAC) operation, which is fundamental to convolutional computations.
### Dataflow:
- Output Stationary (OS) Dataflow: Inputs are streamed into the array, and results are accumulated within the PEs. This simplifies control logic and reduces data movement.

- Input Sequencing: Data is fed into the array in a staggered manner to ensure correct alignment for matrix multiplication .
  ![image](https://github.com/user-attachments/assets/b705c1d8-2566-4e5c-90a6-c0b766545540)

