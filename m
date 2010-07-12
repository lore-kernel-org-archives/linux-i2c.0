From: srinidhi <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] i2c-nomadik: add SMBUS_EMUL functionality
Date: Mon, 12 Jul 2010 12:49:24 +0530
Message-ID: <1278919164.4705.596.camel@bnru03>
Reply-To: <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, prajadevi.h-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, STEricsson_nomadik_linux-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Prajadevi H <prajadevi.h-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Support to emulate all SMBus commands on this adapter.

Signed-off-by: Prajadevi H <prajadevi.h-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Acked-by: Srinidhi KASAGAR <srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
---
 drivers/i2c/busses/i2c-nomadik.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 73de8ad..b734a44 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -794,10 +794,7 @@ static irqreturn_t i2c_irq_handler(int irq, void *arg)
 
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
