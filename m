From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH 3/4] i2c-nomadik: support smbus emulation
Date: Thu, 23 Sep 2010 09:04:03 +0200
Message-ID: <1285225443-1036-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>, Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

We can do smbus emulation so flag this and drop the duplicate
flags implied from smbus emulation.

Acked-by: Srinidhi Kasagar <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Sundar R Iyer <sundar.iyer-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index b2dbf7c..e461de7 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -803,10 +803,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
 static unsigned int nmk_i2c_functionality(struct i2c_adapter *adap)
 {
-	return I2C_FUNC_I2C
-		| I2C_FUNC_SMBUS_BYTE_DATA
-		| I2C_FUNC_SMBUS_WORD_DATA
-		| I2C_FUNC_SMBUS_I2C_BLOCK;
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
 }
 
 static const struct i2c_algorithm nmk_i2c_algo = {
-- 
1.6.3.3
