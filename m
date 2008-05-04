From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: [patch 2.6.25-rc1] i2c: improve smbus-protocol documentation
Date: Sat, 3 May 2008 17:50:33 -0700
Message-ID: <200805031750.34306.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Improve the smbus-protocol documentation file somewhat:

 - Use the names of the SMBus protocol operations (from the 2.0
   specification), not made-up-for-Linux names.

 - Add the name of the call used to execute each operation ... and
   point out that there are mismatches, where functions execute
   different protocol operations than their names specify.
   
The most confusing examples are that "Read Byte" isn't executed by
i2c_smbus_read_byte(), and that "Write Byte" isn't executed by
i2c_smbus_write_byte().  When coding, that's not as bad as it may
seem; but that case would seem to be worth fixing.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
As doc-only, this is appropriate for bundling with any I2C fixes
before the 2.6.26-final code freeze.  Note that this doesn't address
the confusion between "command" and "register" in this text, though
in some cases it reduces confusion between "command" and "protocol
operation" or "function call".

 Documentation/i2c/smbus-protocol |   75 +++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 33 deletions(-)

--- g26.orig/Documentation/i2c/smbus-protocol	2008-05-03 15:44:04.000000000 -0700
+++ g26/Documentation/i2c/smbus-protocol	2008-05-03 17:48:09.000000000 -0700
@@ -8,6 +8,7 @@ this package are briefly described at th
 Some adapters understand only the SMBus (System Management Bus) protocol,
 which is a subset from the I2C protocol. Fortunately, many devices use
 only the same subset, which makes it possible to put them on an SMBus.
+
 If you write a driver for some I2C device, please try to use the SMBus
 commands if at all possible (if the device uses only that subset of the
 I2C protocol). This makes it possible to use the device driver on both
@@ -15,7 +16,12 @@ SMBus adapters and I2C adapters (the SMB
 translated to I2C on I2C adapters, but plain I2C commands can not be
 handled at all on most pure SMBus adapters).
 
-Below is a list of SMBus commands.
+Below is a list of SMBus protocol operations, and the functions executing
+them.  Note that the names used in the SMBus protocol specifications usually
+don't match these function names.  For some of the operations which pass a
+single data byte, the functions using SMBus protocol operation names execute
+a different protocol operation entirely.
+
 
 Key to symbols
 ==============
@@ -35,17 +41,16 @@ Count (8 bits): A data byte containing t
 [..]: Data sent by I2C device, as opposed to data sent by the host adapter.
 
 
-SMBus Write Quick
-=================
+SMBus Quick Command:  i2c_smbus_write_quick()
+=============================================
 
 This sends a single bit to the device, at the place of the Rd/Wr bit.
-There is no equivalent Read Quick command.
 
 A Addr Rd/Wr [A] P
 
 
-SMBus Read Byte
-===============
+SMBus Receive Byte:  i2c_smbus_read_byte()
+==========================================
 
 This reads a single byte from a device, without specifying a device
 register. Some devices are so simple that this interface is enough; for
@@ -55,17 +60,17 @@ the previous SMBus command.
 S Addr Rd [A] [Data] NA P
 
 
-SMBus Write Byte
-================
+SMBus Send Byte:  i2c_smbus_write_byte()
+========================================
 
-This is the reverse of Read Byte: it sends a single byte to a device.
-See Read Byte for more information.
+This operation is the reverse of Receive Byte: it sends a single byte
+to a device.  See Receive Byte for more information.
 
 S Addr Wr [A] Data [A] P
 
 
-SMBus Read Byte Data
-====================
+SMBus Read Byte:  i2c_smbus_read_byte_data()
+============================================
 
 This reads a single byte from a device, from a designated register.
 The register is specified through the Comm byte.
@@ -73,30 +78,30 @@ The register is specified through the Co
 S Addr Wr [A] Comm [A] S Addr Rd [A] [Data] NA P
 
 
-SMBus Read Word Data
-====================
+SMBus Read Word:  i2c_smbus_read_word_data()
+============================================
 
-This command is very like Read Byte Data; again, data is read from a
+This operation is very like Read Byte; again, data is read from a
 device, from a designated register that is specified through the Comm
 byte. But this time, the data is a complete word (16 bits).
 
 S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA P
 
 
-SMBus Write Byte Data
-=====================
+SMBus Write Byte:  i2c_smbus_write_byte_data()
+==============================================
 
 This writes a single byte to a device, to a designated register. The
 register is specified through the Comm byte. This is the opposite of
-the Read Byte Data command.
+the Read Byte operation.
 
 S Addr Wr [A] Comm [A] Data [A] P
 
 
-SMBus Write Word Data
-=====================
+SMBus Write Word:  i2c_smbus_write_word_data()
+==============================================
 
-This is the opposite operation of the Read Word Data command. 16 bits
+This is the opposite of the Read Word operation. 16 bits
 of data is written to a device, to the designated register that is
 specified through the Comm byte. 
 
@@ -113,8 +118,8 @@ S Addr Wr [A] Comm [A] DataLow [A] DataH
                              S Addr Rd [A] [DataLow] A [DataHigh] NA P
 
 
-SMBus Block Read
-================
+SMBus Block Read:  i2c_smbus_read_block_data()
+==============================================
 
 This command reads a block of up to 32 bytes from a device, from a 
 designated register that is specified through the Comm byte. The amount
@@ -124,8 +129,8 @@ S Addr Wr [A] Comm [A] 
            S Addr Rd [A] [Count] A [Data] A [Data] A ... A [Data] NA P
 
 
-SMBus Block Write
-=================
+SMBus Block Write:  i2c_smbus_write_block_data()
+================================================
 
 The opposite of the Block Read command, this writes up to 32 bytes to 
 a device, to a designated register that is specified through the
@@ -134,10 +139,11 @@ Comm byte. The amount of data is specifi
 S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] P
 
 
-SMBus Block Process Call
-========================
+SMBus Block Write - Block Read Process Call
+===========================================
 
-SMBus Block Process Call was introduced in Revision 2.0 of the specification.
+SMBus Block Write - Block Read Process Call was introduced in
+Revision 2.0 of the specification.
 
 This command selects a device register (through the Comm byte), sends
 1 to 31 bytes of data to it, and reads 1 to 31 bytes of data in return.
@@ -161,7 +167,8 @@ Packet Error Checking (PEC)
 ===========================
 Packet Error Checking was introduced in Revision 1.1 of the specification.
 
-PEC adds a CRC-8 error-checking byte to all transfers.
+PEC adds a CRC-8 error-checking byte to transfers using it, immediately
+before the terminating STOP.
 
 
 Address Resolution Protocol (ARP)
@@ -179,12 +186,14 @@ I2C Block Transactions
 ======================
 The following I2C block transactions are supported by the
 SMBus layer and are described here for completeness.
+They are *NOT* defined by the SMBus specification.
+
 I2C block transactions do not limit the number of bytes transferred
 but the SMBus layer places a limit of 32 bytes.
 
 
-I2C Block Read
-==============
+I2C Block Read:  i2c_smbus_read_i2c_block_data()
+================================================
 
 This command reads a block of bytes from a device, from a 
 designated register that is specified through the Comm byte.
@@ -203,8 +212,8 @@ S Addr Wr [A] Comm1 [A] Comm2 [A] 
            S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
 
 
-I2C Block Write
-===============
+I2C Block Write:  i2c_smbus_write_i2c_block_data()
+==================================================
 
 The opposite of the Block Read command, this writes bytes to 
 a device, to a designated register that is specified through the

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
