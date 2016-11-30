From: "'Tin Huynh' via rtc-linux" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Subject: [PATCH V1] rtc: ds1307: Add ACPI support
Date: Wed, 30 Nov 2016 09:57:31 +0700
Message-ID: <1480474651-13984-1-git-send-email-tnhuynh@apm.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBCKZ7AUOVICRBJUA7HAQKGQECLBA5LY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Thang Nguyen <tqnguyen-qTEPVZfXA3Y@public.gmane.org>, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org, Tin Huynh <tnhuynh-qTEPVZfXA3Y@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch enables ACPI support for rtc-ds1307 driver.

Signed-off-by: Tin Huynh <tnhuynh-qTEPVZfXA3Y@public.gmane.org>
---
 drivers/rtc/rtc-ds1307.c |   51 ++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 4e31036..2a1a4d3 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/bcd.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -191,6 +192,26 @@ static u8 do_trickle_setup_ds1339(struct i2c_client *,
 };
 MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id ds1307_acpi_ids[] = {
+	{ .id = "DS1307", .driver_data = ds_1307 },
+	{ .id = "DS1337", .driver_data = ds_1337 },
+	{ .id = "DS1338", .driver_data = ds_1338 },
+	{ .id = "DS1339", .driver_data = ds_1339 },
+	{ .id = "DS1388", .driver_data = ds_1388 },
+	{ .id = "DS1340", .driver_data = ds_1340 },
+	{ .id = "DS3231", .driver_data = ds_3231 },
+	{ .id = "M41T00", .driver_data = m41t00 },
+	{ .id = "MCP7940X", .driver_data = mcp794xx },
+	{ .id = "MCP7941X", .driver_data = mcp794xx },
+	{ .id = "PT7C4338", .driver_data = ds_1307 },
+	{ .id = "RX8025", .driver_data = rx_8025 },
+	{ .id = "ISL12057", .driver_data = ds_1337 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, ds1307_acpi_ids);
+#endif
+
 /*----------------------------------------------------------------------*/
 
 #define BLOCK_DATA_MAX_TRIES 10
@@ -874,7 +895,7 @@ static u8 do_trickle_setup_ds1339(struct i2c_client *client,
 	return setup;
 }
 
-static void ds1307_trickle_of_init(struct i2c_client *client,
+static void ds1307_trickle_init(struct i2c_client *client,
 				   struct chip_desc *chip)
 {
 	uint32_t ohms = 0;
@@ -882,9 +903,10 @@ static void ds1307_trickle_of_init(struct i2c_client *client,
 
 	if (!chip->do_trickle_setup)
 		goto out;
-	if (of_property_read_u32(client->dev.of_node, "trickle-resistor-ohms" , &ohms))
+	if (device_property_read_u32(&client->dev, "trickle-resistor-ohms",
+					&ohms))
 		goto out;
-	if (of_property_read_bool(client->dev.of_node, "trickle-diode-disable"))
+	if (device_property_read_bool(&client->dev, "trickle-diode-disable"))
 		diode = false;
 	chip->trickle_charger_setup = chip->do_trickle_setup(client,
 							     ohms, diode);
@@ -1268,7 +1290,7 @@ static int ds1307_probe(struct i2c_client *client,
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
 	int			tmp, wday;
-	struct chip_desc	*chip = &chips[id->driver_data];
+	struct chip_desc	*chip;
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 	bool			want_irq = false;
 	bool			ds1307_can_wakeup_device = false;
@@ -1297,11 +1319,23 @@ static int ds1307_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ds1307);
 
 	ds1307->client	= client;
-	ds1307->type	= id->driver_data;
+	if (id) {
+		chip = &chips[id->driver_data];
+		ds1307->type = id->driver_data;
+	} else {
+		const struct acpi_device_id *acpi_id;
+
+		acpi_id = acpi_match_device(ACPI_PTR(ds1307_acpi_ids),
+						&client->dev);
+		if (!acpi_id)
+			return -ENODEV;
+		chip = &chips[acpi_id->driver_data];
+		ds1307->type = acpi_id->driver_data;
+	}
 
-	if (!pdata && client->dev.of_node)
-		ds1307_trickle_of_init(client, chip);
-	else if (pdata && pdata->trickle_charger_setup)
+	if (!pdata)
+		ds1307_trickle_init(client, chip);
+	else if (pdata->trickle_charger_setup)
 		chip->trickle_charger_setup = pdata->trickle_charger_setup;
 
 	if (chip->trickle_charger_setup && chip->trickle_charger_reg) {
@@ -1678,6 +1712,7 @@ static int ds1307_remove(struct i2c_client *client)
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
+		.acpi_match_table = ACPI_PTR(ds1307_acpi_ids),
 	},
 	.probe		= ds1307_probe,
 	.remove		= ds1307_remove,
-- 
1.7.1

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
