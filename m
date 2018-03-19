From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 15/21] eeprom: at24: switch to using probe_new() from the i2c framework
Date: Mon, 19 Mar 2018 10:17:15 +0100
Message-ID: <20180319091721.18193-16-brgl@bgdev.pl>
References: <20180319091721.18193-1-brgl@bgdev.pl>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180319091721.18193-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
List-Id: linux-i2c@vger.kernel.org

Use the new probe() style for i2c drivers.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/misc/eeprom/at24.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 02b710919b8b..243d46912f29 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -516,13 +516,14 @@ static unsigned int at24_get_offset_adj(u8 flags, unsigned int byte_len)
 	}
 }
 
-static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
+static int at24_probe(struct i2c_client *client)
 {
 	struct regmap_config regmap_config = { };
 	struct nvmem_config nvmem_config = { };
 	const struct at24_chip_data *cd = NULL;
 	struct at24_platform_data pdata = { };
 	struct device *dev = &client->dev;
+	const struct i2c_device_id *id;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
 	size_t at24_size;
@@ -530,6 +531,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	u8 test_byte;
 	int err;
 
+	id = i2c_match_id(at24_ids, client);
+
 	if (dev->platform_data) {
 		pdata = *(struct at24_platform_data *)dev->platform_data;
 	} else {
@@ -714,7 +717,7 @@ static struct i2c_driver at24_driver = {
 		.of_match_table = at24_of_match,
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
-	.probe = at24_probe,
+	.probe_new = at24_probe,
 	.remove = at24_remove,
 	.id_table = at24_ids,
 };
-- 
2.16.1
