From: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
Subject: [PATCH] i2c/mv64xxx: get rid of a compiler warning
Date: Sat, 12 Sep 2009 11:51:17 +0200
Message-ID: <20090912095117.GA7871@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Mark A. Greer" <mgreer-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

|CC drivers/i2c/busses/i2c-mv64xxx.o
|drivers/i2c/busses/i2c-mv64xxx.c: In function mv64xxx_i2c_probe:
|drivers/i2c/busses/i2c-mv64xxx.c:540: warning: passing argument 2 of request_irq from incompatible pointer type

Signed-off-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
---
 drivers/i2c/busses/i2c-mv64xxx.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index c3869d9..ae4f91b 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -293,13 +293,12 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
 	}
 }
 
-static int
-mv64xxx_i2c_intr(int irq, void *dev_id)
+static irqreturn_t mv64xxx_i2c_intr(int irq, void *dev_id)
 {
 	struct mv64xxx_i2c_data	*drv_data = dev_id;
 	unsigned long	flags;
 	u32		status;
-	int		rc = IRQ_NONE;
+	irqreturn_t	rc = IRQ_NONE;
 
 	spin_lock_irqsave(&drv_data->lock, flags);
 	while (readl(drv_data->reg_base + MV64XXX_I2C_REG_CONTROL) &
-- 
1.6.4.GIT
