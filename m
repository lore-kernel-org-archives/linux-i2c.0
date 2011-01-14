From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 9/9] i2c-designware: Support multiple cores using same ISR
Date: Fri, 14 Jan 2011 11:27:36 -0800
Message-ID: <1295033256-30077-10-git-send-email-dirk.brandewie@gmail.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Add check to make sure that the core is enabled and has outstanding
interrupts. The activity bit is masked due to the fact that it will
stay active even after the contoller has bee disabled until the
contoller internal state machinces have settled.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index e8b354b..c92feb5 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -546,10 +546,16 @@ u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
 irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
 {
 	struct dw_i2c_dev *dev = dev_id;
-	u32 stat;
+	u32 stat, enabled;
+
+	enabled = dw_readl(dev, DW_IC_ENABLE);
+	stat = dw_readl(dev, DW_IC_RAW_INTR_STAT);
+	dev_dbg(dev->dev, "%s:  %s enabled= 0x%x stat=0x%x\n", __func__,
+		dev->adapter.name, enabled, stat);
+	if (!enabled || !(stat & ~DW_IC_INTR_ACTIVITY))
+		return IRQ_NONE;
 
 	stat = i2c_dw_read_clear_intrbits(dev);
-	dev_dbg(dev->dev, "%s: stat=0x%x\n", __func__, stat);
 
 	if (stat & DW_IC_INTR_TX_ABRT) {
 		dev->cmd_err |= DW_IC_ERR_TX_ABRT;
-- 
1.7.3.4
