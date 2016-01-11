From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH v2 1/4] mfd: menf21bmc: Remove auto exiting of production
 mode and add sysfs interface
Date: Mon, 11 Jan 2016 13:21:19 +0100
Message-ID: <8bc6f00ae04ace01910030641fb9918d4bda4065.1452514293.git.andreas.werner@men.de>
References: <cover.1452514293.git.andreas.werner@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cover.1452514293.git.andreas.werner@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, sameo@linux.intel.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Changed "exit production mode" from automatic exiting to
manually using the sysfs interface.

If the driver exit the production mode automatically, the board will
not start anymore if the bootloader does not already have the "BIOS life sign"
feature.

This patch remove the auto mechanism and add a sysfs interface to manually
exiting the production e.g. during the EOL test of the board.

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 drivers/mfd/menf21bmc.c | 65 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/menf21bmc.c b/drivers/mfd/menf21bmc.c
index 1c27434..b11bd6b 100644
--- a/drivers/mfd/menf21bmc.c
+++ b/drivers/mfd/menf21bmc.c
@@ -27,31 +27,57 @@ static struct mfd_cell menf21bmc_cell[] = {
 	{ .name = "menf21bmc_hwmon", }
 };
 
-static int menf21bmc_wdt_exit_prod_mode(struct i2c_client *client)
+static ssize_t menf21bmc_mode_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
 {
-	int val, ret;
+	struct i2c_client *client = to_i2c_client(dev);
+	int val;
 
 	val = i2c_smbus_read_byte_data(client, BMC_CMD_WDT_PROD_STAT);
 	if (val < 0)
 		return val;
 
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t menf21bmc_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t size)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned long mode_val;
+	int ret;
+
+	if (kstrtoul(buf, 0, &mode_val))
+		return -EINVAL;
+
 	/*
-	 * Production mode should be not active after delivery of the Board.
-	 * To be sure we check it, inform the user and exit the mode
-	 * if active.
+	 * We cannot set the production mode (0).
+	 * This is the default mode. If exited once,
+	 * it cannot be set anymore.
 	 */
-	if (val == 0x00) {
-		dev_info(&client->dev,
-			"BMC in production mode. Exit production mode\n");
+	if (!mode_val)
+		return -EINVAL;
 
-		ret = i2c_smbus_write_byte(client, BMC_CMD_WDT_EXIT_PROD);
-		if (ret < 0)
-			return ret;
-	}
+	ret = i2c_smbus_write_byte(client, BMC_CMD_WDT_EXIT_PROD);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	return size;
 }
 
+static DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, menf21bmc_mode_show,
+		   menf21bmc_mode_store);
+
+static struct attribute *menf21bmc_attributes[] = {
+	&dev_attr_mode.attr,
+	NULL
+};
+
+static const struct attribute_group menf21bmc_attr_group = {
+	.attrs = menf21bmc_attributes,
+};
+
 static int
 menf21bmc_probe(struct i2c_client *client, const struct i2c_device_id *ids)
 {
@@ -86,20 +112,15 @@ menf21bmc_probe(struct i2c_client *client, const struct i2c_device_id *ids)
 	dev_info(&client->dev, "FW Revision: %02d.%02d.%02d\n",
 		 rev_major, rev_minor, rev_main);
 
-	/*
-	 * We have to exit the Production Mode of the BMC to activate the
-	 * Watchdog functionality and the BIOS life sign monitoring.
-	 */
-	ret = menf21bmc_wdt_exit_prod_mode(client);
-	if (ret < 0) {
-		dev_err(&client->dev, "failed to leave production mode\n");
+	ret = sysfs_create_group(&client->dev.kobj, &menf21bmc_attr_group);
+	if (ret)
 		return ret;
-	}
 
 	ret = mfd_add_devices(&client->dev, 0, menf21bmc_cell,
 			      ARRAY_SIZE(menf21bmc_cell), NULL, 0, NULL);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to add BMC sub-devices\n");
+		sysfs_remove_group(&client->dev.kobj, &menf21bmc_attr_group);
 		return ret;
 	}
 
@@ -108,7 +129,9 @@ menf21bmc_probe(struct i2c_client *client, const struct i2c_device_id *ids)
 
 static int menf21bmc_remove(struct i2c_client *client)
 {
+	sysfs_remove_group(&client->dev.kobj, &menf21bmc_attr_group);
 	mfd_remove_devices(&client->dev);
+
 	return 0;
 }
 
-- 
2.6.2
