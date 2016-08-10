From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] eeprom: at24: check if the chip is functional in probe()
Date: Wed, 10 Aug 2016 15:54:17 +0200
Message-ID: <1470837257-15521-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-i2c@vger.kernel.org

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
 drivers/misc/eeprom/at24.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 3cdf8e1..ed1e4eb 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -593,6 +593,7 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	struct at24_data *at24;
 	int err;
 	unsigned i, num_addresses;
+	char c;
 
 	if (client->dev.platform_data) {
 		chip = *(struct at24_platform_data *)client->dev.platform_data;
@@ -780,6 +781,15 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	if (chip.setup)
 		chip.setup(at24->nvmem, chip.context);
 
+	err = at24_read(at24, 0, &c, 1);
+	if (err) {
+		dev_err(&client->dev,
+			"error reading the test byte from EEPROM: %d\n", err);
+		nvmem_unregister(at24->nvmem);
+		err = -ENODEV;
+		goto err_clients;
+	}
+
 	return 0;
 
 err_clients:
-- 
2.7.4
