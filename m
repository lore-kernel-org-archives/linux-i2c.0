From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 07/12] i2c: pxa: Reset i2c controller on timeout in interrupt and pio mode
Date: Thu, 28 May 2015 18:33:39 +0530
Message-ID: <1432818224-17070-8-git-send-email-vaibhav.hiremath@linaro.org>
References: <1432818224-17070-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432818224-17070-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

In case of timeout during msg xfer assert reset to
i2c controller for both interrupt and PIO mode of operation.

Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
[vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Split & merge patches into logical changes
and update the Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 2777d5c..3c6ebb5 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -197,6 +197,8 @@ struct pxa_i2c {
  */
 #define I2C_PXA_SLAVE_ADDR      0x1
 
+static void i2c_pxa_reset(struct pxa_i2c *i2c);
+
 #ifdef DEBUG
 
 struct bits {
@@ -846,6 +848,9 @@ out:
 		ret = I2C_RETRY;
 	}
 
+	if (ret < 0)
+		i2c_pxa_reset(i2c);
+
 	return ret;
 }
 
@@ -912,6 +917,9 @@ static int i2c_pxa_do_xfer(struct pxa_i2c *i2c, struct i2c_msg *msg, int num)
 	}
 
  out:
+	if (ret < 0)
+		i2c_pxa_reset(i2c);
+
 	return ret;
 }
 
-- 
1.9.1
