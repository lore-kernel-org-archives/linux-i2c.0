From: Diagon <kernel.org@niwas.net>
Subject: decode-dimms - multiple similar machines, same memory module,
 different/odd results.
Date: Mon, 01 Jan 2018 05:20:34 -0800
Message-ID: <160b1e184b5.f681108248046.419146565341060016@niwas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sender-pp-093.zoho.com ([135.84.80.238]:25736 "EHLO
        sender-pp-093.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeAANfl (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Mon, 1 Jan 2018 08:35:41 -0500
In-Reply-To: 
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c <linux-i2c@vger.kernel.org>

I'm getting some odd results using decode-dimms that I've been discussing on thinkpads.com.  Perhaps someone here can give me an idea of how to understand this?

I have a collection of machines (two T500s, W500, T520) some of which have been presenting odd results in memtest86{,+}.  The exact same known-good module is producing no errors, but a freeze in the test routines, specifically on "[Modulo 20, Random Pattern]".  Despite this, they seem to run OSs without difficulty.  In particular, no lockups.  

So I was encouraged to check the SPD data.  Running decode-dimms on each of those machines with that same module and booting from the same USB (Ubuntu 17.10 & i2c-tools v.3.1.2-3build2) produces contradictory results.  Apparently correct in the case of the T520.  Bad, but different, checksums and even different number of modules from the {T,W}500's.  It is unlikely that the problem is all of these machines.  In particular the W500 is basically unused.

It may not be a decode-dimms problem, but I thought someone might be able to give me a clue.

Thank in advance - /D

*******
T500* - This machine does not lock up on memtest86+
*******

Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/2-0050
Guessing DIMM is in                             bank 1

---=== SPD EEPROM Information ===---
EEPROM Checksum of bytes 0-62                   Bad      **Notice it's checking 63 bytes**
                                                (found 0x40, calculated 0x93)
SPD Revision                                    Invalid
Fundamental Memory type                         Unknown (0xff)

---=== Manufacturing Information ===---
Manufacturer                                    Conexant (Rockwell)
Custom Manufacturer Data                        00 4B CF 10 00 00 19 ("?K?????")
Manufacturing Location Code                     0xB7
Part Number                                     '
Manufacturing Date                              0x0F00
Assembly Serial Number                          0xB30A32B3

Number of SDRAM DIMMs detected and decoded: 1


*******
W500* - this machine does lock up on memtest86+
*******

Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/2-0050
Guessing DIMM is in                             bank 1

---=== SPD EEPROM Information ===---
EEPROM Checksum of bytes 0-62                   Bad      **Again, it's checking 63 bytes, but ...**
                                                (found 0x50, calculated 0xDA)
SPD Revision                                    Invalid
Fundamental Memory type                         Unknown (0xff)

---=== Manufacturing Information ===---
Manufacturer                                    Invalid
Custom Manufacturer Data                        24 00 4B CF 10 00 00 19 ("$?K?????")
Manufacturing Location Code                     0x16
Part Number                                     1
Manufacturing Date                              0x0F00
Assembly Serial Number                          0xD10A32D1


Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/5-0050
Guessing DIMM is in                             bank 1

---=== SPD EEPROM Information ===---
EEPROM CRC of bytes 0-116                       Bad      **Here it's checking 117 bytes**
                                                (found 0xFFFF, calculated 0x4FE6)
# of bytes written to SDRAM EEPROM              64
Total number of bytes in EEPROM                 64
Fundamental Memory type                         Unknown (0xff)

---=== Manufacturing Information ===---
Manufacturer                                    Undefined
Part Number                                     Undefined

Number of SDRAM DIMMs detected and decoded: 2


*******
T520* - this machine tests perfectly on memtest86+
*******

Decoding EEPROM: /sys/bus/i2c/drivers/eeprom/21-0050
Guessing DIMM is in                             bank 1

---=== SPD EEPROM Information ===---
EEPROM CRC of bytes 0-116                       OK (0xD173)      **Here it's also checking 117 bytes***
# of bytes written to SDRAM EEPROM              176
Total number of bytes in EEPROM                 256
Fundamental Memory type                         DDR3 SDRAM
Module Type                                     SO-DIMM

---=== Memory Characteristics ===---
Fine time base                                  2.500 ps
Medium time base                                0.125 ns
Maximum module speed                            1600 MHz (PC3-12800)
Size                                            4096 MB
Banks x Rows x Columns x Bits                   8 x 15 x 10 x 64
Ranks                                           2
SDRAM Device Width                              8 bits
Bus Width Extension                             0 bits
tCL-tRCD-tRP-tRAS                               11-11-11-28
Supported CAS Latencies (tCL)                   11T, 10T, 9T, 8T, 7T, 6T, 5T

---=== Timing Parameters ===---
Minimum Write Recovery time (tWR)               15.000 ns
Minimum Row Active to Row Active Delay (tRRD)   6.000 ns
Minimum Active to Auto-Refresh Delay (tRC)      48.125 ns
Minimum Recovery Delay (tRFC)                   160.000 ns
Minimum Write to Read CMD Delay (tWTR)          7.500 ns
Minimum Read to Pre-charge CMD Delay (tRTP)     7.500 ns
Minimum Four Activate Window Delay (tFAW)       30.000 ns

---=== Optional Features ===---
Operable voltages                               1.5V
RZQ/6 supported?                                Yes
RZQ/7 supported?                                Yes
DLL-Off Mode supported?                         Yes
Operating temperature range                     0-95 degrees C
Refresh Rate in extended temp range             2X
Auto Self-Refresh?                              No
On-Die Thermal Sensor readout?                  No
Partial Array Self-Refresh?                     No
Thermal Sensor Accuracy                         Not implemented
SDRAM Device Type                               Standard Monolithic

---=== Physical Characteristics ===---
Module Height (mm)                              30
Module Thickness (mm)                           2 front, 2 back
Module Width (mm)                               67.6
Module Reference Card                           F

---=== Manufacturer Data ===---
Module Manufacturer                             SK Hynix (former Hyundai Electronics)
DRAM Manufacturer                               SK Hynix (former Hyundai Electronics)
Manufacturing Location Code                     0x01
Manufacturing Date                              2013-W32
Assembly Serial Number                          0x1081FDE9
Part Number                                     HMT351S6EFR8C-PB
Revision Code                                   0x4E30

Number of SDRAM DIMMs detected and decoded: 1
