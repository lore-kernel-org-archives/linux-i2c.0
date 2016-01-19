From: minyard@acm.org
Subject: [PATCH 1/3] i2c: Add parameters to sysfs-added i2c devices
Date: Tue, 19 Jan 2016 11:14:12 -0600
Message-ID: <1453223654-20724-2-git-send-email-minyard@acm.org>
References: <1453223654-20724-1-git-send-email-minyard@acm.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:58049 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932510AbcASSOU (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 19 Jan 2016 13:14:20 -0500
Received: from serve.minyard.net ([173.57.176.17]) by vms173019.mailsrvcs.net
 (Oracle Communications Messaging Server 7.0.5.32.0 64bit (built Jul 16 2014))
 with ESMTPA id <0O17002AJMJSHK40@vms173019.mailsrvcs.net> for
 linux-i2c@vger.kernel.org; Tue, 19 Jan 2016 11:14:17 -0600 (CST)
In-reply-to: <1453223654-20724-1-git-send-email-minyard@acm.org>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Some devices might need parameters to control their operation,
add the ability to pass these parameters to the client.

This also makes the parsing of sysfs-added I2C devices a little
more flexible, allowing tabs and arbitrary numbers of spaces.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/i2c/i2c-core.c | 46 ++++++++++++++++++++++++++++++++++------------
 include/linux/i2c.h    |  3 +++
 2 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index ffe715d..e2e42fc 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -785,7 +785,10 @@ static void i2c_device_shutdown(struct device *dev)
 
 static void i2c_client_dev_release(struct device *dev)
 {
-	kfree(to_i2c_client(dev));
+	struct i2c_client *client = to_i2c_client(dev);
+
+	kfree(client->parms);
+	kfree(client);
 }
 
 static ssize_t
@@ -1052,6 +1055,13 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->flags = info->flags;
 	client->addr = info->addr;
 	client->irq = info->irq;
+	if (info->parms) {
+		client->parms = kstrdup(info->parms, GFP_KERNEL);
+		if (!client->parms) {
+			dev_err(&adap->dev, "Out of memory allocating parms\n");
+			goto out_err_silent;
+		}
+	}
 
 	strlcpy(client->name, info->type, sizeof(client->name));
 
@@ -1201,31 +1211,43 @@ i2c_sysfs_new_device(struct device *dev, struct device_attribute *attr,
 	struct i2c_adapter *adap = to_i2c_adapter(dev);
 	struct i2c_board_info info;
 	struct i2c_client *client;
-	char *blank, end;
+	char *pos, end;
 	int res;
 
 	memset(&info, 0, sizeof(struct i2c_board_info));
 
-	blank = strchr(buf, ' ');
-	if (!blank) {
+	pos = strpbrk(buf, " \t");
+	if (!pos) {
 		dev_err(dev, "%s: Missing parameters\n", "new_device");
 		return -EINVAL;
 	}
-	if (blank - buf > I2C_NAME_SIZE - 1) {
+	if (pos - buf > I2C_NAME_SIZE - 1) {
 		dev_err(dev, "%s: Invalid device name\n", "new_device");
 		return -EINVAL;
 	}
-	memcpy(info.type, buf, blank - buf);
+	memcpy(info.type, buf, pos - buf);
 
-	/* Parse remaining parameters, reject extra parameters */
-	res = sscanf(++blank, "%hi%c", &info.addr, &end);
-	if (res < 1) {
+	while (isspace(*pos))
+		pos++;
+
+	/* Parse address, saving remaining parameters. */
+	res = sscanf(pos, "%hi%c", &info.addr, &end);
+	if (res < 1 || !isspace(end)) {
 		dev_err(dev, "%s: Can't parse I2C address\n", "new_device");
 		return -EINVAL;
 	}
-	if (res > 1  && end != '\n') {
-		dev_err(dev, "%s: Extra parameters\n", "new_device");
-		return -EINVAL;
+	if (res > 1 && end != '\n') {
+		if (isspace(end)) {
+			/* Extra parms, skip the address and space. */
+			while (!isspace(*pos))
+				pos++;
+			while (isspace(*pos))
+				pos++;
+			info.parms = pos;
+		} else {
+			dev_err(dev, "%s: Extra parameters\n", "new_device");
+			return -EINVAL;
+		}
 	}
 
 	if ((info.addr & I2C_ADDR_OFFSET_TEN_BIT) == I2C_ADDR_OFFSET_TEN_BIT) {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 200cf13b..35db0dd 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -225,6 +225,7 @@ struct i2c_client {
 	char name[I2C_NAME_SIZE];
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct device dev;		/* the device structure		*/
+	char *parms;			/* sysfs extra parms		*/
 	int irq;			/* irq issued by device		*/
 	struct list_head detected;
 #if IS_ENABLED(CONFIG_I2C_SLAVE)
@@ -282,6 +283,7 @@ static inline int i2c_slave_event(struct i2c_client *client,
  * @archdata: copied into i2c_client.dev.archdata
  * @of_node: pointer to OpenFirmware device node
  * @fwnode: device node supplied by the platform firmware
+ * @parms: Parameters supplied on the sysfs command line
  * @irq: stored in i2c_client.irq
  *
  * I2C doesn't actually support hardware probing, although controllers and
@@ -303,6 +305,7 @@ struct i2c_board_info {
 	struct dev_archdata	*archdata;
 	struct device_node *of_node;
 	struct fwnode_handle *fwnode;
+	char            *parms;
 	int		irq;
 };
 
-- 
2.5.0
