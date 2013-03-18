From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH] i2c: sirf: get the i2c pin group by pinctrl api
Date: Mon, 18 Mar 2013 15:22:41 +0800
Message-ID: <1363591361-5992-1-git-send-email-Barry.Song@csr.com>
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
To: w.sang@pengutronix.de, ben-linux@fluff.org
Cc: workgroup.linux@csr.com, Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>
List-Id: linux-i2c@vger.kernel.org

From: Barry Song <Baohua.Song@csr.com>

hardcode set i2c pin group to i2c function before, here we
move to use standard pinctrl API to get pins of the group.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/i2c/busses/i2c-sirf.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 5a7ad24..dd4004e 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/pinctrl/consumer.h>
 
 #define SIRFSOC_I2C_CLK_CTRL		0x00
 #define SIRFSOC_I2C_STATUS		0x0C
@@ -265,6 +266,7 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 	struct i2c_adapter *adap;
 	struct resource *mem_res;
 	struct clk *clk;
+	struct pinctrl *pinctrl;
 	int bitrate;
 	int ctrl_speed;
 	int irq;
@@ -272,6 +274,12 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 	int err;
 	u32 regval;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		err = PTR_ERR(pinctrl);
+		goto failed_pin;
+	}
+
 	clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		err = PTR_ERR(clk);
@@ -385,6 +393,7 @@ err_clk_en:
 err_clk_prep:
 	clk_put(clk);
 err_get_clk:
+failed_pin:
 	return err;
 }
 
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
