From: Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC] i2c: bcm2835: Store pointer to bus clock
Date: Sat, 26 Oct 2019 14:34:48 +0200
Message-ID: <1572093288-6223-1-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Annaliese McDermond <nh6z@nh6z.net>, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <wahrenst@gmx.net>, Dave Stevenson <dave.stevenson@raspberrypi.org>, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

The commit bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF") introduced
a NULL pointer dereference on driver unload. It seems that we can't fetch
the bus clock via devm_clk_get in bcm2835_i2c_remove. As an alternative
approach store a pointer to the bus clock in the private driver structure.

Fixes: bebff81fb8b9 ("i2c: bcm2835: Model Divider in CCF")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
---
 drivers/i2c/busses/i2c-bcm2835.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index e01b2b5..5ab901a 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -58,6 +58,7 @@ struct bcm2835_i2c_dev {
 	struct i2c_adapter adapter;
 	struct completion completion;
 	struct i2c_msg *curr_msg;
+	struct clk *bus_clk;
 	int num_msgs;
 	u32 msg_err;
 	u8 *msg_buf;
@@ -404,7 +405,6 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 	struct resource *mem, *irq;
 	int ret;
 	struct i2c_adapter *adap;
-	struct clk *bus_clk;
 	struct clk *mclk;
 	u32 bus_clk_rate;

@@ -427,11 +427,11 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(mclk);
 	}

-	bus_clk = bcm2835_i2c_register_div(&pdev->dev, mclk, i2c_dev);
+	i2c_dev->bus_clk = bcm2835_i2c_register_div(&pdev->dev, mclk, i2c_dev);

-	if (IS_ERR(bus_clk)) {
+	if (IS_ERR(i2c_dev->bus_clk)) {
 		dev_err(&pdev->dev, "Could not register clock\n");
-		return PTR_ERR(bus_clk);
+		return PTR_ERR(i2c_dev->bus_clk);
 	}

 	ret = of_property_read_u32(pdev->dev.of_node, "clock-frequency",
@@ -442,13 +442,13 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 		bus_clk_rate = 100000;
 	}

-	ret = clk_set_rate_exclusive(bus_clk, bus_clk_rate);
+	ret = clk_set_rate_exclusive(i2c_dev->bus_clk, bus_clk_rate);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not set clock frequency\n");
 		return ret;
 	}

-	ret = clk_prepare_enable(bus_clk);
+	ret = clk_prepare_enable(i2c_dev->bus_clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Couldn't prepare clock");
 		return ret;
@@ -491,10 +491,9 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 static int bcm2835_i2c_remove(struct platform_device *pdev)
 {
 	struct bcm2835_i2c_dev *i2c_dev = platform_get_drvdata(pdev);
-	struct clk *bus_clk = devm_clk_get(i2c_dev->dev, "div");

-	clk_rate_exclusive_put(bus_clk);
-	clk_disable_unprepare(bus_clk);
+	clk_rate_exclusive_put(i2c_dev->bus_clk);
+	clk_disable_unprepare(i2c_dev->bus_clk);

 	free_irq(i2c_dev->irq, i2c_dev);
 	i2c_del_adapter(&i2c_dev->adapter);
--
2.7.4
