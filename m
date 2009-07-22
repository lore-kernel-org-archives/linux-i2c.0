From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c: change i2c-sh_mobile.c module_init() to subsys_initcall()
Date: Wed, 22 Jul 2009 23:58:39 +0900
Message-ID: <20090722145839.17871.94267.sendpatchset@rx1.opensource.se>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

From: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>

Convert the i2c-sh_mobile i2c bus driver to use
subsys_initcall() instead of module_init().

This change makes the driver register a bit earlier which
together with earlier platform data moves the time for probe().
The earlier probe() makes it possible to use i2c_get_adapter()
and i2c_transfer() from device_initcall().

The same strategy is used by other i2c bus drivers such as
i2c-pxa.c and i2c-s3c2410.c.

Signed-off-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
---

 Paul, can you merge this in your tree?

 drivers/i2c/busses/i2c-sh_mobile.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2009-07-22 21:54:29.000000000 +0900
@@ -637,7 +637,7 @@ static void __exit sh_mobile_i2c_adap_ex
 	platform_driver_unregister(&sh_mobile_i2c_driver);
 }
 
-module_init(sh_mobile_i2c_adap_init);
+subsys_initcall(sh_mobile_i2c_adap_init);
 module_exit(sh_mobile_i2c_adap_exit);
 
 MODULE_DESCRIPTION("SuperH Mobile I2C Bus Controller driver");
