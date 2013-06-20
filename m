From: Renaud Cerrato <r.cerrato-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>
Subject: [PATCH] i2c-gpio: added support for I2C_M_STOP flag
Date: Thu, 20 Jun 2013 14:37:17 +0200
Message-ID: <1371731837-1476-1-git-send-email-r.cerrato@til-technologies.fr>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Renaud Cerrato <r.cerrato-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Current i2c bit algo implementation doesn't actually support I2C_M_STOP flag despite I2C_FUNC_PROTOCOL_MANGLING functionnality.
---
 drivers/i2c/algos/i2c-algo-bit.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index fad22b0..00446a6 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -557,6 +557,12 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
 	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
 		nak_ok = pmsg->flags & I2C_M_IGNORE_NAK;
+		if (pmsg->flags & I2C_M_STOP) {
+			if (i) {
+				bit_dbg(3, &i2c_adap->dev, "emitting stop condition\n");
+				i2c_stop(adap);
+			}
+		}
 		if (!(pmsg->flags & I2C_M_NOSTART)) {
 			if (i) {
 				bit_dbg(3, &i2c_adap->dev, "emitting "
-- 
1.7.2.5
