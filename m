From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 2/7] i2c-designware-pci: use dev_err() instead of printk()
Date: Wed, 10 Apr 2013 13:36:37 +0300
Message-ID: <1365590202-1623-2-git-send-email-mika.westerberg@linux.intel.com>
References: <1365590202-1623-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1365590202-1623-1-git-send-email-mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

With dev_err() we can get the device instance printed as well and is pretty
much standard to use dev_* macros in the drivers anyway. In addition
correct the indentation of probe() arguments.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 7c5e383..eed149d 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -208,7 +208,7 @@ static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
 }
 
 static int i2c_dw_pci_probe(struct pci_dev *pdev,
-const struct pci_device_id *id)
+			    const struct pci_device_id *id)
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
@@ -218,7 +218,7 @@ const struct pci_device_id *id)
 	struct  dw_pci_controller *controller;
 
 	if (id->driver_data >= ARRAY_SIZE(dw_pci_controllers)) {
-		printk(KERN_ERR "dw_i2c_pci_probe: invalid driver data %ld\n",
+		dev_err(&pdev->dev, "%s: invalid driver data %ld\n", __func__,
 			id->driver_data);
 		return -EINVAL;
 	}
-- 
1.7.10.4
