From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V2 08/13] i2c: bcm2835: Avoid clk stretch quirk for BCM2711
Date: Tue, 13 Aug 2019 18:20:43 +0200
Message-ID: <1565713248-4906-9-git-send-email-wahrenst@gmx.net>
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

The I2C block on the BCM2711 isn't affected by the clock stretching bug.
So there is no need to apply the corresponding quirk.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 67752f7..340da70 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>

@@ -50,6 +51,9 @@
 #define BCM2835_I2C_CDIV_MIN	0x0002
 #define BCM2835_I2C_CDIV_MAX	0xFFFE

+#define NO_STRETCH_BUG	false
+#define STRETCH_BUG	true
+
 struct bcm2835_i2c_dev {
 	struct device *dev;
 	void __iomem *regs;
@@ -389,7 +393,7 @@ static const struct i2c_algorithm bcm2835_i2c_algo = {
 };

 /*
- * This HW was reported to have problems with clock stretching:
+ * The BCM2835 was reported to have problems with clock stretching:
  * http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
  * https://www.raspberrypi.org/forums/viewtopic.php?p=146272
  */
@@ -406,6 +410,9 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	struct clk *bus_clk;
 	struct clk *mclk;
 	u32 bus_clk_rate;
+	bool clk_stretch_bug;
+
+	clk_stretch_bug = (bool)of_device_get_match_data(&pdev->dev);

 	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
 	if (!i2c_dev)
@@ -475,7 +482,9 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	adap->algo = &bcm2835_i2c_algo;
 	adap->dev.parent = &pdev->dev;
 	adap->dev.of_node = pdev->dev.of_node;
-	adap->quirks = &bcm2835_i2c_quirks;
+
+	if (clk_stretch_bug)
+		adap->quirks = &bcm2835_i2c_quirks;

 	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_C, 0);

@@ -501,7 +510,8 @@ static int bcm2835_i2c_remove(struct platform_device *pdev)
 }

 static const struct of_device_id bcm2835_i2c_of_match[] = {
-	{ .compatible = "brcm,bcm2835-i2c" },
+	{ .compatible = "brcm,bcm2711-i2c", .data = (void *)NO_STRETCH_BUG },
+	{ .compatible = "brcm,bcm2835-i2c", .data = (void *)STRETCH_BUG },
 	{},
 };
 MODULE_DEVICE_TABLE(of, bcm2835_i2c_of_match);
--
2.7.4
