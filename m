From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: [PATCH] i2c: davinci: Fix bad dev_get_platdata() conversion
Date: Thu,  5 Sep 2013 12:23:44 -0700
Message-ID: <1378409024-13432-1-git-send-email-olof@lixom.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

commit 6d4028c644e (i2c: use dev_get_platdata()) did a bad conversion
of this one case:

drivers/i2c/busses/i2c-davinci.c: In function 'davinci_i2c_probe':
drivers/i2c/busses/i2c-davinci.c:665:2: warning: passing argument 1 of
	'dev_get_platdata' from incompatible pointer type [enabled by default]

Cc: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 5747341..132369f 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -662,7 +662,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 #endif
 	dev->dev = &pdev->dev;
 	dev->irq = irq->start;
-	dev->pdata = dev_get_platdata(&dev->dev);
+	dev->pdata = dev_get_platdata(&pdev->dev);
 	platform_set_drvdata(pdev, dev);
 
 	if (!dev->pdata && pdev->dev.of_node) {
-- 
1.7.10.4
