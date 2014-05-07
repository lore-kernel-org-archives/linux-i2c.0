From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 03/16] i2c: efm32: remove unnecessary OOM messages
Date: Wed, 07 May 2014 13:17:30 +0900
Message-ID: <018701cf69ab$42fd89f0$c8f89dd0$%han@samsung.com>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <018301cf69aa$cb7987d0$626c9770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, =?ISO-8859-1?Q?'Uwe_Kleine-K=F6nig'?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-efm32.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index 777ed40..f7eccd6 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -320,10 +320,8 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
-	if (!ddata) {
-		dev_dbg(&pdev->dev, "failed to allocate private data\n");
+	if (!ddata)
 		return -ENOMEM;
-	}
 	platform_set_drvdata(pdev, ddata);
 
 	init_completion(&ddata->done);
-- 
1.7.10.4
