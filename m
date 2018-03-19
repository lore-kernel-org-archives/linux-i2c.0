From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 17/21] eeprom: at24: remove at24_platform_data from at24_data
Date: Mon, 19 Mar 2018 10:17:17 +0100
Message-ID: <20180319091721.18193-18-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Not all fields from at24_platform_data are needed in at24_data. Let's
keep just the ones we need and not carry the whole platform_data
structure all the time.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index bed6917468e1..4888999a62cc 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -60,8 +60,6 @@ struct at24_client {
 };
 
 struct at24_data {
-	struct at24_platform_data chip;
-
 	/*
 	 * Lock protects against activities from other Linux tasks,
 	 * but not from changes by other I2C masters.
@@ -72,6 +70,10 @@ struct at24_data {
 	unsigned int num_addresses;
 	unsigned int offset_adj;
 
+	u32 byte_len;
+	u16 page_size;
+	u8 flags;
+
 	struct nvmem_device *nvmem;
 
 	struct gpio_desc *wp_gpio;
@@ -249,7 +251,7 @@ static struct at24_client *at24_translate_offset(struct at24_data *at24,
 {
 	unsigned int i;
 
-	if (at24->chip.flags & AT24_FLAG_ADDR16) {
+	if (at24->flags & AT24_FLAG_ADDR16) {
 		i = *offset >> 16;
 		*offset &= 0xffff;
 	} else {
@@ -276,8 +278,8 @@ static size_t at24_adjust_read_count(struct at24_data *at24,
 	 * the next slave address: truncate the count to the slave boundary,
 	 * so that the read never straddles slaves.
 	 */
-	if (at24->chip.flags & AT24_FLAG_NO_RDROL) {
-		bits = (at24->chip.flags & AT24_FLAG_ADDR16) ? 16 : 8;
+	if (at24->flags & AT24_FLAG_NO_RDROL) {
+		bits = (at24->flags & AT24_FLAG_ADDR16) ? 16 : 8;
 		remainder = BIT(bits) - offset;
 		if (count > remainder)
 			count = remainder;
@@ -336,7 +338,7 @@ static size_t at24_adjust_write_count(struct at24_data *at24,
 		count = at24->write_max;
 
 	/* Never roll over backwards, to the start of this page */
-	next_page = roundup(offset + 1, at24->chip.page_size);
+	next_page = roundup(offset + 1, at24->page_size);
 	if (offset + count > next_page)
 		count = next_page - offset;
 
@@ -381,7 +383,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return count;
 
-	if (off + count > at24->chip.byte_len)
+	if (off + count > at24->byte_len)
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(dev);
@@ -428,7 +430,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 	if (unlikely(!count))
 		return -EINVAL;
 
-	if (off + count > at24->chip.byte_len)
+	if (off + count > at24->byte_len)
 		return -EINVAL;
 
 	ret = pm_runtime_get_sync(dev);
@@ -598,7 +600,9 @@ static int at24_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	mutex_init(&at24->lock);
-	at24->chip = pdata;
+	at24->byte_len = pdata.byte_len;
+	at24->page_size = pdata.page_size;
+	at24->flags = pdata.flags;
 	at24->num_addresses = num_addresses;
 	at24->offset_adj = at24_get_offset_adj(pdata.flags, pdata.byte_len);
 
-- 
2.16.1
