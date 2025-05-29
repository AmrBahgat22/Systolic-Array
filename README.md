# Systolic Array
A systolic array is a specialized hardware architecture designed for high-performance parallel computations, particularly suited for matrix multiplications and convolutions. It consists of a grid of simple, locally connected processing elements (PEs) that perform operations in a synchronized manner, enabling efficient data flow and computation.

## Processing core internal structure:

![image](https://github.com/user-attachments/assets/2799bca1-3c3a-4074-b5f1-55658d394ebe)


## OS Systolic arrays and on the right PE in OS Systolic array:

![image](https://github.com/user-attachments/assets/3401b186-2102-4fc2-ac95-d7bebff0391c)

## WS and IS Systolic arrays:

![image](https://github.com/user-attachments/assets/50be8d46-527c-4c55-8df7-9bccf2178c3a)


## Systolic Array Architecture in the Design
The systolic array in the thesis is implemented as follows:
### Processing Elements (PEs):
- Each PE performs a multiply-accumulate (MAC) operation, which is fundamental to convolutional computations.
### Dataflow:
- Output Stationary (OS) Dataflow: Inputs are streamed into the array, and results are accumulated within the PEs. This simplifies control logic and reduces data movement.

- Input Sequencing: Data is fed into the array in a staggered manner to ensure correct alignment for matrix multiplication.
  
  ![image](https://github.com/user-attachments/assets/b705c1d8-2566-4e5c-90a6-c0b766545540)

  ### Lowering Process:
  - The im2row algorithm transforms input feature maps into a matrix format compatible with systolic array multiplication (Figure). This involves unrolling sliding windows of the input into rows for efficient dot-product computation.

![image](https://github.com/user-attachments/assets/0fcab30b-dbbe-47c1-84db-62bba81a9cb7)

