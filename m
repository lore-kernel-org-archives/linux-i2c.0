From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] i2c: designware-pci: Sort header block alphabetically
Date: Wed, 15 Jun 2016 01:56:00 +0300
Message-ID: <1465944960-25444-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:52921 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbcFNW4Y (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 14 Jun 2016 18:56:24 -0400
In-Reply-To: <1465944960-25444-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Simply sort header block alphabetically.

While here fix an indentation in one place and update a copyright line for
Intel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-pcidrv.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-pcidrv.c b/drivers/i2c/busses/i2c-designware-pcidrv.c
index a51f6e0..f3c9e0d 100644
--- a/drivers/i2c/busses/i2c-designware-pcidrv.c
+++ b/drivers/i2c/busses/i2c-designware-pcidrv.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2006 Texas Instruments.
  * Copyright (C) 2007 MontaVista Software Inc.
  * Copyright (C) 2009 Provigent Ltd.
- * Copyright (C) 2011, 2015 Intel Corporation.
+ * Copyright (C) 2011, 2015, 2016 Intel Corporation.
  *
  * ----------------------------------------------------------------------------
  *
@@ -23,19 +23,20 @@
  *
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/acpi.h>
 #include <linux/delay.h>
-#include <linux/i2c.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
-#include <linux/slab.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
-#include <linux/acpi.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
 #include "i2c-designware-core.h"
 
 #define DRIVER_NAME "i2c-designware-pci"
@@ -198,7 +199,7 @@ static int i2c_dw_pci_probe(struct pci_dev *pdev,
 	struct dw_i2c_dev *dev;
 	struct i2c_adapter *adap;
 	int r;
-	struct  dw_pci_controller *controller;
+	struct dw_pci_controller *controller;
 	struct dw_scl_sda_cfg *cfg;
 
 	if (id->driver_data >= ARRAY_SIZE(dw_pci_controllers)) {
-- 
2.8.1
