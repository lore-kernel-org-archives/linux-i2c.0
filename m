From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: davinci: Optimize SCL generation
Date: Thu, 11 Jun 2015 11:35:26 +0200
Message-ID: <5579565E.1020908@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "Lawnick, Michael (Nokia - DE/Ulm)" <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There are several cases where current clock configuration algorithm produces
not optimal results:
- truncation in "clk" calculation leads to the fact that actual BUS frequency
  will be always higher than spec except two exact module frequences 8MHz and
  12MHz in the whole 7-12MHz range of permitted frequences
- driver configures SCL HIGH to LOW ratio always 1 to 1 and this doesn't work
  well in 400kHz case, namely minimum time of LOW state (according to I2C Spec
  2.1) 1.3us will not be fulfilled. HIGH to LOW ratio 1 to 2 would be more
  approriate here.

Signed-off-by: Michael Lawnick <michael.lawnick-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---

Tested on custom Keystone II SoC-based board with complicated I2C network
working on the edge of its HW specs (signal quality). In this case 1 to 2
HIGH to LOW relation really improves the reliability with 400kHz bus rate.

 drivers/i2c/busses/i2c-davinci.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index e35c9df..4a110af 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -211,9 +211,30 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 		psc++;	/* better to run under spec than over */
 	d = (psc >= 2) ? 5 : 7 - psc;

-	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000)) - (d << 1);
-	clkh = clk >> 1;
-	clkl = clk - clkh;
+	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000));
+	/* Avoid driving the bus too fast because of rounding errors above */
+	if (input_clock / (psc + 1) / clk > pdata->bus_freq * 1000)
+		clk++;
+	/*
+	 * According to I2C-BUS Spec 2.1, in FAST-MODE LOW period should be at
+	 * least 1.3uS, which is not the case with 50% duty cycle. Driving HIGH
+	 * to LOW ratio as 1 to 2 is more safe.
+	 */
+	if (pdata->bus_freq > 100)
+		clkl = (clk << 1) / 3;
+	else
+		clkl = (clk >> 1);
+	/*
+	 * It's not always possible to have 1 to 2 ratio when d=7, so fall back
+	 * to minimal possible clkh in this case.
+	 */
+	if (clk >= clkl + d) {
+		clkh = clk - clkl - d;
+		clkl -= d;
+	} else {
+		clkh = 0;
+		clkl = clk - (d << 1);
+	}

 	davinci_i2c_write_reg(dev, DAVINCI_I2C_PSC_REG, psc);
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CLKH_REG, clkh);
