From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2] eeprom: at24: check if the chip is functional in probe()
Date: Fri, 12 Aug 2016 13:32:57 +0200
Message-ID: <1471001577-9269-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37266 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbcHLLdD (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 12 Aug 2016 07:33:03 -0400
Received: by mail-wm0-f53.google.com with SMTP id i5so27214849wmg.0
        for <linux-i2c@vger.kernel.org>; Fri, 12 Aug 2016 04:33:03 -0700 (PDT)
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The at24 driver doesn't check if the chip is functional in its probe
function. This leads to instantiating devices that are not physically
present. For example the cape EEPROMs for BeagleBone Black are defined
in the device tree at four addresses on i2c2, but normally only one of
them is present.

If the userspace doesn't know the location in advance, it will need to
check if reading the nvmem attributes fails to determine which EEPROM
is actually there.

Try to read a single byte in probe() and bail-out with -ENODEV if the
read fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- renamed c to test_byte
- changed the test_byte type to u8 (was char)
- moved the check above the nvmem registration
- moved the i2c_set_clientdata() call above both the nvmem
  registration and the test byte read
- removed the error message

 drivers/misc/eeprom/at24.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 3cdf8e1..051b147 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -593,6 +593,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
+	u8 test_byte;
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
@@ -743,6 +744,18 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		}
 	}
 
+	i2c_set_clientdata(client, at24);
+
+	/*
+	 * Perform a one-byte test read to verify that the
+	 * chip is functional.
+	 */
+	err = at24_read(at24, 0, &test_byte, 1);
+	if (err) {
+		err = -ENODEV;
+		goto err_clients;
+	}
+
 	at24->nvmem_config.name = dev_name(&client->dev);
 	at24->nvmem_config.dev = &client->dev;
 	at24->nvmem_config.read_only = !writable;
@@ -764,8 +777,6 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		goto err_clients;
 	}
 
-	i2c_set_clientdata(client, at24);
-
 	dev_info(&client->dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
 		chip.byte_len, client->name,
 		writable ? "writable" : "read-only", at24->write_max);
-- 
2.7.4
