From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 05/13] clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support
Date: Tue, 13 Aug 2019 18:20:40 +0200
Message-ID: <1565713248-4906-6-git-send-email-wahrenst@gmx.net>
References: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1565713248-4906-1-git-send-email-wahrenst@gmx.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The new BCM2711 supports an additional clock for the emmc2 block.
So add a new compatible and register this clock only for BCM2711.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/bcm/clk-bcm2835.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 21cd952..fdf672a 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -114,6 +114,8 @@
 #define CM_AVEODIV		0x1bc
 #define CM_EMMCCTL		0x1c0
 #define CM_EMMCDIV		0x1c4
+#define CM_EMMC2CTL		0x1d0
+#define CM_EMMC2DIV		0x1d4

 /* General bits for the CM_*CTL regs */
 # define CM_ENABLE			BIT(4)
@@ -290,7 +292,8 @@
 #define BCM2835_MAX_FB_RATE	1750000000u

 #define SOC_BCM2835		BIT(0)
-#define SOC_ALL			(SOC_BCM2835)
+#define SOC_BCM2711		BIT(1)
+#define SOC_ALL			(SOC_BCM2835 | SOC_BCM2711)

 /*
  * Names of clocks used within the driver that need to be replaced
@@ -2003,6 +2006,16 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.frac_bits = 8,
 		.tcnt_mux = 39),

+	/* EMMC2 clock (only available for BCM2711) */
+	[BCM2711_CLOCK_EMMC2]	= REGISTER_PER_CLK(
+		SOC_BCM2711,
+		.name = "emmc2",
+		.ctl_reg = CM_EMMC2CTL,
+		.div_reg = CM_EMMC2DIV,
+		.int_bits = 4,
+		.frac_bits = 8,
+		.tcnt_mux = 42),
+
 	/* General purpose (GPIO) clocks */
 	[BCM2835_CLOCK_GP0]	= REGISTER_PER_CLK(
 		SOC_ALL,
@@ -2238,8 +2251,13 @@ static const struct cprman_plat_data cprman_bcm2835_plat_data = {
 	.soc = SOC_BCM2835,
 };

+static const struct cprman_plat_data cprman_bcm2711_plat_data = {
+	.soc = SOC_BCM2711,
+};
+
 static const struct of_device_id bcm2835_clk_of_match[] = {
 	{ .compatible = "brcm,bcm2835-cprman", .data = &cprman_bcm2835_plat_data },
+	{ .compatible = "brcm,bcm2711-cprman", .data = &cprman_bcm2711_plat_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, bcm2835_clk_of_match);
--
2.7.4
