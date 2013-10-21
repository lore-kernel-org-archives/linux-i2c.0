From: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 2/2] i2c-designware-pci: Index Haswell ULT bus names from 0
Date: Sun, 20 Oct 2013 20:26:50 -0700
Message-ID: <1382326010-4554-3-git-send-email-bleung@chromium.org>
References: <1382326010-4554-1-git-send-email-bleung@chromium.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382326010-4554-1-git-send-email-bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dlaurie-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Rather than having the bus names be "i2c-designware-pci--1" because
we have set the .bus_num to -1 to force dynamic allocation, lets have
the busses named "i2c-designware-pci-0" and "i2c-designware-pci-1"
to correspond to the correct names of these busses.

The adapter number will still be dynamically assigned.

Signed-off-by: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index e4cbbdf..d08b2d9 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -229,7 +229,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 {
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
-	int r;
+	int r, adapter_num;
 	struct  dw_pci_controller *controller;
 
 	if (id->driver_data >= ARRAY_SIZE(dw_pci_controllers)) {
@@ -287,8 +287,18 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	adap->algo = &i2c_dw_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->nr = controller->bus_num;
-	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci-%d",
-		adap->nr);
+
+	switch (id->driver_data) {
+	case haswell_0:
+	case haswell_1:
+		adapter_num = id->driver_data - haswell_0;
+		break;
+	default:
+		adapter_num = adap->nr;
+		break;
+	}
+	snprintf(adap->name, sizeof(adap->name), "i2c-designware-pci-%ld",
+		 adapter_num);
 
 	r = devm_request_irq(&pdev->dev, pdev->irq, i2c_dw_isr, IRQF_SHARED,
 			adap->name, dev);
-- 
1.8.3.2
