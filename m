From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-pxa: fix unbinding/rebinding of the device
Date: Sat,  8 Jan 2011 19:06:44 +0300
Message-ID: <1294502804-6580-1-git-send-email-dbaryshkov@gmail.com>
References: <20110106124028.GX25121@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110106124028.GX25121-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

When a "pxa2xx-i2c" device was unbound (e.g. via sysfs) the remove
callback was not called because it was discarded when linking the
kernel.  Because of that the resources allocated in probe were not
freed and so a clean unbind/rebind was impossible.

Fix that by moving the remove callback to .devexit.text.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index f4c19a9..0f10955 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1115,7 +1115,7 @@ emalloc:
 	return ret;
 }
 
-static int __exit i2c_pxa_remove(struct platform_device *dev)
+static int __devexit i2c_pxa_remove(struct platform_device *dev)
 {
 	struct pxa_i2c *i2c = platform_get_drvdata(dev);
 
@@ -1169,7 +1169,7 @@ static const struct dev_pm_ops i2c_pxa_dev_pm_ops = {
 
 static struct platform_driver i2c_pxa_driver = {
 	.probe		= i2c_pxa_probe,
-	.remove		= __exit_p(i2c_pxa_remove),
+	.remove		= __devexit_p(i2c_pxa_remove),
 	.driver		= {
 		.name	= "pxa2xx-i2c",
 		.owner	= THIS_MODULE,
-- 
1.7.2.3
