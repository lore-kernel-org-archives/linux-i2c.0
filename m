From: Marcus Folkesson <marcus.folkesson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: davinci: Free requested IRQ in remove
Date: Thu,  3 May 2012 15:56:36 +0200
Message-ID: <1336053396-24974-1-git-send-email-marcus.folkesson@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Marcus Folkesson <marcus.folkesson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

The freed IRQ is not necessary the one requested in probe.
Even if it was, with two or more i2c-controllers it will fails anyway.

Signed-off-by: Marcus Folkesson <marcus.folkesson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a76d85f..79b4bcb 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -755,7 +755,7 @@ static int davinci_i2c_remove(struct platform_device *pdev)
 	dev->clk = NULL;
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
-	free_irq(IRQ_I2C, dev);
+	free_irq(dev->irq, dev);
 	iounmap(dev->base);
 	kfree(dev);
 
-- 
1.7.5.4
