From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 01/12] i2c: pxa: keep i2c irq ON in suspend
Date: Thu, 28 May 2015 18:33:33 +0530
Message-ID: <1432818224-17070-2-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Raul Xiong <xjian-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Leilei Shang <shangll-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

During suspend there may still be some i2c access happening, as the
interrupt is shared between multiple drivers.
And if we don't keep i2c irq ON, there may be i2c access timeout if
i2c is in irq mode of operation.

Signed-off-by: Raul Xiong <xjian-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Xiaofan Tian <tianxf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
[vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index d9c0d6a..f4ac8c5 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1232,8 +1232,9 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		i2c->adap.algo = &i2c_pxa_pio_algorithm;
 	} else {
 		i2c->adap.algo = &i2c_pxa_algorithm;
-		ret = request_irq(irq, i2c_pxa_handler, IRQF_SHARED,
-				  dev_name(&dev->dev), i2c);
+		ret = request_irq(irq, i2c_pxa_handler,
+				IRQF_SHARED | IRQF_NO_SUSPEND,
+				dev_name(&dev->dev), i2c);
 		if (ret)
 			goto ereqirq;
 	}
-- 
1.9.1
