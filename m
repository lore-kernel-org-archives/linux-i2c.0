From: RAGHAVENDRA GANIGA <ravi23ganiga@gmail.com>
Subject: [PATCH 3/3] i2c: i2c-core: fix coding style issues in i2c-core.c
Date: Mon, 14 Oct 2013 20:55:15 +0530
Message-ID: <525C0CDB.6020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, ravi23ganiga@gmail.com
List-Id: linux-i2c@vger.kernel.org

>From 2c324e677fd8bfb0ad13a8c949317e40cc5fd23e Mon Sep 17 00:00:00 2001
From: Raghavendra Ganiga <ravi23ganiga@gmail.com>
Date: Mon, 14 Oct 2013 20:42:37 +0530
Subject: [PATCH 3/3] i2c: i2c-core: fix coding style issues in i2c-core.c

This is a patch to the i2c-core.c file that fixes the
coding style issues found by checkpatch.pl tool

Signed-off-by: Raghavendra Chandra Ganiga <ravi23ganiga@gmail.com>
---
 drivers/i2c/i2c-core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 66e38a9..7e95fcd 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1737,9 +1737,9 @@ int i2c_transfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 		for (ret = 0; ret < num; ret++) {
 			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, len=%d%s\n",
 				ret,
-				((msgs[ret].flags & I2C_M_RD) ? 'R' : 'W'),
+				msgs[ret].flags & I2C_M_RD ? 'R' : 'W',
 				msgs[ret].addr, msgs[ret].len,
-				(msgs[ret].flags & I2C_M_RECV_LEN) ? "+" : "");
+				msgs[ret].flags & I2C_M_RECV_LEN ? "+" : "");
 		}
 #endif
 
@@ -2120,7 +2120,8 @@ EXPORT_SYMBOL(i2c_smbus_read_byte);
 s32 i2c_smbus_write_byte(const struct i2c_client *client, u8 value)
 {
 	return i2c_smbus_xfer(client->adapter, client->addr, client->flags,
-				I2C_SMBUS_WRITE, value, I2C_SMBUS_BYTE, NULL);
+			      I2C_SMBUS_WRITE, value,
+			      I2C_SMBUS_BYTE, NULL);
 }
 EXPORT_SYMBOL(i2c_smbus_write_byte);
 
-- 
1.7.10.4
