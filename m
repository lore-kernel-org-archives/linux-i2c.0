From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Move misc devices documentation
Date: Sun, 20 Sep 2009 11:37:17 +0200
Message-ID: <20090920113717.5a763d24@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Some times ago the eeprom and max6875 drivers moved to
drivers/misc/eeprom, but their documentation did not follow. It's
finally time to get rid of Documentation/i2c/chips.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Ben Gardner <gardner.ben-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 Documentation/i2c/chips/eeprom     |   96 --------------------------------
 Documentation/i2c/chips/max6875    |  108 ------------------------------------
 Documentation/misc-devices/eeprom  |   96 ++++++++++++++++++++++++++++++++
 Documentation/misc-devices/max6875 |  108 ++++++++++++++++++++++++++++++++++++
 4 files changed, 204 insertions(+), 204 deletions(-)

--- linux-2.6.32-pre.orig/Documentation/i2c/chips/eeprom	2009-06-10 05:05:27.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,96 +0,0 @@
-Kernel driver eeprom
-====================
-
-Supported chips:
-  * Any EEPROM chip in the designated address range
-    Prefix: 'eeprom'
-    Addresses scanned: I2C 0x50 - 0x57
-    Datasheets: Publicly available from:
-                Atmel (www.atmel.com),
-                Catalyst (www.catsemi.com),
-                Fairchild (www.fairchildsemi.com),
-                Microchip (www.microchip.com),
-                Philips (www.semiconductor.philips.com),
-                Rohm (www.rohm.com),
-                ST (www.st.com),
-                Xicor (www.xicor.com),
-                and others.
-
-        Chip     Size (bits)    Address
-        24C01     1K            0x50 (shadows at 0x51 - 0x57)
-        24C01A    1K            0x50 - 0x57 (Typical device on DIMMs)
-        24C02     2K            0x50 - 0x57
-        24C04     4K            0x50, 0x52, 0x54, 0x56
-                                (additional data at 0x51, 0x53, 0x55, 0x57)
-        24C08     8K            0x50, 0x54 (additional data at 0x51, 0x52,
-                                0x53, 0x55, 0x56, 0x57)
-        24C16    16K            0x50 (additional data at 0x51 - 0x57)
-        Sony      2K            0x57
-
-        Atmel     34C02B  2K    0x50 - 0x57, SW write protect at 0x30-37
-        Catalyst  34FC02  2K    0x50 - 0x57, SW write protect at 0x30-37
-        Catalyst  34RC02  2K    0x50 - 0x57, SW write protect at 0x30-37
-        Fairchild 34W02   2K    0x50 - 0x57, SW write protect at 0x30-37
-        Microchip 24AA52  2K    0x50 - 0x57, SW write protect at 0x30-37
-        ST        M34C02  2K    0x50 - 0x57, SW write protect at 0x30-37
-
-
-Authors:
-        Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
-        Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
-        Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
-        Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>,
-        IBM Corp.
-
-Description
------------
-
-This is a simple EEPROM module meant to enable reading the first 256 bytes
-of an EEPROM (on a SDRAM DIMM for example). However, it will access serial
-EEPROMs on any I2C adapter. The supported devices are generically called
-24Cxx, and are listed above; however the numbering for these
-industry-standard devices may vary by manufacturer.
-
-This module was a programming exercise to get used to the new project
-organization laid out by Frodo, but it should be at least completely
-effective for decoding the contents of EEPROMs on DIMMs.
-
-DIMMS will typically contain a 24C01A or 24C02, or the 34C02 variants.
-The other devices will not be found on a DIMM because they respond to more
-than one address.
-
-DDC Monitors may contain any device. Often a 24C01, which responds to all 8
-addresses, is found.
-
-Recent Sony Vaio laptops have an EEPROM at 0x57. We couldn't get the
-specification, so it is guess work and far from being complete.
-
-The Microchip 24AA52/24LCS52, ST M34C02, and others support an additional
-software write protect register at 0x30 - 0x37 (0x20 less than the memory
-location). The chip responds to "write quick" detection at this address but
-does not respond to byte reads. If this register is present, the lower 128
-bytes of the memory array are not write protected. Any byte data write to
-this address will write protect the memory array permanently, and the
-device will no longer respond at the 0x30-37 address. The eeprom driver
-does not support this register.
-
-Lacking functionality:
-
-* Full support for larger devices (24C04, 24C08, 24C16). These are not
-typically found on a PC. These devices will appear as separate devices at
-multiple addresses.
-
-* Support for really large devices (24C32, 24C64, 24C128, 24C256, 24C512).
-These devices require two-byte address fields and are not supported.
-
-* Enable Writing. Again, no technical reason why not, but making it easy
-to change the contents of the EEPROMs (on DIMMs anyway) also makes it easy
-to disable the DIMMs (potentially preventing the computer from booting)
-until the values are restored somehow.
-
-Use:
-
-After inserting the module (and any other required SMBus/i2c modules), you
-should have some EEPROM directories in /sys/bus/i2c/devices/* of names such
-as "0-0050". Inside each of these is a series of files, the eeprom file
-contains the binary data from EEPROM.
--- linux-2.6.32-pre.orig/Documentation/i2c/chips/max6875	2009-06-10 05:05:27.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,108 +0,0 @@
-Kernel driver max6875
-=====================
-
-Supported chips:
-  * Maxim MAX6874, MAX6875
-    Prefix: 'max6875'
-    Addresses scanned: None (see below)
-    Datasheet:
-        http://pdfserv.maxim-ic.com/en/ds/MAX6874-MAX6875.pdf
-
-Author: Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
-
-
-Description
------------
-
-The Maxim MAX6875 is an EEPROM-programmable power-supply sequencer/supervisor.
-It provides timed outputs that can be used as a watchdog, if properly wired.
-It also provides 512 bytes of user EEPROM.
-
-At reset, the MAX6875 reads the configuration EEPROM into its configuration
-registers.  The chip then begins to operate according to the values in the
-registers.
-
-The Maxim MAX6874 is a similar, mostly compatible device, with more intputs
-and outputs:
-             vin     gpi    vout
-MAX6874        6       4       8
-MAX6875        4       3       5
-
-See the datasheet for more information.
-
-
-Sysfs entries
--------------
-
-eeprom        - 512 bytes of user-defined EEPROM space.
-
-
-General Remarks
----------------
-
-Valid addresses for the MAX6875 are 0x50 and 0x52.
-Valid addresses for the MAX6874 are 0x50, 0x52, 0x54 and 0x56.
-The driver does not probe any address, so you must force the address.
-
-Example:
-$ modprobe max6875 force=0,0x50
-
-The MAX6874/MAX6875 ignores address bit 0, so this driver attaches to multiple
-addresses.  For example, for address 0x50, it also reserves 0x51.
-The even-address instance is called 'max6875', the odd one is 'dummy'.
-
-
-Programming the chip using i2c-dev
-----------------------------------
-
-Use the i2c-dev interface to access and program the chips.
-Reads and writes are performed differently depending on the address range.
-
-The configuration registers are at addresses 0x00 - 0x45.
-Use i2c_smbus_write_byte_data() to write a register and
-i2c_smbus_read_byte_data() to read a register.
-The command is the register number.
-
-Examples:
-To write a 1 to register 0x45:
-  i2c_smbus_write_byte_data(fd, 0x45, 1);
-
-To read register 0x45:
-  value = i2c_smbus_read_byte_data(fd, 0x45);
-
-
-The configuration EEPROM is at addresses 0x8000 - 0x8045.
-The user EEPROM is at addresses 0x8100 - 0x82ff.
-
-Use i2c_smbus_write_word_data() to write a byte to EEPROM.
-
-The command is the upper byte of the address: 0x80, 0x81, or 0x82.
-The data word is the lower part of the address or'd with data << 8.
-  cmd = address >> 8;
-  val = (address & 0xff) | (data << 8);
-
-Example:
-To write 0x5a to address 0x8003:
-  i2c_smbus_write_word_data(fd, 0x80, 0x5a03);
-
-
-Reading data from the EEPROM is a little more complicated.
-Use i2c_smbus_write_byte_data() to set the read address and then
-i2c_smbus_read_byte() or i2c_smbus_read_i2c_block_data() to read the data.
-
-Example:
-To read data starting at offset 0x8100, first set the address:
-  i2c_smbus_write_byte_data(fd, 0x81, 0x00);
-
-And then read the data
-  value = i2c_smbus_read_byte(fd);
-
-  or
-
-  count = i2c_smbus_read_i2c_block_data(fd, 0x84, 16, buffer);
-
-The block read should read 16 bytes.
-0x84 is the block read command.
-
-See the datasheet for more details.
-
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.32-pre/Documentation/misc-devices/eeprom	2009-06-10 05:05:27.000000000 +0200
@@ -0,0 +1,96 @@
+Kernel driver eeprom
+====================
+
+Supported chips:
+  * Any EEPROM chip in the designated address range
+    Prefix: 'eeprom'
+    Addresses scanned: I2C 0x50 - 0x57
+    Datasheets: Publicly available from:
+                Atmel (www.atmel.com),
+                Catalyst (www.catsemi.com),
+                Fairchild (www.fairchildsemi.com),
+                Microchip (www.microchip.com),
+                Philips (www.semiconductor.philips.com),
+                Rohm (www.rohm.com),
+                ST (www.st.com),
+                Xicor (www.xicor.com),
+                and others.
+
+        Chip     Size (bits)    Address
+        24C01     1K            0x50 (shadows at 0x51 - 0x57)
+        24C01A    1K            0x50 - 0x57 (Typical device on DIMMs)
+        24C02     2K            0x50 - 0x57
+        24C04     4K            0x50, 0x52, 0x54, 0x56
+                                (additional data at 0x51, 0x53, 0x55, 0x57)
+        24C08     8K            0x50, 0x54 (additional data at 0x51, 0x52,
+                                0x53, 0x55, 0x56, 0x57)
+        24C16    16K            0x50 (additional data at 0x51 - 0x57)
+        Sony      2K            0x57
+
+        Atmel     34C02B  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Catalyst  34FC02  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Catalyst  34RC02  2K    0x50 - 0x57, SW write protect at 0x30-37
+        Fairchild 34W02   2K    0x50 - 0x57, SW write protect at 0x30-37
+        Microchip 24AA52  2K    0x50 - 0x57, SW write protect at 0x30-37
+        ST        M34C02  2K    0x50 - 0x57, SW write protect at 0x30-37
+
+
+Authors:
+        Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>,
+        Philip Edelbrock <phil-KXOFo5pg7o1l57MIdRCFDg@public.gmane.org>,
+        Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>,
+        Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>,
+        IBM Corp.
+
+Description
+-----------
+
+This is a simple EEPROM module meant to enable reading the first 256 bytes
+of an EEPROM (on a SDRAM DIMM for example). However, it will access serial
+EEPROMs on any I2C adapter. The supported devices are generically called
+24Cxx, and are listed above; however the numbering for these
+industry-standard devices may vary by manufacturer.
+
+This module was a programming exercise to get used to the new project
+organization laid out by Frodo, but it should be at least completely
+effective for decoding the contents of EEPROMs on DIMMs.
+
+DIMMS will typically contain a 24C01A or 24C02, or the 34C02 variants.
+The other devices will not be found on a DIMM because they respond to more
+than one address.
+
+DDC Monitors may contain any device. Often a 24C01, which responds to all 8
+addresses, is found.
+
+Recent Sony Vaio laptops have an EEPROM at 0x57. We couldn't get the
+specification, so it is guess work and far from being complete.
+
+The Microchip 24AA52/24LCS52, ST M34C02, and others support an additional
+software write protect register at 0x30 - 0x37 (0x20 less than the memory
+location). The chip responds to "write quick" detection at this address but
+does not respond to byte reads. If this register is present, the lower 128
+bytes of the memory array are not write protected. Any byte data write to
+this address will write protect the memory array permanently, and the
+device will no longer respond at the 0x30-37 address. The eeprom driver
+does not support this register.
+
+Lacking functionality:
+
+* Full support for larger devices (24C04, 24C08, 24C16). These are not
+typically found on a PC. These devices will appear as separate devices at
+multiple addresses.
+
+* Support for really large devices (24C32, 24C64, 24C128, 24C256, 24C512).
+These devices require two-byte address fields and are not supported.
+
+* Enable Writing. Again, no technical reason why not, but making it easy
+to change the contents of the EEPROMs (on DIMMs anyway) also makes it easy
+to disable the DIMMs (potentially preventing the computer from booting)
+until the values are restored somehow.
+
+Use:
+
+After inserting the module (and any other required SMBus/i2c modules), you
+should have some EEPROM directories in /sys/bus/i2c/devices/* of names such
+as "0-0050". Inside each of these is a series of files, the eeprom file
+contains the binary data from EEPROM.
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.32-pre/Documentation/misc-devices/max6875	2009-06-10 05:05:27.000000000 +0200
@@ -0,0 +1,108 @@
+Kernel driver max6875
+=====================
+
+Supported chips:
+  * Maxim MAX6874, MAX6875
+    Prefix: 'max6875'
+    Addresses scanned: None (see below)
+    Datasheet:
+        http://pdfserv.maxim-ic.com/en/ds/MAX6874-MAX6875.pdf
+
+Author: Ben Gardner <bgardner-ohtLXRgXiI/QT0dZR+AlfA@public.gmane.org>
+
+
+Description
+-----------
+
+The Maxim MAX6875 is an EEPROM-programmable power-supply sequencer/supervisor.
+It provides timed outputs that can be used as a watchdog, if properly wired.
+It also provides 512 bytes of user EEPROM.
+
+At reset, the MAX6875 reads the configuration EEPROM into its configuration
+registers.  The chip then begins to operate according to the values in the
+registers.
+
+The Maxim MAX6874 is a similar, mostly compatible device, with more intputs
+and outputs:
+             vin     gpi    vout
+MAX6874        6       4       8
+MAX6875        4       3       5
+
+See the datasheet for more information.
+
+
+Sysfs entries
+-------------
+
+eeprom        - 512 bytes of user-defined EEPROM space.
+
+
+General Remarks
+---------------
+
+Valid addresses for the MAX6875 are 0x50 and 0x52.
+Valid addresses for the MAX6874 are 0x50, 0x52, 0x54 and 0x56.
+The driver does not probe any address, so you must force the address.
+
+Example:
+$ modprobe max6875 force=0,0x50
+
+The MAX6874/MAX6875 ignores address bit 0, so this driver attaches to multiple
+addresses.  For example, for address 0x50, it also reserves 0x51.
+The even-address instance is called 'max6875', the odd one is 'dummy'.
+
+
+Programming the chip using i2c-dev
+----------------------------------
+
+Use the i2c-dev interface to access and program the chips.
+Reads and writes are performed differently depending on the address range.
+
+The configuration registers are at addresses 0x00 - 0x45.
+Use i2c_smbus_write_byte_data() to write a register and
+i2c_smbus_read_byte_data() to read a register.
+The command is the register number.
+
+Examples:
+To write a 1 to register 0x45:
+  i2c_smbus_write_byte_data(fd, 0x45, 1);
+
+To read register 0x45:
+  value = i2c_smbus_read_byte_data(fd, 0x45);
+
+
+The configuration EEPROM is at addresses 0x8000 - 0x8045.
+The user EEPROM is at addresses 0x8100 - 0x82ff.
+
+Use i2c_smbus_write_word_data() to write a byte to EEPROM.
+
+The command is the upper byte of the address: 0x80, 0x81, or 0x82.
+The data word is the lower part of the address or'd with data << 8.
+  cmd = address >> 8;
+  val = (address & 0xff) | (data << 8);
+
+Example:
+To write 0x5a to address 0x8003:
+  i2c_smbus_write_word_data(fd, 0x80, 0x5a03);
+
+
+Reading data from the EEPROM is a little more complicated.
+Use i2c_smbus_write_byte_data() to set the read address and then
+i2c_smbus_read_byte() or i2c_smbus_read_i2c_block_data() to read the data.
+
+Example:
+To read data starting at offset 0x8100, first set the address:
+  i2c_smbus_write_byte_data(fd, 0x81, 0x00);
+
+And then read the data
+  value = i2c_smbus_read_byte(fd);
+
+  or
+
+  count = i2c_smbus_read_i2c_block_data(fd, 0x84, 16, buffer);
+
+The block read should read 16 bytes.
+0x84 is the block read command.
+
+See the datasheet for more details.
+


-- 
Jean Delvare
