From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] i2c: i801: mark PM functions as __maybe_unused
Date: Fri, 25 May 2018 23:09:46 +0200
Message-ID: <20180525210952.1861881-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Changing from UNIVERSAL_DEV_PM_OPS to SIMPLE_DEV_PM_OPS caused a harmless
warning in configurations without CONFIG_PM_SLEEP:

drivers/i2c/busses/i2c-i801.c:1723:12: error: 'i801_resume' defined but not used [-Werror=unused-function]
 static int i801_resume(struct device *dev)
            ^~~~~~~~~~~
drivers/i2c/busses/i2c-i801.c:1714:12: error: 'i801_suspend' defined but not used [-Werror=unused-function]
 static int i801_suspend(struct device *dev)

This removes the incorrect #ifdef and instead marks both functions as
__maybe_unused, which is a more robust way to express the same thing.

Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/i2c/busses/i2c-i801.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index ed07f9002710..d6d46e7a5376 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1710,8 +1710,7 @@ static void i801_shutdown(struct pci_dev *dev)
 	pci_write_config_byte(dev, SMBHSTCFG, priv->original_hstcfg);
 }
 
-#ifdef CONFIG_PM
-static int i801_suspend(struct device *dev)
+static int __maybe_unused i801_suspend(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
@@ -1720,7 +1719,7 @@ static int i801_suspend(struct device *dev)
 	return 0;
 }
 
-static int i801_resume(struct device *dev)
+static int __maybe_unused i801_resume(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct i801_priv *priv = pci_get_drvdata(pci_dev);
@@ -1729,7 +1728,6 @@ static int i801_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(i801_pm_ops, i801_suspend, i801_resume);
 
-- 
2.9.0
