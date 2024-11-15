.globl dot

.text
# =======================================================
# FUNCTION: Strided Dot Product Calculator
#
# Calculates sum(arr0[i * stride0] * arr1[i * stride1])
# where i ranges from 0 to (element_count - 1)
#
# Args:
#   a0 (int *): Pointer to first input array
#   a1 (int *): Pointer to second input array
#   a2 (int):   Number of elements to process
#   a3 (int):   Skip distance in first array
#   a4 (int):   Skip distance in second array
#
# Returns:
#   a0 (int):   Resulting dot product value
#
# Preconditions:
#   - Element count must be positive (>= 1)
#   - Both strides must be positive (>= 1)
#
# Error Handling:
#   - Exits with code 36 if element count < 1
#   - Exits with code 37 if any stride < 1
# =======================================================
dot:
    li t0, 1
    blt a2, t0, error_terminate  
    blt a3, t0, error_terminate   
    blt a4, t0, error_terminate  

    li t0, 0            
    li t1, 0         

loop_start:
    bge t1, a2, loop_end
     # Calculate the offset address of the first array
    mul t2, t1, a3        # t2 = i * stride0
    slli t2, t2, 2        # t2 = t2 * 4 (因為每個int是4字節)
    add t2, a0, t2        # t2 = arr0 + offset
    lw t3, 0(t2)          # t3 = arr0[i * stride0]

    # Calculate the offset address of the second array
    mul t4, t1, a4        # t4 = i * stride1
    slli t4, t4, 2        # t4 = t4 * 4
    add t4, a1, t4        # t4 = arr1 + offset
    lw t5, 0(t4)          # t5 = arr1[i * stride1]

    # Calculate the product and add it to the result
    mul t6, t3, t5        # t6 = arr0[i * stride0] * arr1[i * stride1]
    add t0, t0, t6        # sum += t6

    # Increment the loop counter
    addi t1, t1, 1        # i++
    j loop_start
    # TODO: Add your own implementation

loop_end:
    mv a0, t0
    jr ra

error_terminate:
    blt a2, t0, set_error_36
    li a0, 37
    j exit

set_error_36:
    li a0, 36
    j exit
