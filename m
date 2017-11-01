From: Sven Van Asbroeck <svendev@arcx.com>
Subject: [PATCH v2 1/1] at24: support eeproms that do not roll over page reads.
Date: Wed, 1 Nov 2017 09:44:03 -0400
Message-ID: <1509543843-27697-2-git-send-email-svendev@arcx.com>
References: <1509543843-27697-1-git-send-email-svendev@arcx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509543843-27697-1-git-send-email-svendev@arcx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: svendev@arcx.com, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, nsekhar@ti.com, david@lechnology.com, javier@dowhile0.org, brgl@bgdev.pl
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Some eeproms in the at24 family do not roll over page reads,
e.g. the Microchip 24AA16/24LC16B. On those eeproms, reads
that straddle block boundaries will not work correctly.

Solution:
Implement read rollover in the driver. To enable it, add the
AT24_FLAG_NO_RDROL flag to the eeprom entry in the
device_id table, or add 'no-read-rollover' to the eeprom
devicetree entry.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 .../devicetree/bindings/eeprom/eeprom.txt          |  5 +++
 drivers/misc/eeprom/at24.c                         | 47 +++++++++++-----------
 include/linux/platform_data/at24.h                 |  1 +
 3 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
index afc0458..301bc7e 100644
--- a/Documentation/devicetree/bindings/eeprom/eeprom.txt
+++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
@@ -36,6 +36,11 @@ Optional properties:
 
   - read-only: this parameterless property disables writes to the eeprom
 
+  - no-read-rollover: supported on the at24 eeprom family only.
+			This parameterless property indicates that the
+			eeprom does not support auto read rollover. Please consult
+			the manual of your device.
+
 Example:
 
 eeprom@52 {
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 764ff5df..3517eae 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -192,26 +192,23 @@ struct at24_data {
  * set the byte address; on a multi-master board, another master
  * may have changed the chip's "current" address pointer.
  *
- * REVISIT some multi-address chips don't rollover page reads to
- * the next slave address, so we may need to truncate the count.
- * Those chips might need another quirk flag.
- *
- * If the real hardware used four adjacent 24c02 chips and that
- * were misconfigured as one 24c08, that would be a similar effect:
- * one "eeprom" file not four, but larger reads would fail when
- * they crossed certain pages.
+ * In case of chips that don't rollover page reads, truncate the count
+ * to the nearest page boundary. This might result in the
+ * at24_eeprom_read_XXX functions reading fewer bytes than requested,
+ * but this is compensated for in at24_read().
  */
 static struct i2c_client *at24_translate_offset(struct at24_data *at24,
-						unsigned int *offset)
+		unsigned int *offset, size_t *count)
 {
-	unsigned i;
-
-	if (at24->chip.flags & AT24_FLAG_ADDR16) {
-		i = *offset >> 16;
-		*offset &= 0xffff;
-	} else {
-		i = *offset >> 8;
-		*offset &= 0xff;
+	unsigned int i, bits;
+	size_t remainder;
+
+	bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	i = *offset >> bits;
+	*offset &= AT24_BITMASK(bits);
+	if ((at24->chip.flags & AT24_FLAG_NO_RDROL) && count) {
+		remainder = BIT(bits) - *offset;
+		*count = min(*count, remainder);
 	}
 
 	return at24->client[i];
@@ -224,7 +221,7 @@ static ssize_t at24_eeprom_read_smbus(struct at24_data *at24, char *buf,
 	struct i2c_client *client;
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset, &count);
 
 	if (count > io_limit)
 		count = io_limit;
@@ -258,7 +255,7 @@ static ssize_t at24_eeprom_read_i2c(struct at24_data *at24, char *buf,
 	u8 msgbuf[2];
 
 	memset(msg, 0, sizeof(msg));
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset, &count);
 
 	if (count > io_limit)
 		count = io_limit;
@@ -307,7 +304,7 @@ static ssize_t at24_eeprom_read_serial(struct at24_data *at24, char *buf,
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset, &count);
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -360,7 +357,7 @@ static ssize_t at24_eeprom_read_mac(struct at24_data *at24, char *buf,
 	u8 addrbuf[2];
 	int status;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset, &count);
 
 	memset(msg, 0, sizeof(msg));
 	msg[0].addr = client->addr;
@@ -415,7 +412,7 @@ static ssize_t at24_eeprom_write_smbus_block(struct at24_data *at24,
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset, NULL);
 	count = at24_adjust_write_count(at24, offset, count);
 
 	loop_until_timeout(timeout, write_time) {
@@ -442,7 +439,7 @@ static ssize_t at24_eeprom_write_smbus_byte(struct at24_data *at24,
 	struct i2c_client *client;
 	ssize_t status = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset, &count);
 
 	loop_until_timeout(timeout, write_time) {
 		status = i2c_smbus_write_byte_data(client, offset, buf[0]);
@@ -468,7 +465,7 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 	ssize_t status = 0;
 	int i = 0;
 
-	client = at24_translate_offset(at24, &offset);
+	client = at24_translate_offset(at24, &offset, NULL);
 	count = at24_adjust_write_count(at24, offset, count);
 
 	msg.addr = client->addr;
@@ -569,6 +566,8 @@ static void at24_get_pdata(struct device *dev, struct at24_platform_data *chip)
 
 	if (device_property_present(dev, "read-only"))
 		chip->flags |= AT24_FLAG_READONLY;
+	if (device_property_present(dev, "no-read-rollover"))
+		chip->flags |= AT24_FLAG_NO_RDROL;
 
 	err = device_property_read_u32(dev, "pagesize", &val);
 	if (!err) {
diff --git a/include/linux/platform_data/at24.h b/include/linux/platform_data/at24.h
index 271a4e2..a5804f1 100644
--- a/include/linux/platform_data/at24.h
+++ b/include/linux/platform_data/at24.h
@@ -50,6 +50,7 @@ struct at24_platform_data {
 #define AT24_FLAG_TAKE8ADDR	BIT(4)	/* take always 8 addresses (24c00) */
 #define AT24_FLAG_SERIAL	BIT(3)	/* factory-programmed serial number */
 #define AT24_FLAG_MAC		BIT(2)	/* factory-programmed mac address */
+#define AT24_FLAG_NO_RDROL	BIT(1)	/* chip does not rollover page reads */
 
 	void		(*setup)(struct nvmem_device *nvmem, void *context);
 	void		*context;
-- 
1.9.1
