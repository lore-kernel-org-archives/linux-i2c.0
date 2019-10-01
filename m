From: Patrick Williams <alpawi@amazon.com>
Subject: [PATCH 2/2] i2c: slave-eeprom: support additional models
Date: Tue, 1 Oct 2019 11:40:06 -0500
Message-ID: <20191001164009.21610-2-alpawi@amazon.com>
References: <20191001164009.21610-1-alpawi@amazon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001164009.21610-1-alpawi@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20Ard=C3=B6?= <bjorn.ardo@axis.com>, Patrick Williams <alpawi@amazon.com>, Patrick Williams <patrick@stwcx.xyz>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Add support for emulating the following EEPROMs:
    * 24c01  - 1024 bit
    * 24c128 - 128k bit
    * 24c256 - 256k bit
    * 24c512 - 512k bit

The flag bits in the device id were shifted up 1 bit to make
room for saving the 24c512's size.  24c512 uses the full 16-bit
address space of a 2-byte addressable EEPROM.

Signed-off-by: Patrick Williams <alpawi@amazon.com>
---
 drivers/i2c/i2c-slave-eeprom.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index efee56106251..65419441313b 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -37,9 +37,9 @@ struct eeprom_data {
 	u8 buffer[];
 };
 
-#define I2C_SLAVE_BYTELEN GENMASK(15, 0)
-#define I2C_SLAVE_FLAG_ADDR16 BIT(16)
-#define I2C_SLAVE_FLAG_RO BIT(17)
+#define I2C_SLAVE_BYTELEN GENMASK(16, 0)
+#define I2C_SLAVE_FLAG_ADDR16 BIT(17)
+#define I2C_SLAVE_FLAG_RO BIT(18)
 #define I2C_SLAVE_DEVICE_MAGIC(_len, _flags) ((_flags) | (_len))
 
 static int i2c_slave_eeprom_slave_cb(struct i2c_client *client,
@@ -171,12 +171,20 @@ static int i2c_slave_eeprom_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id i2c_slave_eeprom_id[] = {
+	{ "slave-24c01", I2C_SLAVE_DEVICE_MAGIC(1024 / 8,  0) },
+	{ "slave-24c01ro", I2C_SLAVE_DEVICE_MAGIC(1024 / 8,  I2C_SLAVE_FLAG_RO) },
 	{ "slave-24c02", I2C_SLAVE_DEVICE_MAGIC(2048 / 8,  0) },
 	{ "slave-24c02ro", I2C_SLAVE_DEVICE_MAGIC(2048 / 8,  I2C_SLAVE_FLAG_RO) },
 	{ "slave-24c32", I2C_SLAVE_DEVICE_MAGIC(32768 / 8, I2C_SLAVE_FLAG_ADDR16) },
 	{ "slave-24c32ro", I2C_SLAVE_DEVICE_MAGIC(32768 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
 	{ "slave-24c64", I2C_SLAVE_DEVICE_MAGIC(65536 / 8, I2C_SLAVE_FLAG_ADDR16) },
 	{ "slave-24c64ro", I2C_SLAVE_DEVICE_MAGIC(65536 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ "slave-24c128", I2C_SLAVE_DEVICE_MAGIC(131072 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ "slave-24c128ro", I2C_SLAVE_DEVICE_MAGIC(131072 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ "slave-24c256", I2C_SLAVE_DEVICE_MAGIC(262144 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ "slave-24c256ro", I2C_SLAVE_DEVICE_MAGIC(262144 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
+	{ "slave-24c512", I2C_SLAVE_DEVICE_MAGIC(524288 / 8, I2C_SLAVE_FLAG_ADDR16) },
+	{ "slave-24c512ro", I2C_SLAVE_DEVICE_MAGIC(524288 / 8, I2C_SLAVE_FLAG_ADDR16 | I2C_SLAVE_FLAG_RO) },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
-- 
2.17.2 (Apple Git-113)
