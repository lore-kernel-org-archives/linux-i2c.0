From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH-V2 05/12] i2c: pxa: Remove compile warnning in 64bit mode
Date: Mon, 15 Jun 2015 21:19:52 +0530
Message-ID: <1434383399-2370-6-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434383399-2370-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Fix below warning message, coming from 64 bit toolchain.

drivers/i2c/busses/i2c-pxa.c:1237:15: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Yipeng Yao <ypyao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
[vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org: Updated Changelog]
Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index edacfeb3..810e9d0 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1124,7 +1124,9 @@ static int i2c_pxa_probe_dt(struct platform_device *pdev, struct pxa_i2c *i2c,
 		i2c->use_pio = 1;
 	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
 		i2c->fast_mode = 1;
-	*i2c_types = (u32)(of_id->data);
+
+	*i2c_types = (long)(of_id->data);
+
 	return 0;
 }
 
-- 
1.9.1
