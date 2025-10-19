# io.asm
# Подпрограммы для ввода и вывода данных (строки, числа, массивы).
# Для вызова подпрограмм используются параметры через стек:
#   12(sp_old) — первый аргумент
#    8(sp_old) — второй аргумент
#
# Все подпрограммы сохраняют регистры и корректно восстанавливают стек.

.data
space:      .asciz " "
nl:         .asciz "\n"

.text
.global print_string, read_int, print_int, read_array, print_array


# =========================================================
# print_string
# ---------------------------------------------------------
# Печатает ASCIIZ-строку, адрес которой передаётся по адресу 12(sp_old).
# =========================================================
print_string:
    addi    sp, sp, -16
    sw      ra, 12(sp)
    sw      s0, 8(sp)
    addi    s0, sp, 16
    lw      a0, 12(s0)
    li      a7, 4
    ecall
    lw      ra, 12(sp)
    lw      s0, 8(sp)
    addi    sp, sp, 16
    ret


# =========================================================
# read_int
# ---------------------------------------------------------
# Считывает одно целое число с клавиатуры, результат возвращается в a0.
# =========================================================
read_int:
    addi    sp, sp, -16
    sw      ra, 12(sp)
    li      a7, 5
    ecall
    lw      ra, 12(sp)
    addi    sp, sp, 16
    ret


# =========================================================
# print_int
# ---------------------------------------------------------
# Печатает одно целое число, адрес которого передаётся по адресу 12(sp_old).
# =========================================================
print_int:
    addi    sp, sp, -16
    sw      ra, 12(sp)
    sw      s0, 8(sp)
    addi    s0, sp, 16
    lw      t0, 12(s0)
    lw      a0, 0(t0)
    li      a7, 1
    ecall
    lw      ra, 12(sp)
    lw      s0, 8(sp)
    addi    sp, sp, 16
    ret


# =========================================================
# read_array
# ---------------------------------------------------------
# Параметры:
#   12(sp_old) — N (размер массива)
#    8(sp_old) — addr (адрес начала массива)
# Считывает N чисел с клавиатуры и записывает их в память, начиная с addr.
# =========================================================
read_array:
    addi    sp, sp, -32
    sw      ra, 28(sp)
    sw      s0, 24(sp)
    sw      s1, 20(sp)
    sw      s2, 16(sp)
    addi    s0, sp, 32

    lw      s1, 12(s0)
    lw      s2, 8(s0)

read_array_loop:
    blez    s1, read_array_done
    jal     read_int
    sw      a0, 0(s2)
    addi    s2, s2, 4
    addi    s1, s1, -1
    j       read_array_loop

read_array_done:
    lw      ra, 28(sp)
    lw      s0, 24(sp)
    lw      s1, 20(sp)
    lw      s2, 16(sp)
    addi    sp, sp, 32
    ret


# =========================================================
# print_array
# ---------------------------------------------------------
# Параметры:
#   12(sp_old) — N (размер массива)
#    8(sp_old) — addr (адрес начала массива)
# Печатает N элементов массива через пробел и перевод строки после вывода.
# =========================================================
print_array:
    addi    sp, sp, -32
    sw      ra, 28(sp)
    sw      s0, 24(sp)
    sw      s1, 20(sp)
    sw      s2, 16(sp)
    addi    s0, sp, 32

    lw      s1, 12(s0)
    lw      s2, 8(s0)
    blez    s1, print_array_end

print_array_loop:
    addi    sp, sp, -16
    sw      s2, 12(sp)
    jal     print_int
    addi    sp, sp, 16

    addi    sp, sp, -16
    la      t0, space
    sw      t0, 12(sp)
    jal     print_string
    addi    sp, sp, 16

    addi    s2, s2, 4
    addi    s1, s1, -1
    bgtz    s1, print_array_loop

print_array_end:
    addi    sp, sp, -16
    la      t0, nl
    sw      t0, 12(sp)
    jal     print_string
    addi    sp, sp, 16

    lw      ra, 28(sp)
    lw      s0, 24(sp)
    lw      s1, 20(sp)
    lw      s2, 16(sp)
    addi    sp, sp, 32
    ret