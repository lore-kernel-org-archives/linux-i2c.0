From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 4/4] i2c-nomadik: fixup bus delays
Date: Thu, 23 Sep 2010 09:04:11 +0200
Message-ID: <1285225451-1085-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We were missing a transfer delay in one execution path leading to
hangs and the bus timeout was too low leading to errors under
stress tests.

Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index e461de7..c9fffd0 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -103,6 +103,9 @@
 /* maximum threshold value */
 #define MAX_I2C_FIFO_THRESHOLD	15
 
+/* per-transfer delay, required for the hardware to stabilize */
+#define I2C_DELAY		150
+
 enum i2c_status {
 	I2C_NOP,
 	I2C_ON_GOING,
@@ -118,7 +121,7 @@ enum i2c_operation {
 };
 
 /* controller response timeout in ms */
-#define I2C_TIMEOUT_MS	500
+#define I2C_TIMEOUT_MS	2000
 
 /**
  * struct i2c_nmk_client - client specific data
@@ -267,6 +270,7 @@ static int init_hw(struct nmk_i2c_dev *dev)
 
 	clk_disable(dev->clk);
 
+	udelay(I2C_DELAY);
 	return 0;
 }
 
@@ -599,7 +603,7 @@ static int nmk_i2c_xfer(struct i2c_adapter *i2c_adap,
 			clk_disable(dev->clk);
 			return status;
 		}
-		mdelay(1);
+		udelay(I2C_DELAY);
 	}
 	clk_disable(dev->clk);
 
-- 
1.6.3.3
