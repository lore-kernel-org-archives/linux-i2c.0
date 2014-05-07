From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 12/16] i2c: sirf: remove unnecessary OOM messages
Date: Wed, 07 May 2014 13:29:06 +0900
Message-ID: <019001cf69ac$e20518f0$a60f4ad0$%han@samsung.com>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <018301cf69aa$cb7987d0$626c9770$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Zhiwu Song' <Zhiwu.Song-kQvG35nSl+M@public.gmane.org>, 'Barry Song' <Baohua.Song-kQvG35nSl+M@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-sirf.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-sirf.c b/drivers/i2c/busses/i2c-sirf.c
index 8e3be7e..a3216de 100644
--- a/drivers/i2c/busses/i2c-sirf.c
+++ b/drivers/i2c/busses/i2c-sirf.c
@@ -307,7 +307,6 @@ static int i2c_sirfsoc_probe(struct platform_device *pdev)
 
 	siic = devm_kzalloc(&pdev->dev, sizeof(*siic), GFP_KERNEL);
 	if (!siic) {
-		dev_err(&pdev->dev, "Can't allocate driver data\n");
 		err = -ENOMEM;
 		goto out;
 	}
-- 
1.7.10.4
