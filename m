From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 2/3] i2c: designware-pci: update Intel copytight line
Date: Thu, 22 Jan 2015 16:44:28 +0200
Message-ID: <1421937869-28376-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1421937869-28376-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421937869-28376-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

While here, fix few indentations issues across the code. There is no functional
change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index 9237abb..2bbd2a7 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2006 Texas Instruments.
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
- * Copyright (C) 2011 Intel corporation.
+ * Copyright (C) 2011,2015 Intel Corporation.
  *
  * ----------------------------------------------------------------------------
  *
@@ -92,7 +92,7 @@ static struct dw_scl_sda_cfg hsw_config = {
 	.sda_hold = 0x9,
 };
 
-static struct  dw_pci_controller  dw_pci_controllers[] = {
+static struct dw_pci_controller dw_pci_controllers[] = {
 	[moorestown] = {
 		.bus_num = -1,
 		.bus_cfg = INTEL_MID_STD_CFG | DW_IC_CON_SPEED_FAST,
@@ -201,7 +201,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	dev->functionality = controller->functionality |
 				DW_DEFAULT_FUNCTIONALITY;
 
-	dev->master_cfg =  controller->bus_cfg;
+	dev->master_cfg = controller->bus_cfg;
 	if (controller->scl_sda_cfg) {
 		cfg = controller->scl_sda_cfg;
 		dev->ss_hcnt = cfg->ss_hcnt;
@@ -290,7 +290,7 @@ static const struct pci_device_id i2_designware_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x9c61), haswell },
 	{ PCI_VDEVICE(INTEL, 0x9c62), haswell },
 	/* Braswell / Cherrytrail */
-	{ PCI_VDEVICE(INTEL, 0x22C1), baytrail,},
+	{ PCI_VDEVICE(INTEL, 0x22C1), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x22C2), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x22C3), baytrail },
 	{ PCI_VDEVICE(INTEL, 0x22C4), baytrail },
-- 
2.1.4
