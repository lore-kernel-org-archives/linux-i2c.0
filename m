From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-parport: i2c_parport_irq can be static
Date: Sun, 30 Sep 2012 13:59:38 +0200
Message-ID: <20120930135938.2ce459c6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

i2c_parport_irq is only called internally so it can be static.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.6-rc7.orig/drivers/i2c/busses/i2c-parport.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.6-rc7/drivers/i2c/busses/i2c-parport.c	2012-09-30 13:58:37.103593569 +0200
@@ -151,7 +151,7 @@ static const struct i2c_algo_bit_data pa
 
 /* ----- I2c and parallel port call-back functions and structures --------- */
 
-void i2c_parport_irq(void *data)
+static void i2c_parport_irq(void *data)
 {
 	struct i2c_par *adapter = data;
 	struct i2c_client *ara = adapter->ara;


-- 
Jean Delvare
