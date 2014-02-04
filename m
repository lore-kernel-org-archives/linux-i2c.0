From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] i2c: designware-pci: Add CONFIG_PM_RUNTIME to
 i2c_dw_pci_runtime_idle()
Date: Tue, 04 Feb 2014 14:50:46 +0900
Message-ID: <000301cf216d$0d08b4e0$271a1ea0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Mika Westerberg' <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, 'Andy Shevchenko' <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Add CONFIG_PM_RUNTIME to i2c_dw_pci_runtime_idle() to fix the
build warning when CONFIG_PM_RUNTIME is not selected. This is
because runtime PM callbacks defined by SET_RUNTIME_PM_OPS are
only used when the CONFIG_PM_RUNTIME is enabled.

drivers/i2c/busses/i2c-designware-pcidrv.c:188:12: warning: 'i2c_dw_pci_runtime_idle' defined but not used [-Wunused-function]

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index f6ed06c..2b5d3a6 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -185,6 +185,7 @@ static int i2c_dw_pci_resume(struct device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
 static int i2c_dw_pci_runtime_idle(struct device *dev)
 {
 	int err = pm_schedule_suspend(dev, 500);
@@ -194,6 +195,7 @@ static int i2c_dw_pci_runtime_idle(struct device *dev)
 		return 0;
 	return -EBUSY;
 }
+#endif
 
 static const struct dev_pm_ops i2c_dw_pm_ops = {
 	.resume         = i2c_dw_pci_resume,
-- 
1.7.10.4
