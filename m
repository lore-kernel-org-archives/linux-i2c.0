From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [PATCHv6 11/11] [TESTPATCH] rtc: convert ds1307 to interim probe_new
Date: Tue, 25 Oct 2016 17:41:55 +0100
Message-ID: <1477413715-22894-12-git-send-email-kieran@bingham.xyz>
References: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477413715-22894-1-git-send-email-kieran@bingham.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieran@ksquared.org.uk>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, sameo@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

Just for testing, specify a maxim,ds1307 device to identify the code path used
when instantiating the driver from userspace.

root@arm:~# echo maxim,ds1307 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
[   49.807383] rtc-ds1307 2-0068: I'm a Maxim ...
[   49.814706] rtc-ds1307 2-0068: rtc core: registered maxim,ds1307 as rtc0
[   49.821813] rtc-ds1307 2-0068: 56 bytes nvram
[   49.826444] i2c i2c-2: new_device: Instantiated device maxim,ds1307 at 0x68

This patch also demonstrates how to obtain data from the id's using the
new methods.
---
 drivers/rtc/rtc-ds1307.c | 53 ++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 8e1c5cb6ece6..f760b7cf1fdb 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -31,6 +31,7 @@
  */
 enum ds_type {
 	ds_1307,
+	maxim_1307,
 	ds_1337,
 	ds_1338,
 	ds_1339,
@@ -144,6 +145,10 @@ static struct chip_desc chips[last_ds_type] = {
 		.nvram_offset	= 8,
 		.nvram_size	= 56,
 	},
+	[maxim_1307] = {
+		.nvram_offset	= 8,
+		.nvram_size	= 56,
+	},
 	[ds_1337] = {
 		.alarm		= 1,
 	},
@@ -173,22 +178,6 @@ static struct chip_desc chips[last_ds_type] = {
 	},
 };
 
-static const struct i2c_device_id ds1307_id[] = {
-	{ "ds1307", ds_1307 },
-	{ "ds1337", ds_1337 },
-	{ "ds1338", ds_1338 },
-	{ "ds1339", ds_1339 },
-	{ "ds1388", ds_1388 },
-	{ "ds1340", ds_1340 },
-	{ "ds3231", ds_3231 },
-	{ "m41t00", m41t00 },
-	{ "mcp7940x", mcp794xx },
-	{ "mcp7941x", mcp794xx },
-	{ "pt7c4338", ds_1307 },
-	{ "rx8025", rx_8025 },
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ds1307_id);
 
 /*----------------------------------------------------------------------*/
 
@@ -1223,13 +1212,20 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 
 #endif /* CONFIG_COMMON_CLK */
 
-static int ds1307_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static const struct of_device_id ds1307_dt_ids[] = {
+	{ .compatible = "dallas,ds1307", .data = (void *)ds_1307 },
+	{ .compatible = "maxim,ds1307", .data = (void *)maxim_1307 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ds1307_dt_ids);
+
+static int ds1307_probe(struct i2c_client *client)
 {
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
 	int			tmp, wday;
-	struct chip_desc	*chip = &chips[id->driver_data];
+	const struct of_device_id 	*idof;
+	struct chip_desc	*chip;
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 	bool			want_irq = false;
 	bool			ds1307_can_wakeup_device = false;
@@ -1255,10 +1251,20 @@ static int ds1307_probe(struct i2c_client *client,
 	if (!ds1307)
 		return -ENOMEM;
 
+	/* If we've got this far, this shouldn't be able to fail - but check anyway for now */
+	idof = i2c_of_match_device(ds1307_dt_ids, client);
+	if (!idof) {
+		dev_err(&client->dev, "Probe failed to find an id entry\n");
+		return -ENODEV;
+	}
+
+	/* Now we can set our chip entry */
+	chip = &chips[(int)idof->data];
+
 	i2c_set_clientdata(client, ds1307);
 
 	ds1307->client	= client;
-	ds1307->type	= id->driver_data;
+	ds1307->type	= (int) idof->data;
 
 	if (!pdata && client->dev.of_node)
 		ds1307_trickle_of_init(client, chip);
@@ -1435,6 +1441,9 @@ read_rtc:
 	 */
 	tmp = ds1307->regs[DS1307_REG_SECS];
 	switch (ds1307->type) {
+	case maxim_1307:
+		dev_info(&client->dev, "I'm a Maxim ... \n");
+		/* fallthrough */
 	case ds_1307:
 	case m41t00:
 		/* clock halted?  turn it on, so clock can tick. */
@@ -1634,10 +1643,10 @@ static int ds1307_remove(struct i2c_client *client)
 static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
+		.of_match_table = of_match_ptr(ds1307_dt_ids),
 	},
-	.probe		= ds1307_probe,
+	.probe_new	= ds1307_probe,
 	.remove		= ds1307_remove,
-	.id_table	= ds1307_id,
 };
 
 module_i2c_driver(ds1307_driver);
-- 
2.7.4
