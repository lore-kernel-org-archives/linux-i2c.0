From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 09/13] i2c-designware: Support multiple cores using same ISR
Date: Thu, 10 Feb 2011 08:21:25 -0800
Message-ID: <1297354889-20721-10-git-send-email-dirk.brandewie@gmail.com>
References: <1297354889-20721-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297354889-20721-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
index d521b43..fce72e9 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -520,10 +520,16 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
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
