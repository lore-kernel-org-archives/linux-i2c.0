From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] Blackfin I2C/TWI Driver: implement I2C_FUNC_SMBUS_I2C_BLOCK functionality
Date: Mon,  1 Jun 2009 01:38:07 -0400
Message-ID: <1243834687-32648-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>

Some drivers need i2c_smbus_read_i2c_block_data() functionality, so add
support for it to the Blackfin I2C bus driver.

Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-bfin-twi.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-bfin-twi.c
index 38d7fbe..6dc5d66 100644
--- a/drivers/i2c/busses/i2c-bfin-twi.c
+++ b/drivers/i2c/busses/i2c-bfin-twi.c
@@ -449,6 +449,16 @@ int bfin_twi_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 		}
 		iface->transPtr = data->block;
 		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (read_write == I2C_SMBUS_READ) {
+			iface->readNum = data->block[0];
+			iface->cur_mode = TWI_I2C_MODE_COMBINED;
+		} else {
+			iface->writeNum = data->block[0];
+			iface->cur_mode = TWI_I2C_MODE_STANDARDSUB;
+		}
+		iface->transPtr = (u8 *)&data->block[1];
+		break;
 	default:
 		return -1;
 	}
@@ -572,7 +582,7 @@ static u32 bfin_twi_functionality(struct i2c_adapter *adap)
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
 	       I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL |
-	       I2C_FUNC_I2C;
+	       I2C_FUNC_I2C | I2C_FUNC_SMBUS_I2C_BLOCK;
 }
 
 static struct i2c_algorithm bfin_twi_algorithm = {
-- 
1.6.3.1
