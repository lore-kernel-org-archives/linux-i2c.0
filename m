From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-parport: Make template structure const
Date: Thu, 11 Mar 2010 17:59:32 +0100
Message-ID: <20100311175932.17184912@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

parport_algo_data is a template so it can be marked const.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.34-rc1.orig/drivers/i2c/busses/i2c-parport.c	2010-03-09 08:24:55.000000000 +0100
+++ linux-2.6.34-rc1/drivers/i2c/busses/i2c-parport.c	2010-03-11 17:43:13.000000000 +0100
@@ -136,7 +136,7 @@ static int parport_getsda(void *data)
    copied. The attaching code will set getscl to NULL for adapters that
    cannot read SCL back, and will also make the data field point to
    the parallel port structure. */
-static struct i2c_algo_bit_data parport_algo_data = {
+static const struct i2c_algo_bit_data parport_algo_data = {
 	.setsda		= parport_setsda,
 	.setscl		= parport_setscl,
 	.getsda		= parport_getsda,


-- 
Jean Delvare
