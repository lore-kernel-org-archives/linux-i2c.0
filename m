From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 3/9] i2c-designware: retrieve clock frequency based CONFIG_HAVE_CLK
Date: Fri, 14 Jan 2011 11:27:30 -0800
Message-ID: <1295033256-30077-4-git-send-email-dirk.brandewie@gmail.com>
References: <1295033256-30077-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1295033256-30077-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

x86 does not have clk_dev support.  The PCI variant of the driver sets
the clock rate being supplied to the IP block based on config
information attached to the PCI ID


Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c |   14 +++++++++++++-
 drivers/i2c/busses/i2c-designware-core.h |    1 +
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index 9dca409..b7102df 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -39,6 +39,16 @@
 #include <linux/slab.h>
 #include "i2c-designware-core.h"
 
+static u32 i2c_dw_clk_get_rate(struct dw_i2c_dev *dev)
+{
+#ifndef CONFIG_HAVE_CLK
+	return dev->clk_khz;
+#else
+	return clk_get_rate(dev->clk)/1000;
+#endif
+}
+
+
 static char *abort_sources[] = {
 	[ABRT_7B_ADDR_NOACK] =
 		"slave address not acknowledged (7bit mode)",
@@ -130,9 +140,11 @@ u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
 void
 i2c_dw_init(struct dw_i2c_dev *dev)
 {
-	u32 input_clock_khz = clk_get_rate(dev->clk) / 1000;
+	u32 input_clock_khz;
 	u32 ic_con, hcnt, lcnt;
 
+	input_clock_khz = i2c_dw_clk_get_rate(dev);
+
 	/* Disable the adapter */
 	writel(0, dev->base + DW_IC_ENABLE);
 
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 9558ef2..f2182a9 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -178,6 +178,7 @@ struct dw_i2c_dev {
 	struct completion	cmd_complete;
 	struct mutex		lock;
 	struct clk		*clk;
+	u32			clk_khz;
 	int			cmd_err;
 	struct i2c_msg		*msgs;
 	int			msgs_num;
-- 
1.7.3.4
