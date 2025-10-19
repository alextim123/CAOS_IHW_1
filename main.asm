# main.asm
# �������� ���������, ���������� � ��������� A � B.
# 1) ����������� � ������������ ������ N (1..10).
# 2) �������� �� ����� ������ ��� ������� A � B (�� N*4 ���� ������).
# 3) ��������� �������� ������� A � �������� ��.
# 4) �������� ������ FORM_ARR � �� ������� ��������� � ������������ form_arrayB ����� ����:
#       12(sp) = N, 8(sp) = Aaddr, 4(sp) = Baddr.
#    ������������ ��������� ������ B (��� ������������� � ������ �������� A)
#    � ���������� ������� ����� ���� ����� �������� N � ���������� ��������� � B.
# 5) ����� �������� ��������� �������� ������ B ������, ������ ����������� N.
#
# ����������� ��� ������� ����������, ��� ����������� ���������
# ����������� � ����������� ����������� � �����.

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
    # ������ ������� �������
    PRINT_STR(msg_enterN)
    
    # ���� N � s0
    READ_INT(s0)
    
    # �������� ������������ N
    CHECK_N(s0, t0)
    beqz t0, n_error

    # ��������� ������ ������� � ������: s1 = 4*N
    li      s1, 4
    mul     s1, s1, s0
    
    # �������� ������ ��� ������� A � B
    sub     sp, sp, s1
    mv      s2, sp          # s2 = ����� A
    sub     sp, sp, s1
    mv      s3, sp          # s3 = ����� B
    
    # ���� ������� A
    PRINT_STR(msg_inputA)
    READ_ARR(s0, s2)
    
    # ������ ��������� �������
    PRINT_STR(msg_A_label)
    PRINT_ARR(s0, s2)
    
    # ����� ������������ ������� B
    # ���������� ���������:
    #   12(sp)=N (s0), 8(sp)=Aaddr (s2), 4(sp)=Baddr (s3)
    # ����� �������� ������������ ������� �������� N (����� �����) � �����.
    FORM_ARR(s0, s2, s3, s4)
    
    # ������ ������� B ������ s4
    PRINT_STR(msg_B_label)
    PRINT_ARR(s4, s3)
    
    # ���������� ���������� �����
    add     sp, sp, s1
    add     sp, sp, s1
    
    # ����������
    li      a7, 10
    ecall

n_error:
    PRINT_STR(msg_errN)
    li      a7, 10
    ecall
