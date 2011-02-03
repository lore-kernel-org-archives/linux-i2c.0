From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 03/10] i2c-designware: retrieve clock frequency based CONFIG_HAVE_CLK
Date: Wed,  2 Feb 2011 18:20:01 -0800
Message-ID: <1296699608-13227-4-git-send-email-dirk.brandewie@gmail.com>
References: <1296699608-13227-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1296699608-13227-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

x86 does not have clk_dev support.  The PCI variant of the driver sets
the clock rate being supplied to the IP block based on config
information attached to the PCI ID

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |   14 ++++++++++++--
 drivers/i2c/busses/i2c-designware-core.h |    1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index a0d1ea3..ba0683d 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -58,6 +58,15 @@ static char *abort_sources[] = {
 		"lost arbitration",
 };
 
+u32 i2c_dw_clk_get_rate(struct dw_i2c_dev *dev)
+{
+#ifndef CONFIG_HAVE_CLK
+	return dev->clk_khz;
+#else
+	return clk_get_rate(dev->clk)/1000;
+#endif
+}
+
 u32 dw_readl(struct dw_i2c_dev *dev, int offset)
 {
 	u32 value = readl(dev->base + offset);
@@ -76,7 +85,6 @@ void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 	writel(b, dev->base + offset);
 }
 
-
 static u32
 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
@@ -142,10 +150,12 @@ static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
  */
 int i2c_dw_init(struct dw_i2c_dev *dev)
 {
-	u32 input_clock_khz = clk_get_rate(dev->clk) / 1000;
+	u32 input_clock_khz;
 	u32 ic_con, hcnt, lcnt;
 	u32 reg;
 
+	input_clock_khz = i2c_dw_clk_get_rate(dev);
+
 	/* Configure register endianess access */
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 4e37031..596f069 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -166,6 +166,7 @@ struct dw_i2c_dev {
 	struct completion	cmd_complete;
 	struct mutex		lock;
 	struct clk		*clk;
+	u32			clk_khz;
 	int			cmd_err;
 	struct i2c_msg		*msgs;
 	int			msgs_num;
-- 
1.7.3.4
