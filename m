From: dirk.brandewie@gmail.com
Subject: [PATCH 09/13] i2c-designware: Support multiple cores using same ISR
Date: Thu,  9 Jun 2011 12:21:46 -0700
Message-ID: <1307647310-24332-10-git-send-email-dirk.brandewie@gmail.com>
References: <1307647310-24332-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307647310-24332-1-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie@gmail.com>

Add check to make sure that the core is enabled and has outstanding
interrupts. The activity bit is masked due to the fact that it will
stay active even after the controller has been disabled until the
contoller internal state machines have settled.

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/i2c/busses/i2c-designware-core.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 9de672f..11909eb 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -521,10 +521,16 @@ static u32 i2c_dw_read_clear_intrbits(struct dw_i2c_dev *dev)
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
