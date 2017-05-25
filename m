From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH] i2c: xlp9xx: Enable HWMON class probing for xlp9xx
Date: Thu, 25 May 2017 11:42:15 +0000
Message-ID: <1495712535-30712-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de, George Cherian <george.cherian@cavium.com>
List-Id: linux-i2c@vger.kernel.org

Set I2C_CLASS_HWMON for xlp9xx to enable automatic probing of BMC
devices by the ipmi-ssif driver.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/i2c/busses/i2c-xlp9xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index ae80228..6b106e9 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -393,6 +393,7 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 	init_completion(&priv->msg_complete);
 	priv->adapter.dev.parent = &pdev->dev;
 	priv->adapter.algo = &xlp9xx_i2c_algo;
+	priv->adapter.class = I2C_CLASS_HWMON;
 	ACPI_COMPANION_SET(&priv->adapter.dev, ACPI_COMPANION(&pdev->dev));
 	priv->adapter.dev.of_node = pdev->dev.of_node;
 	priv->dev = &pdev->dev;
-- 
2.1.4
