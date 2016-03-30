From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH] i2c: mux: demux-pinctrl: Fix reading the "master" attribute
Date: Wed, 30 Mar 2016 17:27:16 +0100
Message-ID: <1459355236.27975.5.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:36763 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbcC3Q1X (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Wed, 30 Mar 2016 12:27:23 -0400
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, CT kernel <linux-kernel@lists.codethink.co.uk>

sysfs attributes should use the same format for reads and writes,
rather than pretty-printing on read.

Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/i2c/muxes/i2c-demux-pinctrl.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index 7748a0a5ddb9..9e8f3d702314 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -144,14 +144,8 @@ static ssize_t cur_master_show(struct device *dev, struct device_attribute *attr
 			   char *buf)
 {
 	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
-	int count = 0, i;
 
-	for (i = 0; i < priv->num_chan && count < PAGE_SIZE; i++)
-		count += scnprintf(buf + count, PAGE_SIZE - count, "%c %d - %s\n",
-				 i == priv->cur_chan ? '*' : ' ', i,
-				 priv->chan[i].parent_np->full_name);
-
-	return count;
+	return sprintf(buf, "%u\n", priv->cur_chan);
 }
 
 static ssize_t cur_master_store(struct device *dev, struct device_attribute *attr,

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
