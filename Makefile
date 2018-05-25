# ���������� Makefile ��� ������� mdr32gnuas
# ������ mdr32gnuas - �������� ������, ��� ������� ������� ��������� ������������,
# ��� ������ �������� ��� ���������������� MDR32F9Q2I
# ���� ����������: GNU As (GNU Assembler). ��������� ������ UAL ARM
# ����: 10 ����� 2013 ����
# �����: �.�.�������, ��������� ����: http://gimmor.blogspot.com/
#
#
# ��������������� ���������� � ������������ ��������� Windows:
# 1. ������ ���� ���������� ����� ������������ "Sourcery CodeBench Lite Edition for ARM EABI"
# 2. ��� ���������������� ���������, ������ ���� �������� ��� ������� �� ��������� ������,
# ��� ���� ���������� "Sourcery CodeBench Lite Edition for ARM EABI" ��������� ����������
# PATH
# 3. ������ ���� ����������� ��������������� ����� Eclipse. (� ���� Juno SR1)
# 4. � ����� Eclipse, ������ ���� ���������� �.�. GNU ARM Plugin
# �����, ������������ ����������
# 5. ������� ��� �������� �������� � ������ ����������������
# 6. GNU Hardware debugging ��� Eclipse


# ������ ������� ����� �������������� ������� �������� cs-make ������� � �������� �������
# ������ ����� ����� ���� ������ �� ��������������� ����� Eclipse
# ��� ����� ���� ������� ����� ������ � ������������� ����� �������,
# �� ����� ���������� � ������������� ���������� �� ��� �����: 
# http://gimmor.blogspot.com/2013/03/mdr32f9q2i-arm-gnu-as-example.html
#
# �������������� �����, ������������ ����� ������ �������
# mdr32gnuas.bin - �������� ����� ��������, ��� �������� � ������ ����������������,
# ���������, ����������� ������ ������ ������ ������
# mdr32gnuas.hex - ��������, � ������� Intel Hex, ��� �������� �� Flash ���������� ���������
# mdr32gnuas-ram.elf - ����� ��������, � ���������� ����������, ��� ��������� gdb
# ��� ���������� � ��� ���������������� ������� MDR32F9Q2I
# mdr32gnuas-flash.elf - ����� ��������, � ���������� �����������, ��� ��������� gdb
# ��� ���������� � ��� ���������������� ������� MDR32F9Q2I
# mdr32gnuas.o - ������������� ��������� ���� ��������, ���� ����� �� ����� 
#
# "������ �������� ���������"
# ������ ������� ����������� �� ���������� ����� ����������� ���������� - MDR32-Solo
# http://gimmor.blogspot.ru/2013/03/mdr32-solo-mdr32f9q2i.html
# ��������� ��������� � ����� PA.1
# 

# all - ���� ��� ������ ��������, � ����� Windows
all:
	@echo "������ ������� mdr32gnuas - ����������� ������� �� ���������� GNU As..."
	@echo "���������� ������������� �����..."
	arm-none-eabi-as -mcpu=cortex-m3 -mthumb -mapcs-32 -gstabs -o mdr32gnuas.o mdr32gnuas.S
	@echo "���������� mdr32gnuas-ram.elf - �����, ��� ������� � ��� ����������������..."
	arm-none-eabi-ld --Ttext=0x20000000 --relax -o mdr32gnuas-ram.elf mdr32gnuas.o
	arm-none-eabi-ld --Ttext=0x08000000 --relax -o mdr32gnuas-flash.elf mdr32gnuas.o
	@echo "���������� �������� � ������� intel-hex... "
	arm-none-eabi-objcopy -Oihex mdr32gnuas-flash.elf mdr32gnuas.hex
	@echo "���������� �������� � �������� �������..."
	arm-none-eabi-objcopy -Obinary -j .text mdr32gnuas-flash.elf mdr32gnuas.bin
	@echo "�������� ������� ������������ ������ ���� � ������..."
	arm-none-eabi-size mdr32gnuas-ram.elf
	arm-none-eabi-size mdr32gnuas-flash.elf

# clean - ���� ������� ��������������� ������, � ����� Windows
clean:
	del mdr32gnuas.o
	del mdr32gnuas-ram.elf
	del mdr32gnuas-flash.elf
	del mdr32gnuas.bin
	del mdr32gnuas.hex

	