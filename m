From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] drivers: misc: eeprom: at24: support reading mac eeprom from different addresses
Date: Thu, 6 Jul 2017 13:16:56 +0300
Message-ID: <1499336217-16913-3-git-send-email-claudiu.beznea@microchip.com>
References: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499336217-16913-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, nsekhar@ti.com, david@lechnology.com, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-i2c@vger.kernel.org

Add support for reading MAC address from different offsets of EEPROM. The
offset is initialized via device tree. If nothing is given as input the
old value, 0x90, is used. In this way the driver could be used as generic
driver for different vendor memories by only changing the reading offset
via device tree.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/misc/eeprom/at24.c         | 5 ++++-
 include/linux/platform_data/at24.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 764ff5df..53c2b03 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -365,7 +365,7 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
 	msg[0].buf = addrbuf;
-	addrbuf[0] = 0x90 + offset;
+	addrbuf[0] = at24->chip.mac_offset + offset;
 	msg[0].len = 1;
 	msg[1].addr = client->addr;
 	msg[1].flags = I2C_M_RD;
@@ -581,6 +581,9 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 		 */
 		chip->page_size = 1;
 	}
+	err = device_property_read_u32(dev, "mac-offset", &chip->mac_offset);
+	if (err)
+		chip->mac_offset = 0x90;
 }
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index 271a4e2..4e9523e 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -42,6 +42,7 @@
 
 struct at24_platform_data {
 	u32		byte_len;		/* size (sum of all addr) */
+	u32		mac_offset;
 	u16		page_size;		/* for writes */
 	u8		flags;
 #define AT24_FLAG_ADDR16	BIT(7)	/* address pointer is 16 bit */
-- 
2.7.4
