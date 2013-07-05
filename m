From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH] i2c: mxs: fix broken timing calculation
Date: Fri,  5 Jul 2013 18:28:00 +0200
Message-ID: <1373041680-26939-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The timing calculation is rather bogus and gives extremely wrong
results for higher frequencies (on an i.MX28). E.g. instead of 400 kHz
I measured 770 kHz.

Implement a calculation that adheres to the I2C spec and gives exact
results for I2C frequencies from 12.56 kHz to 960 kHz.

Also the bus_free and leadin parameters are programmed according to
the I2C spec for standard and fast mode.

This was tested on a Ka-Ro TX28 module with a DS1339, TSC2007, PCA9554
and SGTL5000 client.

Signed-off-by: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
---
 drivers/i2c/busses/i2c-mxs.c |   87 ++++++++++++++++++++++++++++++----=
-------
 1 files changed, 63 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.=
c
index df8ff5a..1333456 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -114,9 +114,10 @@ struct mxs_i2c_dev {
=20
 	uint32_t timing0;
 	uint32_t timing1;
+	uint32_t timing2;
=20
 	/* DMA support components */
-	struct dma_chan         	*dmach;
+	struct dma_chan			*dmach;
 	uint32_t			pio_data[2];
 	uint32_t			addr_data;
 	struct scatterlist		sg_io[2];
@@ -136,7 +137,7 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
 	 */
 	writel(i2c->timing0, i2c->regs + MXS_I2C_TIMING0);
 	writel(i2c->timing1, i2c->regs + MXS_I2C_TIMING1);
-	writel(0x00300030, i2c->regs + MXS_I2C_TIMING2);
+	writel(i2c->timing2, i2c->regs + MXS_I2C_TIMING2);
=20
 	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
 }
@@ -577,41 +578,79 @@ static const struct i2c_algorithm mxs_i2c_algo =3D=
 {
 	.functionality =3D mxs_i2c_func,
 };
=20
-static void mxs_i2c_derive_timing(struct mxs_i2c_dev *i2c, int speed)
+static void mxs_i2c_derive_timing(struct mxs_i2c_dev *i2c, uint32_t sp=
eed)
 {
-	/* The I2C block clock run at 24MHz */
+	/* The I2C block clock runs at 24MHz */
 	const uint32_t clk =3D 24000000;
-	uint32_t base;
+	uint32_t divider;
 	uint16_t high_count, low_count, rcv_count, xmit_count;
+	uint32_t bus_free, leadin;
 	struct device *dev =3D i2c->dev;
=20
-	if (speed > 540000) {
-		dev_warn(dev, "Speed too high (%d Hz), using 540 kHz\n", speed);
-		speed =3D 540000;
-	} else if (speed < 12000) {
-		dev_warn(dev, "Speed too low (%d Hz), using 12 kHz\n", speed);
-		speed =3D 12000;
+	divider =3D DIV_ROUND_UP(clk, speed);
+
+	if (divider < 25) {
+		/*
+		 * limit the divider, so that min(low_count, high_count)
+		 * is >=3D 1
+		 */
+		divider =3D 25;
+		dev_warn(dev,
+			"Speed too high (%u.%03u kHz), using %u.%03u kHz\n",
+			speed / 1000, speed % 1000,
+			clk / divider / 1000, clk / divider % 1000);
+	} else if (divider > 1897) {
+		/*
+		 * limit the divider, so that max(low_count, high_count)
+		 * cannot exceed 1023
+		 */
+		divider =3D 1897;
+		dev_warn(dev,
+			"Speed too low (%u.%03u kHz), using %u.%03u kHz\n",
+			speed / 1000, speed % 1000,
+			clk / divider / 1000, clk / divider % 1000);
 	}
=20
 	/*
-	 * The timing derivation algorithm. There is no documentation for thi=
s
-	 * algorithm available, it was derived by using the scope and fiddlin=
g
-	 * with constants until the result observed on the scope was good eno=
ugh
-	 * for 20kHz, 50kHz, 100kHz, 200kHz, 300kHz and 400kHz. It should be
-	 * possible to assume the algorithm works for other frequencies as we=
ll.
+	 * The I2C spec specifies the following timing data:
+	 *                          standard mode  fast mode Bitfield name
+	 * tLOW (SCL LOW period)     4700 ns        1300 ns
+	 * tHIGH (SCL HIGH period)   4000 ns         600 ns
+	 * tSU;DAT (data setup time)  250 ns         100 ns
+	 * tHD;STA (START hold time) 4000 ns         600 ns
+	 * tBUF (bus free time)      4700 ns        1300 ns
 	 *
-	 * Note it was necessary to cap the frequency on both ends as it's no=
t
-	 * possible to configure completely arbitrary frequency for the I2C b=
us
-	 * clock.
+	 * The hardware (of the i.MX28 at least) seems to add 2 additional
+	 * clock cycles to the low_count and 7 cycles to the high_count.
+	 * This is compensated for by subtracting the respective constants
+	 * from the values written to the timing registers.
 	 */
-	base =3D ((clk / speed) - 38) / 2;
-	high_count =3D base + 3;
-	low_count =3D base - 3;
-	rcv_count =3D (high_count * 3) / 4;
-	xmit_count =3D low_count / 4;
+	if (speed > 100000) {
+		/* fast mode */
+		low_count =3D DIV_ROUND_CLOSEST(divider * 13, (13 + 6));
+		high_count =3D DIV_ROUND_CLOSEST(divider * 6, (13 + 6));
+		leadin =3D DIV_ROUND_UP(600 * (clk / 1000000), 1000);
+		bus_free =3D DIV_ROUND_UP(1300 * (clk / 1000000), 1000);
+	} else {
+		/* normal mode */
+		low_count =3D DIV_ROUND_CLOSEST(divider * 47, (47 + 40));
+		high_count =3D DIV_ROUND_CLOSEST(divider * 40, (47 + 40));
+		leadin =3D DIV_ROUND_UP(4700 * (clk / 1000000), 1000);
+		bus_free =3D DIV_ROUND_UP(4700 * (clk / 1000000), 1000);
+	}
+	rcv_count =3D high_count * 3 / 8;
+	xmit_count =3D low_count * 3 / 8;
+
+	dev_dbg(dev,
+		"speed=3D%u(actual %u) divider=3D%u low=3D%u high=3D%u xmit=3D%u rcv=
=3D%u leadin=3D%u bus_free=3D%u\n",
+		speed, clk / divider, divider, low_count, high_count,
+		xmit_count, rcv_count, leadin, bus_free);
=20
+	low_count -=3D 2;
+	high_count -=3D 7;
 	i2c->timing0 =3D (high_count << 16) | rcv_count;
 	i2c->timing1 =3D (low_count << 16) | xmit_count;
+	i2c->timing2 =3D (bus_free << 16 | leadin);
 }
=20
 static int mxs_i2c_get_ofdata(struct mxs_i2c_dev *i2c)
--=20
1.7.2.5
