From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 05/13] i2c/i2c-nomadik: remove the redundant error message
Date: Mon,  9 May 2011 23:36:37 +0200
Message-ID: <1304976997-31547-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: srinidhi kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

The abort cause string itself is an error, so remove the redundant
explicit error message.

Signed-off-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Reviewed-by: Jonas Aberg <jonas.aberg-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index a02141a..dbd93b2 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -609,8 +609,6 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 		if (status || (dev->result)) {
 			/* get the abort cause */
 			cause =	(readl(dev->virtbase + I2C_SR) >> 4) & 0x7;
-			dev_err(&dev->pdev->dev, "error during I2C"
-					"message xfer: %d\n", cause);
 			dev_err(&dev->pdev->dev, "%s\n",
 				cause >= ARRAY_SIZE(abort_causes)
 				? "unknown reason" : abort_causes[cause]);
-- 
1.7.5.1
