From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/4] i2c: uniphier_f: error out if clock rate is zero
Date: Mon, 30 Nov 2015 18:53:35 +0900
Message-ID: <1448877216-32286-4-git-send-email-yamada.masahiro@socionext.com>
References: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448877216-32286-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-i2c@vger.kernel.org

This input clock is used to generate the sampling clock for I2C bus.
If the clock rate is zero, there is something wrong with the clock
driver.  Bail out with the appropriate error message in such a case.
It would make it easier to find the root cause of failure.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/i2c/busses/i2c-uniphier-f.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index e8d03bc..67109e1 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -481,6 +481,10 @@ static int uniphier_fi2c_clk_init(struct device *dev,
 		return ret;
 
 	clk_rate = clk_get_rate(priv->clk);
+	if (!clk_rate) {
+		dev_err(dev, "input clock rate should not be zero\n");
+		return -EINVAL;
+	}
 
 	uniphier_fi2c_reset(priv);
 
@@ -531,7 +535,7 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 
 	ret = uniphier_fi2c_clk_init(dev, priv);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = devm_request_irq(dev, irq, uniphier_fi2c_interrupt, 0,
 			       pdev->name, priv);
-- 
1.9.1
