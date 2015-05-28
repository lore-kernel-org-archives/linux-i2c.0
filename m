From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/12] i2c: pxa: enable/disable irq across message xfer
Date: Thu, 28 May 2015 18:33:40 +0530
Message-ID: <1432818224-17070-9-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In order to avoid "spurious irq" caused by CP polling mode,
enable irq at the entry of i2c_pxa_xfer() fn and disable it
again before exit.
Also disable it before exiting probe function.

Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
[vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Split & merge patches into logical changes
and update the Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 3c6ebb5..a3ac97c 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1163,6 +1163,7 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	struct pxa_i2c *i2c = adap->algo_data;
 	int ret, i;
 
+	enable_irq(i2c->irq);
 	for (i = adap->retries; i >= 0; i--) {
 		ret = i2c_pxa_do_xfer(i2c, msgs, num);
 		if (ret != I2C_RETRY)
@@ -1176,6 +1177,7 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num
 	ret = -EREMOTEIO;
  out:
 	i2c_pxa_set_slave(i2c, ret);
+	disable_irq(i2c->irq);
 	return ret;
 }
 
@@ -1363,6 +1365,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	i2c_pxa_reset(i2c);
 
+	disable_irq(i2c->irq);
+
 	i2c->adap.algo_data = i2c;
 	i2c->adap.dev.parent = &dev->dev;
 #ifdef CONFIG_OF
-- 
1.9.1
