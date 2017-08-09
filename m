From: Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH] i2c: slave-eeprom: Add an OF device ID table
Date: Wed,  9 Aug 2017 12:12:56 +0200
Message-ID: <20170809101256.31204-1-javierm@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Luis Oliveira <Luis.Oliveira@synopsys.com>, Javier Martinez Canillas <javierm@redhat.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees as shown in the following DT binding doc:

Documentation/devicetree/bindings/i2c/i2c-designware.txt

But this works on the assumption that a I2C device registered via OF will
always match a legacy I2C device ID and that the MODALIAS reported will
always be of the form i2c:<device>.

And this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 drivers/i2c/i2c-slave-eeprom.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-slave-eeprom.c b/drivers/i2c/i2c-slave-eeprom.c
index b2039f94c9d8..20226860cfe7 100644
--- a/drivers/i2c/i2c-slave-eeprom.c
+++ b/drivers/i2c/i2c-slave-eeprom.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -108,7 +109,12 @@ static int i2c_slave_eeprom_probe(struct i2c_client *client, const struct i2c_de
 {
 	struct eeprom_data *eeprom;
 	int ret;
-	unsigned size = id->driver_data;
+	unsigned size;
+
+	if (client->dev.of_node)
+		size = (kernel_ulong_t)of_device_get_match_data(&client->dev);
+	else
+		size = id->driver_data;
 
 	eeprom = devm_kzalloc(&client->dev, sizeof(struct eeprom_data) + size, GFP_KERNEL);
 	if (!eeprom)
@@ -154,9 +160,16 @@ static const struct i2c_device_id i2c_slave_eeprom_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, i2c_slave_eeprom_id);
 
+static const struct of_device_id i2c_slave_eeprom_of_match[] = {
+	{ .compatible = "linux,slave-24c02", .data = (void *)(2048 / 8) },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, i2c_slave_eeprom_of_match);
+
 static struct i2c_driver i2c_slave_eeprom_driver = {
 	.driver = {
 		.name = "i2c-slave-eeprom",
+		.of_match_table = i2c_slave_eeprom_of_match,
 	},
 	.probe = i2c_slave_eeprom_probe,
 	.remove = i2c_slave_eeprom_remove,
-- 
2.13.3
