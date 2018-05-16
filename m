From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 1/4] i2c: xlp9xx: Add support for SMBAlert
Date: Wed, 16 May 2018 00:00:16 -0700
Message-ID: <1526454019-32714-2-git-send-email-george.cherian@cavium.com>
References: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, jglauber@cavium.com, kamlakant.patel@cavium.com, mchehab+samsung@kernel.org, davem@davemloft.net, gregkh@linuxfoundation.org, akpm@linux-foundation.org, linus.walleij@linaro.org, rdunlap@infradead.org, george.cherian@cavium.com
List-Id: linux-i2c@vger.kernel.org

Add support for SMBus alert mechanism to i2c-xlp9xx driver.
The second interrupt is parsed to use for SMBus alert.
The first interrupt is the i2c controller main interrupt.

Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
Signed-off-by: George Cherian <george.cherian@cavium.com>
Reviewed-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index eb8913e..fe54512 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -84,6 +85,8 @@ struct xlp9xx_i2c_dev {
 	struct device *dev;
 	struct i2c_adapter adapter;
 	struct completion msg_complete;
+	struct i2c_smbus_alert_setup alert_data;
+	struct i2c_client *ara;
 	int irq;
 	bool msg_read;
 	bool len_recv;
@@ -447,6 +450,19 @@ static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
 	return 0;
 }
 
+static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
+				  struct platform_device *pdev)
+{
+	if (!priv->alert_data.irq)
+		return -EINVAL;
+
+	priv->ara = i2c_setup_smbus_alert(&priv->adapter, &priv->alert_data);
+	if (!priv->ara)
+		return -ENODEV;
+
+	return 0;
+}
+
 static int xlp9xx_i2c_probe(struct platform_device *pdev)
 {
 	struct xlp9xx_i2c_dev *priv;
@@ -467,6 +483,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "invalid irq!\n");
 		return priv->irq;
 	}
+	/* SMBAlert irq */
+	priv->alert_data.irq = platform_get_irq(pdev, 1);
+	if (priv->alert_data.irq <= 0)
+		priv->alert_data.irq = 0;
 
 	xlp9xx_i2c_get_frequency(pdev, priv);
 	xlp9xx_i2c_init(priv);
@@ -493,6 +513,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = xlp9xx_i2c_smbus_setup(priv, pdev);
+	if (err)
+		dev_dbg(&pdev->dev, "No active SMBus alert %d\n", err);
+
 	platform_set_drvdata(pdev, priv);
 	dev_dbg(&pdev->dev, "I2C bus:%d added\n", priv->adapter.nr);
 
-- 
1.8.3.1
