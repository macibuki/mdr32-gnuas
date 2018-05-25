# Простейший Makefile для проекта mdr32gnuas
# Проект mdr32gnuas - тестовый пример, для отладки цепочки свободных инструментов,
# для сборки прошивки для микроконтроллера MDR32F9Q2I
# Язык разработки: GNU As (GNU Assembler). Синтаксис команд UAL ARM
# Дата: 10 марта 2013 года
# Автор: Д.А.Жижелев, авторский сайт: http://gimmor.blogspot.com/
#
#
# Предварительные требования к программному окружению Windows:
# 1. Должен быть установлен набор инструментов "Sourcery CodeBench Lite Edition for ARM EABI"
# 2. Все нижеиспользуемые программы, должны быть доступны для запуска из командной строки,
# для чего установщик "Sourcery CodeBench Lite Edition for ARM EABI" обновляет переменную
# PATH
# 3. Должна быть установлена интегрированная среда Eclipse. (у меня Juno SR1)
# 4. В среде Eclipse, должен быть установлен т.н. GNU ARM Plugin
# Далее, опциональные требования
# 5. Утилита для загрузки прошивки в память микроконтроллера
# 6. GNU Hardware debugging для Eclipse


# Сборка проекта может осуществляется простым запуском cs-make утилиты в каталоге примера
# Проект также может быть собран из интегрированной среды Eclipse
# Для этого надо создать новый проект и импортировать архив примера,
# но лучше обратиться к сопутствующей инструкции на моём сайте: 
# http://gimmor.blogspot.com/2013/03/mdr32f9q2i-arm-gnu-as-example.html
#
# Результирующие файлы, появляющиеся после сборки проекта
# mdr32gnuas.bin - двоичная форма прошивки, для загрузки в память микроконтроллера,
# утилитами, понимающими только формат потока байтов
# mdr32gnuas.hex - прошивка, в формате Intel Hex, для загрузки во Flash сторонними утилитами
# mdr32gnuas-ram.elf - форма прошивки, с отладочной информации, для отладчика gdb
# для исполнения в ОЗУ микроконтроллера Миландр MDR32F9Q2I
# mdr32gnuas-flash.elf - форма прошивки, с отладочной информацией, для отладчика gdb
# для исполнения в ПЗУ микроконтроллера Миландр MDR32F9Q2I
# mdr32gnuas.o - промежуточный объектный файл прошивки, пока нигде не нужен 
#
# "Пример моргания светодиод"
# Работа примера проверялась на отладочной плате собственной разработки - MDR32-Solo
# http://gimmor.blogspot.ru/2013/03/mdr32-solo-mdr32f9q2i.html
# Светодиод подключен к порту PA.1
# 

# all - цель для сборки прошивки, в среде Windows
all:
	@echo "Сборка проекта mdr32gnuas - простейшего примера на ассемблере GNU As..."
	@echo "Компиляция ассемблерного файла..."
	arm-none-eabi-as -mcpu=cortex-m3 -mthumb -mapcs-32 -gstabs -o mdr32gnuas.o mdr32gnuas.S
	@echo "Подготовка mdr32gnuas-ram.elf - файла, для отладки в ОЗУ микроконтроллера..."
	arm-none-eabi-ld --Ttext=0x20000000 --relax -o mdr32gnuas-ram.elf mdr32gnuas.o
	arm-none-eabi-ld --Ttext=0x08000000 --relax -o mdr32gnuas-flash.elf mdr32gnuas.o
	@echo "Подготовка прошивки в формате intel-hex... "
	arm-none-eabi-objcopy -Oihex mdr32gnuas-flash.elf mdr32gnuas.hex
	@echo "Подготовка прошивки в двоичном формате..."
	arm-none-eabi-objcopy -Obinary -j .text mdr32gnuas-flash.elf mdr32gnuas.bin
	@echo "Просмотр размера получившихся секций кода и данных..."
	arm-none-eabi-size mdr32gnuas-ram.elf
	arm-none-eabi-size mdr32gnuas-flash.elf

# clean - цель очистки сгенерированных файлов, в среде Windows
clean:
	del mdr32gnuas.o
	del mdr32gnuas-ram.elf
	del mdr32gnuas-flash.elf
	del mdr32gnuas.bin
	del mdr32gnuas.hex

	