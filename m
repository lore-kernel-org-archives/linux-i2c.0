From: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
Subject: [PATCH] Add support for SCCB devices into PXA27x I2C controller
Date: Sat, 22 Nov 2014 23:52:07 +0100
Message-ID: <54711397.9060601@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Add support for SCCB devices into PXA27x I2C controller.

Fix generated START but no STOP for message without I2C_M_NOSTART flag. 
Add support for I2C_M_IGNORE_NAK flag.

Signed-off-by: Petr Cvek <petr.cvek-qphu/3gb4gc@public.gmane.org>
---
  drivers/i2c/busses/i2c-pxa.c | 22 ++++++++++++++++------
  1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index be671f7..adad044 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -885,7 +885,14 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c 
*i2c, u32 isr)
          return; /* ignore */
      }

-    if (isr & ISR_BED) {
+    /*
+     * Ignore NAK when flag I2C_M_IGNORE_NAK is present,
+     * this enables use of SCCB devices
+     */
+    if ((isr & ISR_BED) &&
+        (!((i2c->msg->flags & I2C_M_IGNORE_NAK) &&
+            (isr & ISR_ACKNAK)))) {
+
          int ret = BUS_ERROR;

          /*
@@ -919,12 +926,15 @@ static void i2c_pxa_irq_txempty(struct pxa_i2c 
*i2c, u32 isr)
          icr |= ICR_ALDIE | ICR_TB;

          /*
-         * If this is the last byte of the last message, send
-         * a STOP.
+         * If this is the last byte of the last message or last byte
+         * or any message without I2C_M_NOSTART, send a STOP.
           */
-        if (i2c->msg_ptr == i2c->msg->len &&
-            i2c->msg_idx == i2c->msg_num - 1)
-            icr |= ICR_STOP;
+        if (((i2c->msg_ptr == i2c->msg->len) &&
+            (!(i2c->msg->flags & I2C_M_NOSTART))) ||
+            ((i2c->msg_ptr == i2c->msg->len) &&
+            (i2c->msg_idx == i2c->msg_num - 1)))
+                icr |= ICR_STOP;
+
      } else if (i2c->msg_idx < i2c->msg_num - 1) {
          /*
           * Next segment of the message.
-- 
1.7.12.1
