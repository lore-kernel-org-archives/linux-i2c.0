From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C driver
Date: Mon, 6 Aug 2012 11:21:52 +0100
Message-ID: <20120806102151.GB16996@gmail.com>
References: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1344243146-6598-1-git-send-email-linus.walleij@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
List-Id: linux-i2c@vger.kernel.org

From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 6 Aug 2012 11:04:14 +0100
Subject: [PATCH 1/1] i2c: Add default configuration into the Nomadik I2C
 driver.

At this moment in time there is only one known configuration for the
Nomadik I2C driver. By not holding that configuration in the driver
adds some unnecessary overhead in platform code. The configuration
as already been removed from platform code, this patch checks for any
over-riding configurations. If there aren't any, the default is used.

Cc: linux-i2c@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-nomadik.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a92440d..86aa73d 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -333,10 +333,6 @@ static void setup_i2c_controller(struct nmk_i2c_dev *dev)
 
 	i2c_clk = clk_get_rate(dev->clk);
 
-	/* fallback to std. mode if machine has not provided it */
-	if (dev->cfg.clk_freq == 0)
-		dev->cfg.clk_freq = 100000;
-
 	/*
 	 * The spec says, in case of std. mode the divider is
 	 * 2 whereas it is 3 for fast and fastplus mode of
@@ -899,15 +895,31 @@ static const struct i2c_algorithm nmk_i2c_algo = {
 	.functionality	= nmk_i2c_functionality
 };
 
+static struct nmk_i2c_controller u8500_i2c = {
+	/*
+	 * Slave data setup time; 250ns, 100ns, and 10ns, which
+	 * is 14, 6 and 2 respectively for a 48Mhz i2c clock.
+	 */
+	.slsu           = 0xe,
+	.tft            = 1,      /* Tx FIFO threshold */
+	.rft            = 8,      /* Rx FIFO threshold */
+	.clk_freq       = 400000, /* std. mode operation */
+	.timeout        = 200,    /* Slave response timeout(ms) */
+	.sm             = I2C_FREQ_MODE_FAST,
+};
+
 static int __devinit nmk_i2c_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct resource *res;
-	struct nmk_i2c_controller *pdata =
-			pdev->dev.platform_data;
+	struct nmk_i2c_controller *pdata = pdev->dev.platform_data;
 	struct nmk_i2c_dev	*dev;
 	struct i2c_adapter *adap;
 
+	if (!pdata)
+		/* No i2c configuration found, using the default. */
+		pdata = &u8500_i2c;
+
 	dev = kzalloc(sizeof(struct nmk_i2c_dev), GFP_KERNEL);
 	if (!dev) {
 		dev_err(&pdev->dev, "cannot allocate memory\n");
-- 
1.7.9.5
