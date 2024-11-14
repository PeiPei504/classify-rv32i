.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)       # t0: current max value 
    li t1, 0          # t1: index of max value
    li t2, 1          # t2: loop counter

loop:
    beq t2, a1, done   # if counter == length, exit
    lw t3, 4(a0)       # load next element
    ble t3, t0, skip   # if element <= max, skip
    mv t0, t3          # update max value
    mv t1, t2          # update max index
skip:
    addi a0, a0, 4     # move to next element
    addi t2, t2, 1     # increment counter
    j loop

done:
    mv a0, t1          # return max index
    jr ra

handle_error:
    li a0, 36
    j exit
