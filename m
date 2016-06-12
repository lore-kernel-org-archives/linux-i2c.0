From: Kieran Bingham <kieran@ksquared.org.uk>
Subject: [TEST PATCH] rtc: convert ds1307 to interim probe_new
Date: Sun, 12 Jun 2016 22:13:47 +0100
Message-ID: <1465766027-485-1-git-send-email-kieran@bingham.xyz>
References: <20160610133200.GB1624@katana>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36409 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045AbcFLVNx (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Sun, 12 Jun 2016 17:13:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id m124so10561820wme.3
        for <linux-i2c@vger.kernel.org>; Sun, 12 Jun 2016 14:13:52 -0700 (PDT)
In-Reply-To: <20160610133200.GB1624@katana>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: kieran@ksquared.org.uk, Wolfram Sang <wsa@the-dreams.de>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

Just for testing, specify a ds9999 device to identify the code path used when
instantiating the driver from userspace.

As we match on only the device, not the manufacturer, I've changed your sketch
so that the test maxim line is on a compatible with name ds9999 to make it
unique. Otherwise, we would match to the dallas,ds1307 id type.

If you would prefer that we support separate manufacturers, I can update the
match function so that it attempts a full match first, followed by a stripped
manufacturer match. I'm not certain if we have a need for that at the moment
though, as the current drivers simply match on the device name:

This patch also demonstrates a method to obtain the device ID from the new
match system for drivers which would normally have expected this information to
be passed in.


Testing:
=======-

root@arm:~# echo ds9999 0x68 > /sys/bus/i2c/devices/i2c-2/new_device
[ 43.262432] rtc-ds1307 2-0068: I'm a Maxim ...
[ 43.268707] rtc-ds1307 2-0068: rtc core: registered ds9999 as rtc0
[ 43.275276] rtc-ds1307 2-0068: 56 bytes nvram
[ 43.279920] i2c i2c-2: new_device: Instantiated device ds9999 at 0x68

root@arm:~# cat /sys/class/rtc/rtc0/date 
2016-06-12

root@arm:~# cat /sys/class/rtc/rtc0/name 
ds9999


---
 drivers/rtc/rtc-ds1307.c | 60 ++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 821d9c089cdb..d97e8adb866b 100644
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
 
@@ -1226,13 +1215,27 @@ static void ds1307_clks_register(struct ds1307 *ds1307)
 
 #endif /* CONFIG_COMMON_CLK */
 
-static int ds1307_probe(struct i2c_client *client,
-			const struct i2c_device_id *id)
+static const struct of_device_id ds1307_dt_ids[] = {
+	/* We are only matching on the device name, *NOT* the manufacturer name
+	 * I.e. dallas, maxim, are dropped in the search when someone tries to load a
+	 * 'ds1307', and hence first match wins.
+	 *
+	 * We could extend this to do a full match first, followed by a fallback match
+	 * to just the device name.
+	 */
+	{ .compatible = "dallas,ds1307", .data = (void *)ds_1307 },
+	{ .compatible = "maxim,ds9999", .data = (void *)maxim_1307 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ds1307_dt_ids);
+
+static int ds1307_probe(struct i2c_client *client)
 {
 	struct ds1307		*ds1307;
 	int			err = -ENODEV;
 	int			tmp;
-	struct chip_desc	*chip = &chips[id->driver_data];
+	const struct of_device_id 	*idof;
+	struct chip_desc	*chip;
 	struct i2c_adapter	*adapter = to_i2c_adapter(client->dev.parent);
 	bool			want_irq = false;
 	bool			ds1307_can_wakeup_device = false;
@@ -1255,10 +1258,20 @@ static int ds1307_probe(struct i2c_client *client,
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
@@ -1435,6 +1448,9 @@ read_rtc:
 	 */
 	tmp = ds1307->regs[DS1307_REG_SECS];
 	switch (ds1307->type) {
+	case maxim_1307:
+		dev_info(&client->dev, "I'm a Maxim ... \n");
+		/* fallthrough */
 	case ds_1307:
 	case m41t00:
 		/* clock halted?  turn it on, so clock can tick. */
@@ -1613,10 +1629,10 @@ static int ds1307_remove(struct i2c_client *client)
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
