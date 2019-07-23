From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] i2c: busses: Use dev_get_drvdata where possible
Date: Tue, 23 Jul 2019 19:11:10 +0800
Message-ID: <20190723111110.11121-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-i2c@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 6 ++----
 drivers/i2c/busses/i2c-i801.c              | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 76810deb2de6..7d2e6959679c 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -173,8 +173,7 @@ static struct dw_pci_controller dw_pci_controllers[] = {
 #ifdef CONFIG_PM
 static int i2c_dw_pci_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
+	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 
 	i_dev->suspended = true;
 	i_dev->disable(i_dev);
@@ -184,8 +183,7 @@ static int i2c_dw_pci_suspend(struct device *dev)
 
 static int i2c_dw_pci_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_i2c_dev *i_dev = pci_get_drvdata(pdev);
+	struct dw_i2c_dev *i_dev = dev_get_drvdata(dev);
 	int ret;
 
 	ret = i_dev->init(i_dev);
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index f2956936c3f2..a6469978e735 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1912,8 +1912,7 @@ static int i801_suspend(struct device *dev)
 
 static int i801_resume(struct device *dev)
 {
-	struct pci_dev *pci_dev = to_pci_dev(dev);
-	struct i801_priv *priv = pci_get_drvdata(pci_dev);
+	struct i801_priv *priv = dev_get_drvdata(dev);
 
 	i801_enable_host_notify(&priv->adapter);
 
-- 
2.20.1
