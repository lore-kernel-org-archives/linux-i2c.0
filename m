From: Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RFC PATCH 2/3] drivers: misc: eeprom: at24: support reading mac eeprom from different addresses
Date: Thu, 29 Jun 2017 14:39:10 +0300
Message-ID: <1498736351-9021-3-git-send-email-claudiu.beznea@microchip.com>
References: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498736351-9021-1-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, nsekhar@ti.com, david@lechnology.com, wsa@the-dreams.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, nicolas.ferre@microchip.com, Claudiu Beznea <claudiu.beznea@microchip.com>
List-Id: linux-i2c@vger.kernel.org

Add support for reading from different offsets of EEPROM.
The offset is initialized via device tree. If nothing is
given as input the old value, 0x90, is used. In this way
the driver could be used as generic driver for different
vendor memories by only changing the reading offset via
device tree.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/misc/eeprom/at24.c         | 5 ++++-
 include/linux/platform_data/at24.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 764ff5df..53c5fb8 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -365,7 +365,7 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
 	msg[0].buf = addrbuf;
-	addrbuf[0] = 0x90 + offset;
+	addrbuf[0] = at24->chip.offset + offset;
 	msg[0].len = 1;
 	msg[1].addr = client->addr;
 	msg[1].flags = I2C_M_RD;
@@ -581,6 +581,9 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 		 */
 		chip->page_size = 1;
 	}
+	err = device_property_read_u8(dev, "start-offset", &chip->offset);
+	if (err)
+		chip->offset = 0x90;
 }
 
 static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index 271a4e2..d55c454 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -50,6 +50,7 @@ struct at24_platform_data {
 #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
 #define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
 #define AT24_FLAG_MAC		BIT(2)	/* factory-programmed mac address */
+	u8		offset;
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
-- 
2.7.4
