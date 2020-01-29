From: Luca Ceresoli <luca@lucaceresoli.net>
Subject: [PATCH v3 15/28] docs: i2c: smbus-protocol: enable kernel-doc function syntax
Date: Wed, 29 Jan 2020 16:19:40 +0100
Message-ID: <20200129151953.31582-16-luca@lucaceresoli.net>
References: <20200129151953.31582-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200129151953.31582-1-luca@lucaceresoli.net>
Sender: linux-doc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Luca Ceresoli <luca@lucaceresoli.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.de>, Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


Hyperlinks from function names are not generated in headings. Move them in
the plain text so they are rendered as clickable hyperlinks.

While there also remove an unneeded colon in a heading.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
Reviewed-by: Jean Delvare <jdelvare@suse.de>

---

Changes in v2:
 - fix typo in commit message (Jean Delvare)
---
 Documentation/i2c/smbus-protocol.rst | 64 ++++++++++++++++++----------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/Documentation/i2c/smbus-protocol.rst b/Documentation/i2c/smbus-protocol.rst
index 10c4a989982c..997945e90419 100644
--- a/Documentation/i2c/smbus-protocol.rst
+++ b/Documentation/i2c/smbus-protocol.rst
@@ -62,8 +62,10 @@ This sends a single bit to the device, at the place of the Rd/Wr bit::
 Functionality flag: I2C_FUNC_SMBUS_QUICK
 
 
-SMBus Receive Byte:  i2c_smbus_read_byte()
-==========================================
+SMBus Receive Byte
+==================
+
+Implemented by i2c_smbus_read_byte()
 
 This reads a single byte from a device, without specifying a device
 register. Some devices are so simple that this interface is enough; for
@@ -75,8 +77,10 @@ the previous SMBus command::
 Functionality flag: I2C_FUNC_SMBUS_READ_BYTE
 
 
-SMBus Send Byte:  i2c_smbus_write_byte()
-========================================
+SMBus Send Byte
+===============
+
+Implemented by i2c_smbus_write_byte()
 
 This operation is the reverse of Receive Byte: it sends a single byte
 to a device.  See Receive Byte for more information.
@@ -88,8 +92,10 @@ to a device.  See Receive Byte for more information.
 Functionality flag: I2C_FUNC_SMBUS_WRITE_BYTE
 
 
-SMBus Read Byte:  i2c_smbus_read_byte_data()
-============================================
+SMBus Read Byte
+===============
+
+Implemented by i2c_smbus_read_byte_data()
 
 This reads a single byte from a device, from a designated register.
 The register is specified through the Comm byte::
@@ -99,8 +105,10 @@ The register is specified through the Comm byte::
 Functionality flag: I2C_FUNC_SMBUS_READ_BYTE_DATA
 
 
-SMBus Read Word:  i2c_smbus_read_word_data()
-============================================
+SMBus Read Word
+===============
+
+Implemented by i2c_smbus_read_word_data()
 
 This operation is very like Read Byte; again, data is read from a
 device, from a designated register that is specified through the Comm
@@ -115,8 +123,10 @@ available for reads where the two data bytes are the other way
 around (not SMBus compliant, but very popular.)
 
 
-SMBus Write Byte:  i2c_smbus_write_byte_data()
-==============================================
+SMBus Write Byte
+================
+
+Implemented by i2c_smbus_write_byte_data()
 
 This writes a single byte to a device, to a designated register. The
 register is specified through the Comm byte. This is the opposite of
@@ -129,8 +139,10 @@ the Read Byte operation.
 Functionality flag: I2C_FUNC_SMBUS_WRITE_BYTE_DATA
 
 
-SMBus Write Word:  i2c_smbus_write_word_data()
-==============================================
+SMBus Write Word
+================
+
+Implemented by i2c_smbus_write_word_data()
 
 This is the opposite of the Read Word operation. 16 bits
 of data is written to a device, to the designated register that is
@@ -145,8 +157,8 @@ available for writes where the two data bytes are the other way
 around (not SMBus compliant, but very popular.)
 
 
-SMBus Process Call:
-===================
+SMBus Process Call
+==================
 
 This command selects a device register (through the Comm byte), sends
 16 bits of data to it, and reads 16 bits of data in return::
@@ -157,8 +169,10 @@ This command selects a device register (through the Comm byte), sends
 Functionality flag: I2C_FUNC_SMBUS_PROC_CALL
 
 
-SMBus Block Read:  i2c_smbus_read_block_data()
-==============================================
+SMBus Block Read
+================
+
+Implemented by i2c_smbus_read_block_data()
 
 This command reads a block of up to 32 bytes from a device, from a
 designated register that is specified through the Comm byte. The amount
@@ -172,8 +186,10 @@ of data is specified by the device in the Count byte.
 Functionality flag: I2C_FUNC_SMBUS_READ_BLOCK_DATA
 
 
-SMBus Block Write:  i2c_smbus_write_block_data()
-================================================
+SMBus Block Write
+=================
+
+Implemented by i2c_smbus_write_block_data()
 
 The opposite of the Block Read command, this writes up to 32 bytes to
 a device, to a designated register that is specified through the
@@ -274,8 +290,10 @@ I2C block transactions do not limit the number of bytes transferred
 but the SMBus layer places a limit of 32 bytes.
 
 
-I2C Block Read:  i2c_smbus_read_i2c_block_data()
-================================================
+I2C Block Read
+==============
+
+Implemented by i2c_smbus_read_i2c_block_data()
 
 This command reads a block of bytes from a device, from a
 designated register that is specified through the Comm byte::
@@ -286,8 +304,10 @@ designated register that is specified through the Comm byte::
 Functionality flag: I2C_FUNC_SMBUS_READ_I2C_BLOCK
 
 
-I2C Block Write:  i2c_smbus_write_i2c_block_data()
-==================================================
+I2C Block Write
+===============
+
+Implemented by i2c_smbus_write_i2c_block_data()
 
 The opposite of the Block Read command, this writes bytes to
 a device, to a designated register that is specified through the
-- 
2.25.0
