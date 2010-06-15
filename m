From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c-pxa: fix compiler warning, due to missing const
Date: Tue, 15 Jun 2010 10:56:45 +0200
Message-ID: <1276592205-26284-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

This patch adds the missing const to "struct platform_device_id" to fix
this warning:

/home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.c:
In function 'i2c_pxa_probe':
/home/frogger/pengutronix/linux/linux-2.6/drivers/i2c/busses/i2c-pxa.c:1004:
warning: initialization discards qualifiers from pointer target type

Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Roel Kluin <roel.kluin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
---
 drivers/i2c/busses/i2c-pxa.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 020ff23..c94e51b 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1001,7 +1001,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
 	struct pxa_i2c *i2c;
 	struct resource *res;
 	struct i2c_pxa_platform_data *plat = dev->dev.platform_data;
-	struct platform_device_id *id = platform_get_device_id(dev);
+	const struct platform_device_id *id = platform_get_device_id(dev);
 	int ret;
 	int irq;
 
-- 
1.7.1
