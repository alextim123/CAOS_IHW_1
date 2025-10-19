# array_ops.asm
# ������������ form_arrayB: ��������� ������ B �� ��������� ������� A,
# ������� ������������ ������������ � �����.
#
# ��� ��������� ���������� ����� ���� �����������:
#   12(sp_old) = N        � �������� ����� ������� A
#    8(sp_old) = Aaddr    � ����� ������ ������� A
#    4(sp_old) = Baddr    � ����� ������ ������� B
#
# ����� ���������� � ������ 12(sp_old) ������������ ����� �������� N �
# ���������� ���������, ������� ���������� � ������ B.

    .text
    .align 2
    .global form_arrayB

form_arrayB:
    # ������ ���� ����� � ��������� ��������
    addi    sp, sp, -48
    sw      ra, 44(sp)
    sw      s0, 40(sp)
    sw      s1, 36(sp)
    sw      s2, 32(sp)
    sw      s3, 28(sp)

    # s0 = ��������� �� ���� ����������� (�� ��������� ������ �����)
    addi    s0, sp, 48

    # ��������� ��������� �� ����� �����������
    lw      s1, 12(s0)      # s1 = N
    lw      s2, 8(s0)       # s2 = Aaddr
    lw      s3, 4(s0)       # s3 = Baddr

    # ��������� ����� ����������
    sw      s1, 24(sp)      # N
    sw      s2, 20(sp)      # Aaddr
    sw      s3, 16(sp)      # Baddr

    # ������������� ���������
    sw      zero, 12(sp)    # i_off = 0
    sw      zero, 8(sp)     # j_off = 0

scan_loop:
    lw      t0, 24(sp)      # N
    lw      t1, 12(sp)      # i_off
    slli    t2, t0, 2       # 4*N
    bge     t1, t2, scan_done

    # ������ A[i]
    lw      t4, 20(sp)
    add     t5, t4, t1
    lw      t6, 0(t5)

    # �������� �������: ������������� � ������
    blt     t6, zero, check_even
    addi    t1, t1, 4
    sw      t1, 12(sp)
    j       scan_loop

check_even:
    andi    t0, t6, 1
    bne     t0, zero, skip_store

    # ��������� � B[j]
    lw      t4, 16(sp)
    lw      t5, 8(sp)
    add     t2, t4, t5
    sw      t6, 0(t2)

    # j_off += 4
    addi    t5, t5, 4
    sw      t5, 8(sp)

skip_store:
    addi    t1, t1, 4
    sw      t1, 12(sp)
    j       scan_loop

scan_done:
    # count = j_off / 4, �������� � ���� ����������� (12(s0))
    lw      t0, 8(sp)
    srli    t0, t0, 2
    sw      t0, 12(s0)

    # �������������� ��������� � �������
    lw      ra, 44(sp)
    lw      s0, 40(sp)
    lw      s1, 36(sp)
    lw      s2, 32(sp)
    lw      s3, 28(sp)
    addi    sp, sp, 48
    ret
