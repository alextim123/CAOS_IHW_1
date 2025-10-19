# tests_even_negative_with_lengths_plus_empty.asm
# Набор тестов для подпрограммы form_arrayB,
# формирующей массив B из элементов массива A,
# которые являются отрицательными и чётными.
#
# Добавлен тест №8: ситуация, когда K = 0 (нет подходящих элементов).

    j test
    .include "macros.asm"

.data
msg_A_label:       .asciz "Initial array A:\n"
msg_expected:      .asciz "Expected array B (neg & even):\n"
msg_B_label:       .asciz "Actual formed array B:\n"
msg_errN:          .asciz "Error: N should be 1 <= N <= 10\n"
msg_nl:            .asciz "\n"

msg1:              .asciz "Test №1: n = 1 (single negative even)\n"
test1N:            .word 1
test1A:            .word -2
test1K:            .word 1
test1_expected:    .word -2
test1B:            .space 4

msg2:              .asciz "Test №2: n = 6 (mixed, several negatives)\n"
test2N:            .word 6
test2A:            .word 1, -2, 3, -4, 5, -6
test2K:            .word 3
test2_expected:    .word -2, -4, -6
test2B:            .space 24

msg3:              .asciz "Test №3: n = 7 (odd count, positives and negatives)\n"
test3N:            .word 7
test3A:            .word -1, -2, -3, -4, -5, -6, 8
test3K:            .word 3
test3_expected:    .word -2, -4, -6
test3B:            .space 28

msg4:              .asciz "Test №4: n = 10 (upper bound, many negatives)\n"
test4N:            .word 10
test4A:            .word -2, -4, -6, -8, -10, 1, 2, 3, -12, 13
test4K:            .word 6
test4_expected:    .word -2, -4, -6, -8, -10, -12
test4B:            .space 40

msg5:              .asciz "Test №5: n = -1 (invalid: < 0)\n"
test5N:            .word -1
test5A:            .word 0
test5K:            .word 0
test5_expected:    .word 0
test5B:            .space 0

msg6:              .asciz "Test №6: n = 0 (invalid)\n"
test6N:            .word 0
test6A:            .word 0
test6K:            .word 0
test6_expected:    .word 0
test6B:            .space 0

msg7:              .asciz "Test №7: n = 11 (invalid: > 10)\n"
test7N:            .word 11
test7A:            .word 0
test7K:            .word 0
test7_expected:    .word 0
test7B:            .space 0

msg8:              .asciz "Test №8: n = 5 (no negative even -> K = 0)\n"
test8N:            .word 5
test8A:            .word 1, 3, 5, -7, -9     # нет отрицательных чётных
test8K:            .word 0
test8_expected:    .space 0
test8B:            .space 20                # буфер под B (5 * 4)

.text
.globl test

test:
# =========================================================
# --------------------- TEST 1 -----------------------------
# =========================================================
    PRINT_STR(msg1)
    lw      s0, test1N

    CHECK_N(s0, t0)
    beqz    t0, invalid_N1

    la      s2, test1A
    la      s3, test1B
    la      s1, test1_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test1K
    PRINT_ARR(t0, s1)

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    j       after_test1

invalid_N1:
    PRINT_STR(msg_errN)

after_test1:
    PRINT_STR(msg_nl)


# =========================================================
# --------------------- TEST 2 -----------------------------
# =========================================================
    PRINT_STR(msg2)
    lw      s0, test2N

    CHECK_N(s0, t0)
    beqz    t0, invalid_N2

    la      s2, test2A
    la      s3, test2B
    la      s1, test2_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test2K
    PRINT_ARR(t0, s1)

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    j       after_test2

invalid_N2:
    PRINT_STR(msg_errN)

after_test2:
    PRINT_STR(msg_nl)


# =========================================================
# --------------------- TEST 3 -----------------------------
# =========================================================
    PRINT_STR(msg3)
    lw      s0, test3N

    CHECK_N(s0, t0)
    beqz    t0, invalid_N3

    la      s2, test3A
    la      s3, test3B
    la      s1, test3_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test3K
    PRINT_ARR(t0, s1)

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    j       after_test3

invalid_N3:
    PRINT_STR(msg_errN)

after_test3:
    PRINT_STR(msg_nl)


# =========================================================
# --------------------- TEST 4 -----------------------------
# =========================================================
    PRINT_STR(msg4)
    lw      s0, test4N

    CHECK_N(s0, t0)
    beqz    t0, invalid_N4

    la      s2, test4A
    la      s3, test4B
    la      s1, test4_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test4K
    PRINT_ARR(t0, s1)

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    j       after_test4

invalid_N4:
    PRINT_STR(msg_errN)

after_test4:
    PRINT_STR(msg_nl)


# =========================================================
# --------------------- TEST 5 -----------------------------
# =========================================================
    PRINT_STR(msg5)
    lw      s0, test5N
    CHECK_N(s0, t0)
    beqz    t0, invalid_N5

    la      s2, test5A
    la      s3, test5B
    la      s1, test5_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test5K
    PRINT_ARR(t0, s1)

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    j       after_test5

invalid_N5:
    PRINT_STR(msg_errN)

after_test5:
    PRINT_STR(msg_nl)


# =========================================================
# --------------------- TEST 6 -----------------------------
# =========================================================
    PRINT_STR(msg6)
    lw      s0, test6N
    CHECK_N(s0, t0)
    beqz    t0, invalid_N6

    la      s2, test6A
    la      s3, test6B
    la      s1, test6_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test6K
    PRINT_ARR(t0, s1)

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    j       after_test6

invalid_N6:
    PRINT_STR(msg_errN)

after_test6:
    PRINT_STR(msg_nl)


# =========================================================
# --------------------- TEST 7 -----------------------------
# =========================================================
    PRINT_STR(msg7)
    lw      s0, test7N
    CHECK_N(s0, t0)
    beqz    t0, invalid_N7

    la      s2, test7A
    la      s3, test7B
    la      s1, test7_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test7K
    PRINT_ARR(t0, s1)

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    j       after_test7

invalid_N7:
    PRINT_STR(msg_errN)

after_test7:
    PRINT_STR(msg_nl)


# =========================================================
# --------------------- TEST 8 (K = 0) ---------------------
# =========================================================
    PRINT_STR(msg8)
    lw      s0, test8N
    CHECK_N(s0, t0)
    beqz    t0, invalid_N8

    la      s2, test8A
    la      s3, test8B
    la      s1, test8_expected

    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)

    PRINT_STR(msg_expected)
    lw      t0, test8K          # t0 = 0
    PRINT_ARR(t0, s1)           # ожидается пустой вывод

    FORM_ARR(s0, s2, s3, s4)

    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)           # должен быть пустой массив
    j       after_test8

invalid_N8:
    PRINT_STR(msg_errN)

after_test8:
    PRINT_STR(msg_nl)

    li      a7, 10
    ecall