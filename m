From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/6] i2c: designware: Remove unused functions
Date: Mon, 31 Aug 2015 17:31:30 +0300
Message-ID: <1441031493-18938-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1441031493-18938-1-git-send-email-jarkko.nikula@linux.intel.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441031493-18938-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c_dw_is_enabled() became unused by the commit be58eda775c8
("i2c: designware-pci: Cleanup driver power management") and
i2c_dw_enable() by the commit 3a48d1c08fe0 ("i2c: prevent spurious
interrupt on Designware controllers").

Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c | 13 -------------
 drivers/i2c/busses/i2c-designware-core.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index dec0af7d0471..c9e93a76a455 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -815,19 +815,6 @@ tx_aborted:
 }
 EXPORT_SYMBOL_GPL(i2c_dw_isr);
 
-void i2c_dw_enable(struct dw_i2c_dev *dev)
-{
-       /* Enable the adapter */
-	__i2c_dw_enable(dev, true);
-}
-EXPORT_SYMBOL_GPL(i2c_dw_enable);
-
-u32 i2c_dw_is_enabled(struct dw_i2c_dev *dev)
-{
-	return dw_readl(dev, DW_IC_ENABLE);
-}
-EXPORT_SYMBOL_GPL(i2c_dw_is_enabled);
-
 void i2c_dw_disable(struct dw_i2c_dev *dev)
 {
 	/* Disable controller */
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index f44aeeeb91c6..10c79038834d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -119,8 +119,6 @@ extern int i2c_dw_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 		int num);
 extern u32 i2c_dw_func(struct i2c_adapter *adap);
 extern irqreturn_t i2c_dw_isr(int this_irq, void *dev_id);
-extern void i2c_dw_enable(struct dw_i2c_dev *dev);
-extern u32 i2c_dw_is_enabled(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable(struct dw_i2c_dev *dev);
 extern void i2c_dw_disable_int(struct dw_i2c_dev *dev);
 extern u32 i2c_dw_read_comp_param(struct dw_i2c_dev *dev);
-- 
2.5.0
