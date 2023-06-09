# Makefile for Weather Station
# Author: Fabrice Renard
# Date: 12/05/2023

MCU = atmega328p
PROJECTNAME = test
TARGET = $(wildcard *.cpp)

CXX = avr-g++
CXXFLAGS = -Os -DF_CPU=16000000UL -mmcu=$(MCU)

AVRDUDE = avrdude
AVRDUDE_PROGRAMMER = arduino
AVRDUDE_PORT = /dev/ttyACM0

INSTALL_CMD = $(AVRDUDE) -p $(MCU) -c $(AVRDUDE_PROGRAMMER) -P $(AVRDUDE_PORT) -U flash:w:$(PROJECTNAME).hex:i

.PHONY: all install clean
all:
	$(CXX) $(CXXFLAGS) -c -o $(PROJECTNAME).o $(TARGET)
	$(CXX) $(CXXFLAGS) -o $(PROJECTNAME).elf $(PROJECTNAME).o
	avr-objcopy -O ihex -R .eeprom $(PROJECTNAME).elf $(PROJECTNAME).hex

install:
	$(INSTALL_CMD)

clean:
	rm -f $(PROJECTNAME).o $(PROJECTNAME).elf $(PROJECTNAME).hex
