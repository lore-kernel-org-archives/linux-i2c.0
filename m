From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH] i2c: mux: demux-pinctrl: Clean up sysfs attributes
Date: Thu, 31 Mar 2016 16:40:05 +0100
Message-ID: <1459438805.18533.3.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:40385 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbcCaPkO (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Thu, 31 Mar 2016 11:40:14 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, CT kernel <linux-kernel@lists.codethink.co.uk>, Ben Dooks <ben.dooks@codethink.co.uk>

sysfs attributes should use the same format for reads and writes,
rather than pretty-printing on read.

* Make the "cur_master" attribute read back as just the name of the
  master
* Expose the list of all masters as a read-only "available_masters"
  attribute, using space separators as in similar attributes of other
  devices

Also, spell out "cur_master" in full as "current_master".

Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 39 ++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 7748a0a5ddb9..8de073aed001 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -140,22 +140,34 @@ static int i2c_demux_change_master(struct i2c_demux_pinctrl_priv *priv, u32 new_
 	return i2c_demux_activate_master(priv, new_chan);
 }
 
-static ssize_t cur_master_show(struct device *dev, struct device_attribute *attr,
-			   char *buf)
+static ssize_t available_masters_show(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
 {
 	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
 	int count = 0, i;
 
 	for (i = 0; i < priv->num_chan && count < PAGE_SIZE; i++)
-		count += scnprintf(buf + count, PAGE_SIZE - count, "%c %d - %s\n",
-				 i == priv->cur_chan ? '*' : ' ', i,
-				 priv->chan[i].parent_np->full_name);
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%d:%s%c",
+				   i, priv->chan[i].parent_np->full_name,
+				   i == priv->num_chan - 1 ? '\n' : ' ');
 
 	return count;
 }
+static DEVICE_ATTR_RO(available_masters);
 
-static ssize_t cur_master_store(struct device *dev, struct device_attribute *attr,
-			    const char *buf, size_t count)
+static ssize_t current_master_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", priv->cur_chan);
+}
+
+static ssize_t current_master_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
 {
 	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
 	unsigned int val;
@@ -172,7 +184,7 @@ static ssize_t cur_master_store(struct device *dev, struct device_attribute *att
 
 	return ret < 0 ? ret : count;
 }
-static DEVICE_ATTR_RW(cur_master);
+static DEVICE_ATTR_RW(current_master);
 
 static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 {
@@ -218,12 +230,18 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 	/* switch to first parent as active master */
 	i2c_demux_activate_master(priv, 0);
 
-	err = device_create_file(&pdev->dev, &dev_attr_cur_master);
+	err = device_create_file(&pdev->dev, &dev_attr_available_masters);
 	if (err)
 		goto err_rollback;
 
+	err = device_create_file(&pdev->dev, &dev_attr_current_master);
+	if (err)
+		goto err_rollback_available;
+
 	return 0;
 
+err_rollback_available:
+	device_remove_file(&pdev->dev, &dev_attr_available_masters);
 err_rollback:
 	for (j = 0; j < i; j++) {
 		of_node_put(priv->chan[j].parent_np);
@@ -238,7 +256,8 @@ static int i2c_demux_pinctrl_remove(struct platform_device *pdev)
 	struct i2c_demux_pinctrl_priv *priv = platform_get_drvdata(pdev);
 	int i;
 
-	device_remove_file(&pdev->dev, &dev_attr_cur_master);
+	device_remove_file(&pdev->dev, &dev_attr_current_master);
+	device_remove_file(&pdev->dev, &dev_attr_available_masters);
 
 	i2c_demux_deactivate_master(priv);
 

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
