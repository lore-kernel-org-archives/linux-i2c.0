From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 12/13] i2c/i2c-nomadik: reset the hw after status check
Date: Mon,  9 May 2011 23:39:15 +0200
Message-ID: <1304977155-31800-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

In case of I2C timeout, reset the HW only after the HW status
is read, otherwise the staus will be lost.

Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a94445e..dc57c6e 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -428,10 +428,9 @@ static int read_i2c(struct nmk_i2c_dev *dev)
 	}
 
 	if (timeout == 0) {
-		/* controller has timedout, re-init the h/w */
+		/* Controller timed out */
 		dev_err(&dev->pdev->dev, "read from slave 0x%x timed out\n",
 				dev->cli.slave_adr);
-		(void) init_hw(dev);
 		status = -ETIMEDOUT;
 	}
 	return status;
@@ -516,10 +515,9 @@ static int write_i2c(struct nmk_i2c_dev *dev)
 	}
 
 	if (timeout == 0) {
-		/* controller has timedout, re-init the h/w */
+		/* Controller timed out */
 		dev_err(&dev->pdev->dev, "write to slave 0x%x timed out\n",
 				dev->cli.slave_adr);
-		(void) init_hw(dev);
 		status = -ETIMEDOUT;
 	}
 
@@ -638,6 +636,8 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 						abort_causes[cause]);
 				}
 
+				(void) init_hw(dev);
+
 				status = status ? status : dev->result;
 
 				break;
-- 
1.7.5.1
