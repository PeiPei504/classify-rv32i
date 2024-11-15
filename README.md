# Assignment 2: Classify
## Part A: Mathematical function
### abs
To convert a specific integer in memory to its absolute value (non-negative), the program processes as follows:

**Handling Negative Numbers**

**`srai t1, t0, 31`**  
Arithmetic right shift, shifts `t0` right by 31 bits, and stores the result in `t1`.  
- If `t0` is negative, the most significant bit (sign bit) is 1. Shifting right by 31 bits results in `t1 = -1`.  
- If `t0` is non-negative, shifting results in `t1 = 0`.

**`xor t0, t0, t1`**  
- If `t1 = -1` (i.e., `t0` is negative), all bits of `t0` are inverted, equivalent to `~t0`.  
- If `t1 = 0` (i.e., `t0` is non-negative), `t0` remains unchanged.

**`sub t0, t0, t1`**  
- If `t1 = -1`, this operation adds 1, completing the conversion from negative to positive.  
- If `t1 = 0`, `t0` remains unchanged.

### ReLU
Replace all negative elements in a memory array with 0, while keeping positive or zero elements unchanged.  

The program logic is as follows:  
1. Use a loop to iterate through each element of the array.  
2. Check the value of each element:  
 - If the value is less than 0, set it to 0.  
 - Otherwise, leave it unchanged.  
3. Calculate the address of each array element using an offset to ensure each element is processed sequentially.

### ArgMax
Find the index of the maximum value in an array. The program logic is as follows:

1. Initialize the first element as the maximum value and record its index.
2. Iterate through the remaining elements in the array, comparing each one:
  - If the element value is greater than the current maximum value, update the maximum value and its index.
  - Otherwise, skip that element.
3.Finally, return the index of the maximum value.

Explanation of the assembly code:

(1)**`beq t2, a1`**, done: If the loop counter t2 equals the array length (a1), jump to done to exit the loop.

(2) Load and compare:

**`lw t3, 4(a0)`**: Load the value of the next element from the current address a0 (offset by 4 bytes for the next element) into t3.

**`ble t3, t0, skip`**: If t3 (the current element's value) is less than or equal to the current maximum value t0, jump to skip and do not update the maximum value.

(3) Update maximum value and index:

**`mv t0, t3`**: Update the maximum value to t3.

**`mv t1, t2`**: Update the index of the maximum value to the current loop counter t2.

(4) Move to the next element:

**`addi a0, a0, 4`**: Move the array address pointer forward by 4 bytes to the next element.

**`addi t2, t2, 1`**: Increment the loop counter by 1.

**`j loop`**: Jump back to the start of the loop to continue the next iteration.

### Dot
The code calculates the dot product of two arrays, `arr0` and `arr1`, where each array has custom strides (`a3` and `a4`). The calculation result is stored in `a0`.

(1) Loop:

The loop runs from `i = 0` to `i = a2 - 1` (i.e., the length of the arrays).

(2) Calculate Array Addresses:

For each element `i`, the offset for `arr0` is calculated as `i * stride0` (result stored in `t2`), and the offset for `arr1` is calculated as `i * stride1` (result stored in `t4`).
Then, `t2` and `t4` are shifted left by 2 bits (using `slli`), effectively multiplying them by 4, because each integer occupies 4 bytes.

(3) Read Array Elements:

- `t3`: Stores `arr0[i * stride0]` (the value read from the memory address calculated by `a0` and `t2`).
- `t5`: Stores `arr1[i * stride1]` (the value read from the memory address calculated by `a1` and `t4`).

(4) Calculate the Product and Accumulate:

- `t6`: Stores the product of `t3` and `t5` (i.e., `arr0[i] * arr1[i]`).
- The result in `t6` is added to the accumulated sum (`t0`).

## Result
```bash
test_abs_minus_one (__main__.TestAbs.test_abs_minus_one) ... ok
test_abs_one (__main__.TestAbs.test_abs_one) ... ok
test_abs_zero (__main__.TestAbs.test_abs_zero) ... ok
test_argmax_invalid_n (__main__.TestArgmax.test_argmax_invalid_n) ... ok
test_argmax_length_1 (__main__.TestArgmax.test_argmax_length_1) ... ok
test_argmax_standard (__main__.TestArgmax.test_argmax_standard) ... ok
test_chain_1 (__main__.TestChain.test_chain_1) ... ok
test_classify_1_silent (__main__.TestClassify.test_classify_1_silent) ... ok
test_classify_2_print (__main__.TestClassify.test_classify_2_print) ... ok
test_classify_3_print (__main__.TestClassify.test_classify_3_print) ... ok
test_classify_fail_malloc (__main__.TestClassify.test_classify_fail_malloc) ... ok
test_classify_not_enough_args (__main__.TestClassify.test_classify_not_enough_args) ... ok
test_dot_length_1 (__main__.TestDot.test_dot_length_1) ... ok
test_dot_length_error (__main__.TestDot.test_dot_length_error) ... ok
test_dot_length_error2 (__main__.TestDot.test_dot_length_error2) ... ok
test_dot_standard (__main__.TestDot.test_dot_standard) ... ok
test_dot_stride (__main__.TestDot.test_dot_stride) ... ok
test_dot_stride_error1 (__main__.TestDot.test_dot_stride_error1) ... ok
test_dot_stride_error2 (__main__.TestDot.test_dot_stride_error2) ... ok
test_matmul_incorrect_check (__main__.TestMatmul.test_matmul_incorrect_check) ... ok
test_matmul_length_1 (__main__.TestMatmul.test_matmul_length_1) ... ok
test_matmul_negative_dim_m0_x (__main__.TestMatmul.test_matmul_negative_dim_m0_x) ... ok
test_matmul_negative_dim_m0_y (__main__.TestMatmul.test_matmul_negative_dim_m0_y) ... ok
test_matmul_negative_dim_m1_x (__main__.TestMatmul.test_matmul_negative_dim_m1_x) ... ok
test_matmul_negative_dim_m1_y (__main__.TestMatmul.test_matmul_negative_dim_m1_y) ... ok
test_matmul_nonsquare_1 (__main__.TestMatmul.test_matmul_nonsquare_1) ... ok
test_matmul_nonsquare_2 (__main__.TestMatmul.test_matmul_nonsquare_2) ... ok
test_matmul_nonsquare_outer_dims (__main__.TestMatmul.test_matmul_nonsquare_outer_dims) ... ok
test_matmul_square (__main__.TestMatmul.test_matmul_square) ... ok
test_matmul_unmatched_dims (__main__.TestMatmul.test_matmul_unmatched_dims) ... ok
test_matmul_zero_dim_m0 (__main__.TestMatmul.test_matmul_zero_dim_m0) ... ok
test_matmul_zero_dim_m1 (__main__.TestMatmul.test_matmul_zero_dim_m1) ... ok
test_read_1 (__main__.TestReadMatrix.test_read_1) ... ok
test_read_2 (__main__.TestReadMatrix.test_read_2) ... ok
test_read_3 (__main__.TestReadMatrix.test_read_3) ... ok
test_abs_minus_one (__main__.TestAbs.test_abs_minus_one) ... ok
test_abs_one (__main__.TestAbs.test_abs_one) ... ok
test_abs_zero (__main__.TestAbs.test_abs_zero) ... ok
test_argmax_invalid_n (__main__.TestArgmax.test_argmax_invalid_n) ... ok
test_argmax_length_1 (__main__.TestArgmax.test_argmax_length_1) ... ok
test_argmax_standard (__main__.TestArgmax.test_argmax_standard) ... ok
test_chain_1 (__main__.TestChain.test_chain_1) ... ok
test_classify_1_silent (__main__.TestClassify.test_classify_1_silent) ... ok
test_classify_2_print (__main__.TestClassify.test_classify_2_print) ... ok
test_classify_3_print (__main__.TestClassify.test_classify_3_print) ... ok
test_classify_fail_malloc (__main__.TestClassify.test_classify_fail_malloc) ... ok
test_classify_not_enough_args (__main__.TestClassify.test_classify_not_enough_args) ... ok
test_dot_length_1 (__main__.TestDot.test_dot_length_1) ... ok
test_dot_length_error (__main__.TestDot.test_dot_length_error) ... ok
test_dot_length_error2 (__main__.TestDot.test_dot_length_error2) ... ok
test_dot_standard (__main__.TestDot.test_dot_standard) ... ok
test_dot_stride (__main__.TestDot.test_dot_stride) ... ok
test_dot_stride_error1 (__main__.TestDot.test_dot_stride_error1) ... ok
test_dot_stride_error2 (__main__.TestDot.test_dot_stride_error2) ... ok
test_matmul_incorrect_check (__main__.TestMatmul.test_matmul_incorrect_check) ... ok
test_matmul_length_1 (__main__.TestMatmul.test_matmul_length_1) ... ok
test_matmul_negative_dim_m0_x (__main__.TestMatmul.test_matmul_negative_dim_m0_x) ... ok
test_matmul_negative_dim_m0_y (__main__.TestMatmul.test_matmul_negative_dim_m0_y) ... ok
test_matmul_negative_dim_m1_x (__main__.TestMatmul.test_matmul_negative_dim_m1_x) ... ok
test_matmul_negative_dim_m1_y (__main__.TestMatmul.test_matmul_negative_dim_m1_y) ... ok
test_matmul_nonsquare_1 (__main__.TestMatmul.test_matmul_nonsquare_1) ... ok
test_matmul_nonsquare_2 (__main__.TestMatmul.test_matmul_nonsquare_2) ... ok
test_matmul_nonsquare_outer_dims (__main__.TestMatmul.test_matmul_nonsquare_outer_dims) ... ok
test_matmul_square (__main__.TestMatmul.test_matmul_square) ... ok
test_matmul_unmatched_dims (__main__.TestMatmul.test_matmul_unmatched_dims) ... ok
test_matmul_zero_dim_m0 (__main__.TestMatmul.test_matmul_zero_dim_m0) ... ok
test_matmul_zero_dim_m1 (__main__.TestMatmul.test_matmul_zero_dim_m1) ... ok
test_read_1 (__main__.TestReadMatrix.test_read_1) ... ok
test_read_2 (__main__.TestReadMatrix.test_read_2) ... ok
test_read_3 (__main__.TestReadMatrix.test_read_3) ... ok
test_read_fail_fclose (__main__.TestReadMatrix.test_read_fail_fclose) ... ok
test_read_fail_fopen (__main__.TestReadMatrix.test_read_fail_fopen) ... ok
test_read_fail_fread (__main__.TestReadMatrix.test_read_fail_fread) ... ok
test_read_fail_malloc (__main__.TestReadMatrix.test_read_fail_malloc) ... ok
test_relu_invalid_n (__main__.TestRelu.test_relu_invalid_n) ... ok
test_relu_length_1 (__main__.TestRelu.test_relu_length_1) ... ok
test_relu_standard (__main__.TestRelu.test_relu_standard) ... ok
test_write_1 (__main__.TestWriteMatrix.test_write_1) ... ok
test_write_fail_fclose (__main__.TestWriteMatrix.test_write_fail_fclose) ... ok
test_write_fail_fopen (__main__.TestWriteMatrix.test_write_fail_fopen) ... ok
test_write_fail_fwrite (__main__.TestWriteMatrix.test_write_fail_fwrite) ... ok

----------------------------------------------------------------------
Ran 46 tests in 29.517s

OK
```
