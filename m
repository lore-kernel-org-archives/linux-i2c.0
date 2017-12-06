From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v1 2/2] eeprom: at24: remove temporary fix for at24mac402 size.
Date: Wed, 6 Dec 2017 11:04:32 -0500
Message-ID: <1512576272-25563-3-git-send-email-svendev@arcx.com>
References: <1512576272-25563-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512576272-25563-1-git-send-email-svendev@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The chip size passed via devicetree, i2c, or acpi device ids is
now no longer limited to a power of two. So the temporary
fix can be removed.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/misc/eeprom/at24.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index d990c5d..1845b62 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -545,16 +545,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		dev_warn(&client->dev,
 			"page_size looks suspicious (no power of 2)!\n");
 
-	/*
-	 * REVISIT: the size of the EUI-48 byte array is 6 in at24mac402, while
-	 * the call to ilog2() in AT24_DEVICE_MAGIC() rounds it down to 4.
-	 *
-	 * Eventually we'll get rid of the magic values altoghether in favor of
-	 * real structs, but for now just manually set the right size.
-	 */
-	if (chip.flags & AT24_FLAG_MAC && chip.byte_len == 4)
-		chip.byte_len = 6;
-
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
 	    !i2c_check_functionality(client->adapter,
 				     I2C_FUNC_SMBUS_WRITE_I2C_BLOCK))
-- 
1.9.1
