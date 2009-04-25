From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c: Do not probe for TV chips on Voodoo3 adapters
Date: Sat, 25 Apr 2009 17:27:08 +0200
Message-ID: <20090425172708.0622f5b3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

There's no point in giving the I2C bus of Voodoo3 adapters a class
value, there's no video chip driver checking for it anymore. If
support is ever needed, the video device should be instantiated
explicitly rather than probed.

To the best of my knowledge the only video chip that can be found on
these boards is a BT869 video encoder, for which no support exists
currently.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
---
 drivers/i2c/busses/i2c-voodoo3.c |    1 -
 drivers/video/tdfxfb.c           |    1 -
 2 files changed, 2 deletions(-)

--- linux-2.6.30-rc3.orig/drivers/i2c/busses/i2c-voodoo3.c	2009-03-24 13:43:33.000000000 +0100
+++ linux-2.6.30-rc3/drivers/i2c/busses/i2c-voodoo3.c	2009-04-25 12:14:08.000000000 +0200
@@ -163,7 +163,6 @@ static struct i2c_algo_bit_data voo_i2c_
 
 static struct i2c_adapter voodoo3_i2c_adapter = {
 	.owner		= THIS_MODULE,
-	.class		= I2C_CLASS_TV_ANALOG, 
 	.name		= "I2C Voodoo3/Banshee adapter",
 	.algo_data	= &voo_i2c_bit_data,
 };
--- linux-2.6.30-rc3.orig/drivers/video/tdfxfb.c	2009-04-08 08:53:35.000000000 +0200
+++ linux-2.6.30-rc3/drivers/video/tdfxfb.c	2009-04-25 12:13:59.000000000 +0200
@@ -1315,7 +1315,6 @@ static int __devinit tdfxfb_setup_i2c_bu
 
 	strlcpy(chan->adapter.name, name, sizeof(chan->adapter.name));
 	chan->adapter.owner		= THIS_MODULE;
-	chan->adapter.class		= I2C_CLASS_TV_ANALOG;
 	chan->adapter.algo_data		= &chan->algo;
 	chan->adapter.dev.parent	= dev;
 	chan->algo.setsda		= tdfxfb_i2c_setsda;

-- 
Jean Delvare
