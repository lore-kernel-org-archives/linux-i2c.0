From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/2] i2c-designware: always clear interrupts before enabling them
Date: Mon, 13 May 2013 13:54:30 +0300
Message-ID: <1368442471-7582-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

If the I2C bus is put to a low power state by an ACPI method it might pull
the SDA line low (as its power is removed). Once the bus is put to full
power state again, the SDA line is pulled back to high. This transition
looks like a STOP condition from the controller point-of-view which sets
STOP detected bit in its status register causing the driver to fail
subsequent transfers.

Fix this by always clearing all interrupts before we start a transfer.

Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 21fbb34..7a89ca5 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -383,7 +383,8 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *dev)
 	/* Enable the adapter */
 	__i2c_dw_enable(dev, true);
 
-	/* Enable interrupts */
+	/* Clear and enable interrupts */
+	i2c_dw_clear_int(dev);
 	dw_writel(dev, DW_IC_INTR_DEFAULT_MASK, DW_IC_INTR_MASK);
 }
 
-- 
1.7.10.4
