From: Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c: thunderx: Replace pci_enable_msix()
Date: Tue, 21 Feb 2017 14:07:50 +0100
Message-ID: <20170221130750.32277-1-jglauber@cavium.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34874 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbdBUNIP (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 21 Feb 2017 08:08:15 -0500
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Jan Glauber <jglauber@cavium.com>

Using pci_alloc_irq_vectors() instead of the deprecated
pci_enable_msix() allows to remove the msix_entry from
struct octeon_i2c and thus to get rid of the config symbol check.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.h     | 4 ----
 drivers/i2c/busses/i2c-thunderx-pcidrv.c | 6 +++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
index e160f83..aa3c8f4 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -6,7 +6,6 @@
 #include <linux/i2c-smbus.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/pci.h>
 
 /* Controller command patterns */
 #define SW_TWSI_V		BIT_ULL(63)	/* Valid bit */
@@ -118,9 +117,6 @@ struct octeon_i2c {
 	void (*hlc_int_disable)(struct octeon_i2c *);
 	atomic_t int_enable_cnt;
 	atomic_t hlc_int_enable_cnt;
-#if IS_ENABLED(CONFIG_I2C_THUNDERX)
-	struct msix_entry i2c_msix;
-#endif
 	struct i2c_smbus_alert_setup alert_data;
 	struct i2c_client *ara;
 };
diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index bba5b42..1d4c2be 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -188,11 +188,11 @@ static int thunder_i2c_probe_pci(struct pci_dev *pdev,
 	i2c->hlc_int_enable = thunder_i2c_hlc_int_enable;
 	i2c->hlc_int_disable = thunder_i2c_hlc_int_disable;
 
-	ret = pci_enable_msix(pdev, &i2c->i2c_msix, 1);
-	if (ret)
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	if (ret < 0)
 		goto error;
 
-	ret = devm_request_irq(dev, i2c->i2c_msix.vector, octeon_i2c_isr, 0,
+	ret = devm_request_irq(dev, pci_irq_vector(pdev, 0), octeon_i2c_isr, 0,
 			       DRV_NAME, i2c);
 	if (ret)
 		goto error;
-- 
2.9.0.rc0.21.g7777322
