From: dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 06/13] i2c-designware: Move retriveving the clock speed out of core code.
Date: Thu, 10 Feb 2011 08:21:22 -0800
Message-ID: <1297354889-20721-7-git-send-email-dirk.brandewie@gmail.com>
References: <1297354889-20721-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297354889-20721-1-git-send-email-dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

The clock frequecy supplied to the IP core is specific to a single
instance of the driver.  This patch makes it possible to have multiple
Designware I2C cores in the system possibly running at different core
frequencies.

Signed-off-by: Dirk Brandewie <dirk.brandewie-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware-core.c    |    5 +++--
 drivers/i2c/busses/i2c-designware-core.h    |    1 +
 drivers/i2c/busses/i2c-designware-platdrv.c |    6 ++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/busses/i2c-designware-core.c
index c2141d9..84f6d02 100644
--- a/drivers/i2c/busses/i2c-designware-core.c
+++ b/drivers/i2c/busses/i2c-designware-core.c
@@ -76,7 +76,6 @@ void dw_writel(struct dw_i2c_dev *dev, u32 b, int offset)
 	writel(b, dev->base + offset);
 }
 
-
 static u32
 i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
 {
@@ -142,10 +141,12 @@ static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
  */
 int i2c_dw_init(struct dw_i2c_dev *dev)
 {
-	u32 input_clock_khz = clk_get_rate(dev->clk) / 1000;
+	u32 input_clock_khz;
 	u32 ic_con, hcnt, lcnt;
 	u32 reg;
 
+	input_clock_khz = dev->get_clk_rate_khz(dev);
+
 	/* Configure register endianess access */
 	reg = dw_readl(dev, DW_IC_COMP_TYPE);
 	if (reg == ___constant_swab32(DW_IC_COMP_TYPE_VALUE)) {
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 4e37031..43de340 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -166,6 +166,7 @@ struct dw_i2c_dev {
 	struct completion	cmd_complete;
 	struct mutex		lock;
 	struct clk		*clk;
+	u32			(*get_clk_rate_khz) (struct dw_i2c_dev *dev);
 	int			cmd_err;
 	struct i2c_msg		*msgs;
 	int			msgs_num;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 9d10ae8..08783a6 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -43,6 +43,10 @@ static struct i2c_algorithm i2c_dw_algo = {
 	.master_xfer	= i2c_dw_xfer,
 	.functionality	= i2c_dw_func,
 };
+static u32 i2c_dw_get_clk_rate_khz(struct dw_i2c_dev *dev)
+{
+	return clk_get_rate(dev->clk)/1000;
+}
 
 static int __devinit dw_i2c_probe(struct platform_device *pdev)
 {
@@ -84,6 +88,8 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 
 	dev->clk = clk_get(&pdev->dev, NULL);
+	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
+
 	if (IS_ERR(dev->clk)) {
 		r = -ENODEV;
 		goto err_free_mem;
-- 
1.7.3.4
