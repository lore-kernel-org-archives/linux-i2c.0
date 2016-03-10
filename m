From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] i2c: i801: Add runtime PM support with autosuspend
Date: Thu, 10 Mar 2016 14:12:22 +0200
Message-ID: <1457611942-8405-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1457611942-8405-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17470 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcCJMMe (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Mar 2016 07:12:34 -0500
In-Reply-To: <1457611942-8405-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Reinette Chatre <reinette.chatre@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Allow runtime PM so that PM and PCI core can put the device into low-power
state when idle and resume it back when needed in those platforms that
support PM for i801 device.

Enable also autosuspend with 1 second delay in order to not needlessly
toggle power state on and off if there are multiple transactions during
short time.

Device is resumed at the beginning of bus access and marked idle ready
for autosuspend at the end of it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 091debf7c9de..184dfcd547cd 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -94,6 +94,7 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/itco_wdt.h>
+#include <linux/pm_runtime.h>
 
 #if (defined CONFIG_I2C_MUX_GPIO || defined CONFIG_I2C_MUX_GPIO_MODULE) && \
 		defined CONFIG_DMI
@@ -714,9 +715,11 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 {
 	int hwpec;
 	int block = 0;
-	int ret, xact = 0;
+	int ret = 0, xact = 0;
 	struct i801_priv *priv = i2c_get_adapdata(adap);
 
+	pm_runtime_get_sync(&priv->pci_dev->dev);
+
 	hwpec = (priv->features & FEATURE_SMBUS_PEC) && (flags & I2C_CLIENT_PEC)
 		&& size != I2C_SMBUS_QUICK
 		&& size != I2C_SMBUS_I2C_BLOCK_DATA;
@@ -773,7 +776,8 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 	default:
 		dev_err(&priv->pci_dev->dev, "Unsupported transaction %d\n",
 			size);
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto out;
 	}
 
 	if (hwpec)	/* enable/disable hardware PEC */
@@ -796,11 +800,11 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 		       ~(SMBAUXCTL_CRC | SMBAUXCTL_E32B), SMBAUXCTL(priv));
 
 	if (block)
-		return ret;
+		goto out;
 	if (ret)
-		return ret;
+		goto out;
 	if ((read_write == I2C_SMBUS_WRITE) || (xact == I801_QUICK))
-		return 0;
+		goto out;
 
 	switch (xact & 0x7f) {
 	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
@@ -812,7 +816,11 @@ static s32 i801_access(struct i2c_adapter *adap, u16 addr,
 			     (inb_p(SMBHSTDAT1(priv)) << 8);
 		break;
 	}
-	return 0;
+
+out:
+	pm_runtime_mark_last_busy(&priv->pci_dev->dev);
+	pm_runtime_put_autosuspend(&priv->pci_dev->dev);
+	return ret;
 }
 
 
@@ -1411,6 +1419,11 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	pci_set_drvdata(dev, priv);
 
+	pm_runtime_set_autosuspend_delay(&dev->dev, 1000);
+	pm_runtime_use_autosuspend(&dev->dev);
+	pm_runtime_put_autosuspend(&dev->dev);
+	pm_runtime_allow(&dev->dev);
+
 	return 0;
 }
 
@@ -1418,6 +1431,9 @@ static void i801_remove(struct pci_dev *dev)
 {
 	struct i801_priv *priv = pci_get_drvdata(dev);
 
+	pm_runtime_forbid(&dev->dev);
+	pm_runtime_get_noresume(&dev->dev);
+
 	i801_del_mux(priv);
 	i2c_del_adapter(&priv->adapter);
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
-- 
2.7.0
