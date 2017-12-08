From: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
Subject: [PATCH v2 2/2] eeprom: at24: remove temporary fix for at24mac402 size.
Date: Fri, 8 Dec 2017 16:25:06 -0500
Message-ID: <1512768306-14816-3-git-send-email-svendev@arcx.com>
References: <1512768306-14816-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1512768306-14816-1-git-send-email-svendev-fuHqz3Nb1YI@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: svendev-fuHqz3Nb1YI@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, brgl-ARrdPY/1zhM@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, divagar.mohandass-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The chip size passed via devicetree, i2c, or acpi device ids is
now no longer limited to a power of two. So the temporary
fix can be removed.

Signed-off-by: Sven Van Asbroeck <svendev-fuHqz3Nb1YI@public.gmane.org>
---
 drivers/misc/eeprom/at24.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index c3759cb..e522350 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -569,16 +569,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
