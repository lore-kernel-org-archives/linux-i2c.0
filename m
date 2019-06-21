From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 2/2] i2c: bcm2835: Ensure clock exists when probing
Date: Fri, 21 Jun 2019 03:52:50 -0700
Message-ID: <20190621105250.19858-3-nh6z@nh6z.net>
References: <20190621105250.19858-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190621105250.19858-1-nh6z@nh6z.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: eric@anholt.net, wahrenst@gmx.net, f.fainelli@gmail.com, wsa@the-dreams.de, swarren@wwwdotorg.org, linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: linux-i2c@vger.kernel.org

Probe function fails to recognize that upstream clock actually
doesn't yet exist because clock driver has not been initialized.
Actually try to go get the clock and test for its existence
before trying to set up a downstream clock based upon it.

This fixes a bug that causes the i2c driver not to work with
monolithic kernels.

Fixes: bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF")

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 27b2f204c693..79d06286b926 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -244,15 +244,18 @@ static const struct clk_ops clk_bcm2835_i2c_ops = {
 };
 
 static struct clk *bcm2835_i2c_register_div(struct device *dev,
-					const char *mclk_name,
+					struct clk *mclk,
 					struct bcm2835_i2c_dev *i2c_dev)
 {
 	struct clk_init_data init;
 	struct clk_bcm2835_i2c *priv;
 	char name[32];
+	const char *mclk_name;
 
 	snprintf(name, sizeof(name), "%s_div", dev_name(dev));
 
+	mclk_name = __clk_get_name(mclk);
+
 	init.ops = &clk_bcm2835_i2c_ops;
 	init.name = name;
 	init.parent_names = (const char* []) { mclk_name };
@@ -505,8 +508,8 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	struct resource *mem, *irq;
 	int ret;
 	struct i2c_adapter *adap;
-	const char *mclk_name;
 	struct clk *bus_clk;
+	struct clk *mclk;
 	u32 bus_clk_rate;
 
 	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
@@ -521,9 +524,14 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(i2c_dev->regs))
 		return PTR_ERR(i2c_dev->regs);
 
-	mclk_name = of_clk_get_parent_name(pdev->dev.of_node, 0);
+	mclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mclk)) {
+		if (PTR_ERR(mclk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Could not get clock\n");
+		return PTR_ERR(mclk);
+	}
 
-	bus_clk = bcm2835_i2c_register_div(&pdev->dev, mclk_name, i2c_dev);
+	bus_clk = bcm2835_i2c_register_div(&pdev->dev, mclk, i2c_dev);
 
 	if (IS_ERR(bus_clk)) {
 		dev_err(&pdev->dev, "Could not register clock\n");
-- 
2.19.1
