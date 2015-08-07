From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] i2c: designware: Remove adapter name from debug print in i2c_dw_isr()
Date: Fri,  7 Aug 2015 13:43:28 +0300
Message-ID: <1438944208-16276-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1438944208-16276-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1438944208-16276-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Printing adapter name is irrelevant from this debug print and makes output
needlessly long. Having already device and functions names printed here is
enough for debugging.

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 7310051d4a50..cc98b2a75591 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -777,8 +777,8 @@ irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 
 	enabled = dw_readl(dev, DW_IC_ENABLE);
 	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
-	dev_dbg(dev->dev, "%s:  %s enabled=%#x stat=%#x\n", __func__,
-		dev->adapter.name, enabled, stat);
+	dev_dbg(dev->dev, "%s: enabled=%#x stat=%#x\n", __func__,
+		enabled, stat);
 	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
 		return IRQ_NONE;
 
-- 
2.4.6
