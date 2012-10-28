From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Mention functionality flags in SMBus protocol
 documentation
Date: Sun, 28 Oct 2012 18:55:27 +0100
Message-ID: <20121028185527.5745796f@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Frank =?ISO-8859-1?B?U2No5GZlcg==?= <fschaefer.oss-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

While the mapping between I2C adapter functionality flags and
i2c_smbus_*() helper functions is rather obvious, let's still document
it for clarity.

Also drop the reference to 2 command byte I2C block reads, there is no
support for that in the kernel at the moment.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 Documentation/i2c/smbus-protocol |   40 +++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

--- linux-3.7-rc2.orig/Documentation/i2c/smbus-protocol	2012-10-20 21:11:32.000000000 +0200
+++ linux-3.7-rc2/Documentation/i2c/smbus-protocol	2012-10-28 16:28:49.230699452 +0100
@@ -23,6 +23,12 @@ don't match these function names.  For s
 single data byte, the functions using SMBus protocol operation names execute
 a different protocol operation entirely.
 
+Each transaction type corresponds to a functionality flag. Before calling a
+transaction function, a device driver should always check (just once) for
+the corresponding functionality flag to ensure that the underlying I2C
+adapter supports the transaction in question. See
+<file:Documentation/i2c/functionality> for the details.
+
 
 Key to symbols
 ==============
@@ -49,6 +55,8 @@ This sends a single bit to the device, a
 
 A Addr Rd/Wr [A] P
 
+Functionality flag: I2C_FUNC_SMBUS_QUICK
+
 
 SMBus Receive Byte:  i2c_smbus_read_byte()
 ==========================================
@@ -60,6 +68,8 @@ the previous SMBus command.
 
 S Addr Rd [A] [Data] NA P
 
+Functionality flag: I2C_FUNC_SMBUS_READ_BYTE
+
 
 SMBus Send Byte:  i2c_smbus_write_byte()
 ========================================
@@ -69,6 +79,8 @@ to a device.  See Receive Byte for more
 
 S Addr Wr [A] Data [A] P
 
+Functionality flag: I2C_FUNC_SMBUS_WRITE_BYTE
+
 
 SMBus Read Byte:  i2c_smbus_read_byte_data()
 ============================================
@@ -78,6 +90,8 @@ The register is specified through the Co
 
 S Addr Wr [A] Comm [A] S Addr Rd [A] [Data] NA P
 
+Functionality flag: I2C_FUNC_SMBUS_READ_BYTE_DATA
+
 
 SMBus Read Word:  i2c_smbus_read_word_data()
 ============================================
@@ -88,6 +102,8 @@ byte. But this time, the data is a compl
 
 S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA P
 
+Functionality flag: I2C_FUNC_SMBUS_READ_WORD_DATA
+
 Note the convenience function i2c_smbus_read_word_swapped is
 available for reads where the two data bytes are the other way
 around (not SMBus compliant, but very popular.)
@@ -102,6 +118,8 @@ the Read Byte operation.
 
 S Addr Wr [A] Comm [A] Data [A] P
 
+Functionality flag: I2C_FUNC_SMBUS_WRITE_BYTE_DATA
+
 
 SMBus Write Word:  i2c_smbus_write_word_data()
 ==============================================
@@ -112,6 +130,8 @@ specified through the Comm byte.
 
 S Addr Wr [A] Comm [A] DataLow [A] DataHigh [A] P
 
+Functionality flag: I2C_FUNC_SMBUS_WRITE_WORD_DATA
+
 Note the convenience function i2c_smbus_write_word_swapped is
 available for writes where the two data bytes are the other way
 around (not SMBus compliant, but very popular.)
@@ -126,6 +146,8 @@ This command selects a device register (
 S Addr Wr [A] Comm [A] DataLow [A] DataHigh [A] 
                              S Addr Rd [A] [DataLow] A [DataHigh] NA P
 
+Functionality flag: I2C_FUNC_SMBUS_PROC_CALL
+
 
 SMBus Block Read:  i2c_smbus_read_block_data()
 ==============================================
@@ -137,6 +159,8 @@ of data is specified by the device in th
 S Addr Wr [A] Comm [A] 
            S Addr Rd [A] [Count] A [Data] A [Data] A ... A [Data] NA P
 
+Functionality flag: I2C_FUNC_SMBUS_READ_BLOCK_DATA
+
 
 SMBus Block Write:  i2c_smbus_write_block_data()
 ================================================
@@ -147,6 +171,8 @@ Comm byte. The amount of data is specifi
 
 S Addr Wr [A] Comm [A] Count [A] Data [A] Data [A] ... [A] Data [A] P
 
+Functionality flag: I2C_FUNC_SMBUS_WRITE_BLOCK_DATA
+
 
 SMBus Block Write - Block Read Process Call
 ===========================================
@@ -160,6 +186,8 @@ This command selects a device register (
 S Addr Wr [A] Comm [A] Count [A] Data [A] ...
                              S Addr Rd [A] [Count] A [Data] ... A P
 
+Functionality flag: I2C_FUNC_SMBUS_BLOCK_PROC_CALL
+
 
 SMBus Host Notify
 =================
@@ -229,15 +257,7 @@ designated register that is specified th
 S Addr Wr [A] Comm [A] 
            S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
 
-
-I2C Block Read (2 Comm bytes)
-=============================
-
-This command reads a block of bytes from a device, from a 
-designated register that is specified through the two Comm bytes.
-
-S Addr Wr [A] Comm1 [A] Comm2 [A] 
-           S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
+Functionality flag: I2C_FUNC_SMBUS_READ_I2C_BLOCK
 
 
 I2C Block Write:  i2c_smbus_write_i2c_block_data()
@@ -249,3 +269,5 @@ Comm byte. Note that command lengths of
 supported as they are indistinguishable from data.
 
 S Addr Wr [A] Comm [A] Data [A] Data [A] ... [A] Data [A] P
+
+Functionality flag: I2C_FUNC_SMBUS_WRITE_I2C_BLOCK


-- 
Jean Delvare
