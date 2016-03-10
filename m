From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 1/2] i2c: i801: Convert to struct dev_pm_ops for suspend/resume
Date: Thu, 10 Mar 2016 14:12:21 +0200
Message-ID: <1457611942-8405-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1457611942-8405-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:17470 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbcCJMMc (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 10 Mar 2016 07:12:32 -0500
In-Reply-To: <1457611942-8405-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Reinette Chatre <reinette.chatre@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>

Stop using legacy PCI PM support and convert to standard dev_pm_ops.
This provides more straightforward path to add runtime PM.

While at it remove explicit PCI power state control and configuration space
save/restore as the PCI core does it.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 drivers/i2c/busses/i2c-i801.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f62d69799a9c..091debf7c9de 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1431,34 +1431,32 @@ static void i801_remove(struct pci_dev *dev)
 }
 
 #ifdef CONFIG_PM
-static int i801_suspend(struct pci_dev *dev, pm_message_t mesg)
+static int i801_suspend(struct device *dev)
 {
-	struct i801_priv *priv = pci_get_drvdata(dev);
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct i801_priv *priv = pci_get_drvdata(pci_dev);
 
-	pci_save_state(dev);
-	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
-	pci_set_power_state(dev, pci_choose_state(dev, mesg));
+	pci_write_config_byte(pci_dev, SMBHSTCFG, priv->original_hstcfg);
 	return 0;
 }
 
-static int i801_resume(struct pci_dev *dev)
+static int i801_resume(struct device *dev)
 {
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
 	return 0;
 }
-#else
-#define i801_suspend NULL
-#define i801_resume NULL
 #endif
 
+static UNIVERSAL_DEV_PM_OPS(i801_pm_ops, i801_suspend,
+			    i801_resume, NULL);
+
 static struct pci_driver i801_driver = {
 	.name		= "i801_smbus",
 	.id_table	= i801_ids,
 	.probe		= i801_probe,
 	.remove		= i801_remove,
-	.suspend	= i801_suspend,
-	.resume		= i801_resume,
+	.driver		= {
+		.pm	= &i801_pm_ops,
+	},
 };
 
 static int __init i2c_i801_init(void)
-- 
2.7.0
