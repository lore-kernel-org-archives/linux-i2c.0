From: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 1/2] i2c: davinci: Optimize clock generation on Keystone
 SoC
Date: Fri, 21 Aug 2015 11:46:55 +0200
Message-ID: <55D6F38F.3050306@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hemanth Guruva Reddy <hemanth.guruva_reddy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Lukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

According to "KeyStone Architecture Inter-IC Control Bus User Guide", fixed
additive part of frequency divisors (referred as "d" in the code and datasheet)
always equals to 6, independent of module clock prescaler.

                         module clock frequency
master clock frequency = ----------------------
                         (ICCL + 6) + (ICCH + 6)

It was not the case with original Davinci IP. Introduce new compatible property
"ti,keystone-i2c", which triggers special handling in the driver.

Without this change Keystone-based systems (having 204.8MHz input clock) choose
prescaler 29 (PSC=28). Using d=5 in this case leads to bus bitrate ~353kHz
instead of requested 400kHz. After correction, assuming d=6 bus rate is ~392kHz.
This gives ~11% transfer rate increase.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Tested-by: Hemanth Guruva Reddy <hemanth.guruva_reddy-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Tested-by: Lukasz Gemborowski <lukasz.gemborowski-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---
 .../devicetree/bindings/i2c/i2c-davinci.txt        |    6 +++---
 drivers/i2c/busses/i2c-davinci.c                   |    8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

Changes in v2:
- Introducing new "compatible" property "ti,keystone-i2c" instead of guessing
  silicon revision from ID registers

diff --git a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
index a4e1cbc..5b123e0 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-davinci.txt
@@ -1,10 +1,10 @@
-* Texas Instruments Davinci I2C
+* Texas Instruments Davinci/Keystone I2C
 
 This file provides information, what the device node for the
-davinci i2c interface contain.
+davinci/keystone i2c interface contains.
 
 Required properties:
-- compatible: "ti,davinci-i2c";
+- compatible: "ti,davinci-i2c" or "ti,keystone-i2c";
 - reg : Offset and length of the register set for the device
 
 Recommended properties :
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 3fbb9a0..c5628a4 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -181,6 +181,7 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	u32 clkh;
 	u32 clkl;
 	u32 input_clock = clk_get_rate(dev->clk);
+	struct device_node *of_node = dev->dev->of_node;
 
 	/* NOTE: I2C Clock divider programming info
 	 * As per I2C specs the following formulas provide prescaler
@@ -196,6 +197,9 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 	 * where if PSC == 0, d = 7,
 	 *       if PSC == 1, d = 6
 	 *       if PSC > 1 , d = 5
+	 *
+	 * Note:
+	 * d is always 6 on Keystone I2C controller
 	 */
 
 	/* get minimum of 7 MHz clock, but max of 12 MHz */
@@ -204,6 +208,9 @@ static void i2c_davinci_calc_clk_dividers(struct davinci_i2c_dev *dev)
 		psc++;	/* better to run under spec than over */
 	d = (psc >= 2) ? 5 : 7 - psc;
 
+	if (of_node && of_device_is_compatible(of_node, "ti,keystone-i2c"))
+		d = 6;
+
 	clk = ((input_clock / (psc + 1)) / (pdata->bus_freq * 1000));
 	/* Avoid driving the bus too fast because of rounding errors above */
 	if (input_clock / (psc + 1) / clk > pdata->bus_freq * 1000)
@@ -726,6 +733,7 @@ static struct i2c_algorithm i2c_davinci_algo = {
 
 static const struct of_device_id davinci_i2c_of_match[] = {
 	{.compatible = "ti,davinci-i2c", },
+	{.compatible = "ti,keystone-i2c", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, davinci_i2c_of_match);
