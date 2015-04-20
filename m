From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: [PATCH 2/7] i2c: mxs: fix broken email address
Date: Mon, 20 Apr 2015 15:51:39 +0200
Message-ID: <1429537917-7433-2-git-send-email-wsa@the-dreams.de>
References: <1429537917-7433-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429537917-7433-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

My Pengutronix address is not valid anymore, redirect people to the Pengutronix
kernel team.

Reported-by: Harald Geyer <harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Acked-by: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
These patches shall go via the individual subsystem trees.

 drivers/i2c/busses/i2c-mxs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
index ff8b12c8d25f50..97ced9c2a50872 100644
--- a/drivers/i2c/busses/i2c-mxs.c
+++ b/drivers/i2c/busses/i2c-mxs.c
@@ -912,7 +912,7 @@ static void __exit mxs_i2c_exit(void)
 module_exit(mxs_i2c_exit);
 
 MODULE_AUTHOR("Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>");
-MODULE_AUTHOR("Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
+MODULE_AUTHOR("Wolfram Sang <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
 MODULE_DESCRIPTION("MXS I2C Bus Driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.1.4
