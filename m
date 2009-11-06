From: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 07/22] i2c-designware: Improved _HCNT/_LCNT calculation
Date: Fri, 06 Nov 2009 21:47:01 +0900
Message-ID: <4AF41AC5.7010705@necel.com>
References: <4AF419B6.1000802@necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AF419B6.1000802-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

* Calculate with accurate conditional expressions from DW manuals.
* Round ic_clk by adding 0.5 as it's important at high ic_clk rate.
* Take into account "tHD;STA" issue for _HCNT calculation.
* Take into account "tf" for _LCNT calculation.
* Add "cond" and "offset" fot further correction requirements.

For _HCNT calculation, there's one issue needs to be carefully
considered; DesignWare I2C core doesn't seem to have solid strategy
to meet the tHD;STA timing spec.  If you configure _HCNT based on the
tHIGH timing spec, it easily results in violation of the tHD;STA spec.

After many trials, we came to the conclusion that the tHD;STA period
is proportional to (_HCNT + 3).  For the safety's sake, this should be
selected by default.

As for _LCNT calculation, DW I2C core has one characteristic behavior;
he starts counting the SCL CNTs for the LOW period of the SCL clock
(tLOW) as soon as it pulls the SCL line.  At that time, he doesn't take
into account the fall time of SCL signal (tf), IOW, he starts counting
CNTs without confirming the SCL input voltage has dropped to below VIL.

This characteristics becomes a problem on some platforms where tf is
considerably long, and results in violation of the tLOW timing spec.

To make the driver configurable as much as possible for various cases,
we'd have separated arguments "tf" and "offset", and for safety default
values should be 0.3 us and 0, respectively.

Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi-jaWZhaxaiAMAvxtiuMwx3w@public.gmane.org>
Acked-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/i2c/busses/i2c-designware.c |   93 +++++++++++++++++++++++++++++++---
 1 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware.c b/drivers/i2c/busses/i2c-designware.c
index fd1616b..cdfd94e 100644
--- a/drivers/i2c/busses/i2c-designware.c
+++ b/drivers/i2c/busses/i2c-designware.c
@@ -196,6 +196,61 @@ struct dw_i2c_dev {
 	unsigned int		rx_fifo_depth;
 };
 
+static u32
+i2c_dw_scl_hcnt(u32 ic_clk, u32 tSYMBOL, u32 tf, int cond, int offset)
+{
+	/*
+	 * DesignWare I2C core doesn't seem to have solid strategy to meet
+	 * the tHD;STA timing spec.  Configuring _HCNT based on tHIGH spec
+	 * will result in violation of the tHD;STA spec.
+	 */
+	if (cond)
+		/*
+		 * Conditional expression:
+		 *
+		 *   IC_[FS]S_SCL_HCNT + (1+4+3) >= IC_CLK * tHIGH
+		 *
+		 * This is based on the DW manuals, and represents an ideal
+		 * configuration.  The resulting I2C bus speed will be
+		 * faster than any of the others.
+		 *
+		 * If your hardware is free from tHD;STA issue, try this one.
+		 */
+		return (ic_clk * tSYMBOL + 5000) / 10000 - 8 + offset;
+	else
+		/*
+		 * Conditional expression:
+		 *
+		 *   IC_[FS]S_SCL_HCNT + 3 >= IC_CLK * (tHD;STA + tf)
+		 *
+		 * This is just experimental rule; the tHD;STA period turned
+		 * out to be proportinal to (_HCNT + 3).  With this setting,
+		 * we could meet both tHIGH and tHD;STA timing specs.
+		 *
+		 * If unsure, you'd better to take this alternative.
+		 *
+		 * The reason why we need to take into account "tf" here,
+		 * is the same as described in i2c_dw_scl_lcnt().
+		 */
+		return (ic_clk * (tSYMBOL + tf) + 5000) / 10000 - 3 + offset;
+}
+
+static u32 i2c_dw_scl_lcnt(u32 ic_clk, u32 tLOW, u32 tf, int offset)
+{
+	/*
+	 * Conditional expression:
+	 *
+	 *   IC_[FS]S_SCL_LCNT + 1 >= IC_CLK * (tLOW + tf)
+	 *
+	 * DW I2C core starts counting the SCL CNTs for the LOW period
+	 * of the SCL clock (tLOW) as soon as it pulls the SCL line.
+	 * In order to meet the tLOW timing spec, we need to take into
+	 * account the fall time of SCL signal (tf).  Default tf value
+	 * should be 0.3 us, for safety.
+	 */
+	return ((ic_clk * (tLOW + tf) + 5000) / 10000) - 1 + offset;
+}
+
 /**
  * i2c_dw_init() - initialize the designware i2c master hardware
  * @dev: device private data
@@ -207,20 +262,40 @@ struct dw_i2c_dev {
 static void i2c_dw_init(struct dw_i2c_dev *dev)
 {
 	u32 input_clock_khz = clk_get_rate(dev->clk) / 1000;
-	u32 ic_con;
+	u32 ic_con, hcnt, lcnt;
 
 	/* Disable the adapter */
 	writel(0, dev->base + DW_IC_ENABLE);
 
 	/* set standard and fast speed deviders for high/low periods */
-	writel((input_clock_khz * 40 / 10000)+1, /* std speed high, 4us */
-			dev->base + DW_IC_SS_SCL_HCNT);
-	writel((input_clock_khz * 47 / 10000)+1, /* std speed low, 4.7us */
-			dev->base + DW_IC_SS_SCL_LCNT);
-	writel((input_clock_khz *  6 / 10000)+1, /* fast speed high, 0.6us */
-			dev->base + DW_IC_FS_SCL_HCNT);
-	writel((input_clock_khz * 13 / 10000)+1, /* fast speed low, 1.3us */
-			dev->base + DW_IC_FS_SCL_LCNT);
+
+	/* Standard-mode */
+	hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+				40,	/* tHD;STA = tHIGH = 4.0 us */
+				3,	/* tf = 0.3 us */
+				0,	/* 0: DW default, 1: Ideal */
+				0);	/* No offset */
+	lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+				47,	/* tLOW = 4.7 us */
+				3,	/* tf = 0.3 us */
+				0);	/* No offset */
+	writel(hcnt, dev->base + DW_IC_SS_SCL_HCNT);
+	writel(lcnt, dev->base + DW_IC_SS_SCL_LCNT);
+	dev_dbg(dev->dev, "Standard-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
+
+	/* Fast-mode */
+	hcnt = i2c_dw_scl_hcnt(input_clock_khz,
+				6,	/* tHD;STA = tHIGH = 0.6 us */
+				3,	/* tf = 0.3 us */
+				0,	/* 0: DW default, 1: Ideal */
+				0);	/* No offset */
+	lcnt = i2c_dw_scl_lcnt(input_clock_khz,
+				13,	/* tLOW = 1.3 us */
+				3,	/* tf = 0.3 us */
+				0);	/* No offset */
+	writel(hcnt, dev->base + DW_IC_FS_SCL_HCNT);
+	writel(lcnt, dev->base + DW_IC_FS_SCL_LCNT);
+	dev_dbg(dev->dev, "Fast-mode HCNT:LCNT = %d:%d\n", hcnt, lcnt);
 
 	/* configure the i2c master */
 	ic_con = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
-- 
1.6.5.2
