From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] i2c-stu300: make sure adapter-name is terminated
Date: Mon, 31 Jan 2011 15:09:23 +0100
Message-ID: <1296482963-27368-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Use strlcpy instead of strncpy.

Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---

Have been bitten by this, too. Thanks to Ben for spotting it in my driver.
This was the only occurence in i2c/busses.

 drivers/i2c/busses/i2c-stu300.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stu300.c b/drivers/i2c/busses/i2c-stu300.c
index 495be45..266135d 100644
--- a/drivers/i2c/busses/i2c-stu300.c
+++ b/drivers/i2c/busses/i2c-stu300.c
@@ -942,7 +942,7 @@ stu300_probe(struct platform_device *pdev)
 	adap->owner = THIS_MODULE;
 	/* DDC class but actually often used for more generic I2C */
 	adap->class = I2C_CLASS_DDC;
-	strncpy(adap->name, "ST Microelectronics DDC I2C adapter",
+	strlcpy(adap->name, "ST Microelectronics DDC I2C adapter",
 		sizeof(adap->name));
 	adap->nr = bus_nr;
 	adap->algo = &stu300_algo;
-- 
1.7.2.3
