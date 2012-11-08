From: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 11/11] i2c: pxa: no need slave addr for i2c master mode reset
Date: Thu,  8 Nov 2012 22:18:04 +0800
Message-ID: <1352384284-15660-11-git-send-email-liangs@marvell.com>
References: <1352384284-15660-1-git-send-email-liangs@marvell.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352384284-15660-1-git-send-email-liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leo Song <liangs-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Chao Xie <cxie4-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: "Jett.Zhou" <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

Normally i2c controller works as master, slave addr is not needed, or it
will impact some slave device(eg. ST NFC chip) i2c access, because it has
the same i2c address with controller.

Change-Id: Iaf6e16cf2e211d242b21086e491b751ea311a000
Signed-off-by: Jett.Zhou <jtzhou-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 3346fef..2dc3af3 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -490,8 +490,10 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
 	writel(I2C_ISR_INIT, _ISR(i2c));
 	writel(readl(_ICR(i2c)) & ~ICR_UR, _ICR(i2c));
 
+#ifdef CONFIG_I2C_PXA_SLAVE
 	if (i2c->reg_isar)
 		writel(i2c->slave_addr, _ISAR(i2c));
+#endif
 
 	/* set control register values */
 	writel(I2C_ICR_INIT | (i2c->fast_mode ? ICR_FM : 0), _ICR(i2c));
-- 
1.7.5.4
