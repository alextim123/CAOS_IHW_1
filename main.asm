# main.asm
# Основная программа, работающая с массивами A и B.
# 1) Запрашивает у пользователя размер N (1..10).
# 2) Выделяет на стеке память под массивы A и B (по N*4 байт каждый).
# 3) Считывает элементы массива A и печатает их.
# 4) Вызывает макрос FORM_ARR — он передаёт параметры в подпрограмму form_arrayB через стек:
#       12(sp) = N, 8(sp) = Aaddr, 4(sp) = Baddr.
#    Подпрограмма формирует массив B (все отрицательные и чётные элементы A)
#    и записывает обратно через стек новое значение N — количество элементов в B.
# 5) После возврата программа печатает массив B длиной, равной обновлённому N.
#
# Комментарии при вызовах показывают, как фактические аргументы
# соотносятся с формальными параметрами в стеке.

    j main
    .include "macros.asm"

    .data
msg_enterN:    .asciz "Enter size of the array N (1..10): "
msg_errN:      .asciz "Error: N should be 1 <= N <= 10\n"
msg_inputA:    .asciz "Enter elements of array A (one integer per line):\n"
msg_A_label:   .asciz "Initial array A:\n"
msg_B_label:   .asciz "Formed array B (negative & even elements):\n"

    .text
    .globl main
main:
    # Запрос размера массива
    PRINT_STR(msg_enterN)
    
    # Ввод N в s0
    READ_INT(s0)
    
    # Проверка корректности N
    CHECK_N(s0, t0)
    beqz t0, n_error

    # Вычислить размер массива в байтах: s1 = 4*N
    li      s1, 4
    mul     s1, s1, s0
    
    # Выделить память под массивы A и B
    sub     sp, sp, s1
    mv      s2, sp          # s2 = адрес A
    sub     sp, sp, s1
    mv      s3, sp          # s3 = адрес B
    
    # Ввод массива A
    PRINT_STR(msg_inputA)
    READ_ARR(s0, s2)
    
    # Печать исходного массива
    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)
    
    # Вызов формирования массива B
    # Передаются параметры:
    #   12(sp)=N (s0), 8(sp)=Aaddr (s2), 4(sp)=Baddr (s3)
    # После возврата подпрограмма обновит значение N (новая длина) в стеке.
    FORM_ARR(s0, s2, s3, s4)
    
    # Печать массива B длиной s4
    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    
    # Освободить выделенное место
    add     sp, sp, s1
    add     sp, sp, s1
    
    # Завершение
    li      a7, 10
    ecall

n_error:
    PRINT_STR(msg_errN)
    li      a7, 10
    ecall
