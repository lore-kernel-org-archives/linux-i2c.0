From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v4 1/2] at24: support eeproms that do not auto-rollover reads.
Date: Tue, 5 Dec 2017 10:23:41 -0500
Message-ID: <1512487422-6284-2-git-send-email-svendev@arcx.com>
References: <1512487422-6284-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512487422-6284-1-git-send-email-svendev@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, brgl@bgdev.pl, nsekhar@ti.com, sakari.ailus@linux.intel.com, david@lechnology.com, javier@dowhile0.org, divagar.mohandass@intel.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Some multi-address eeproms in the at24 family may not automatically
roll-over reads to the next slave address. On those eeproms, reads
that straddle slave boundaries will not work correctly.

Solution:
Mark such eeproms with a flag that prevents reads straddling
slave boundaries. Add the AT24_FLAG_NO_RDROL flag to the eeprom
entry in the device_id table, or add 'at24,no-read-rollover' to the
eeprom devicetree entry.

Note that I have not personally enountered an at24 chip that
does not support read rollovers. They may or may not exist.
However, my hardware requires this functionality because of
a quirk.

It's up to the Linux community to decide if this patch is useful/
general enough to warrant merging.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/misc/eeprom/at24.c         | 37 +++++++++++++++++++++++++------------
 include/linux/platform_data/at24.h |  2 ++
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 625b001..8c93ed0 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -251,15 +251,6 @@ struct at24_data {
  * Slave address and byte offset derive from the offset. Always
  * set the byte address; on a multi-master board, another master
  * may have changed the chip's "current" address pointer.
- *
- * REVISIT some multi-address chips don't rollover page reads to
- * the next slave address, so we may need to truncate the count.
- * Those chips might need another quirk flag.
- *
- * If the real hardware used four adjacent 24c02 chips and that
- * were misconfigured as one 24c08, that would be a similar effect:
- * one "eeprom" file not four, but larger reads would fail when
- * they crossed certain pages.
  */
 static struct at24_client *at24_translate_offset(struct at24_data *at24,
 						 unsigned int *offset)
@@ -277,6 +268,28 @@ static struct at24_client *at24_translate_offset(struct at24_data *at24,
 	return &at24->client[i];
 }
 
+static size_t at24_adjust_read_count(struct at24_data *at24,
+				      unsigned int offset, size_t count)
+{
+	unsigned int bits;
+	size_t remainder;
+	/*
+	 * In case of multi-address chips that don't rollover reads to
+	 * the next slave address: truncate the count to the slave boundary,
+	 * so that the read never straddles slaves.
+	 */
+	if (at24->chip.flags & AT24_FLAG_NO_RDROL) {
+		bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+		remainder = BIT(bits) - offset;
+		if (count > remainder)
+			count = remainder;
+	}
+	if (count > io_limit)
+		count = io_limit;
+
+	return count;
+}
+
 static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 				unsigned int offset, size_t count)
 {
@@ -289,9 +302,7 @@ static ssize_t at24_regmap_read(struct at24_data *at24, char *buf,
 	at24_client = at24_translate_offset(at24, &offset);
 	regmap = at24_client->regmap;
 	client = at24_client->client;
-
-	if (count > io_limit)
-		count = io_limit;
+	count = at24_adjust_read_count(at24, offset, count);
 
 	/* adjust offset for mac and serial read ops */
 	offset += at24->offset_adj;
@@ -457,6 +468,8 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 
 	if (device_property_present(dev, "read-only"))
 		chip->flags |= AT24_FLAG_READONLY;
+	if (device_property_present(dev, "at24,no-read-rollover"))
+		chip->flags |= AT24_FLAG_NO_RDROL;
 
 	err = device_property_read_u32(dev, "size", &val);
 	if (!err)
diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index 271a4e2..841bb28 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -50,6 +50,8 @@ struct at24_platform_data {
 #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
 #define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
 #define AT24_FLAG_MAC		BIT(2)	/* factory-programmed mac address */
+#define AT24_FLAG_NO_RDROL  BIT(1)	/* does not auto-rollover reads to */
+					/* the next slave address */
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
-- 
1.9.1
