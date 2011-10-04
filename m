From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 1/2] i2c-algo-bit: Let user test buses without failing
Date: Tue, 4 Oct 2011 14:44:50 +0200
Message-ID: <201110041444.51029.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Always failing to register I2C buses when the line testing fails is a
little harsh. While such a failure is definitely a bug in the driver
that exposes the affected I2C bus, things may still work fine if the
missing initialization steps are done later, before the I2C bus is
used. So it seems a better debugging tool to just report the test
failure by default. I introduce bit_test=2 if anyone really misses the
original behavior of bit_test=1.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-3.0.orig/drivers/i2c/algos/i2c-algo-bit.c	2011-07-22 04:17:23.000000000 +0200
+++ linux-3.0/drivers/i2c/algos/i2c-algo-bit.c	2011-10-02 10:29:51.000000000 +0200
@@ -47,8 +47,8 @@
 /* ----- global variables ---------------------------------------------	*/
 
 static int bit_test;	/* see if the line-setting functions work	*/
-module_param(bit_test, bool, 0);
-MODULE_PARM_DESC(bit_test, "Test the lines of the bus to see if it is stuck");
+module_param(bit_test, bool, S_IRUGO);
+MODULE_PARM_DESC(bit_test, "lines testing - 0 off; 1 report; 2 fail if stuck");
 
 #ifdef DEBUG
 static int i2c_debug = 1;
@@ -624,7 +624,7 @@ static int __i2c_bit_add_bus(struct i2c_
 
 	if (bit_test) {
 		ret = test_bus(adap);
-		if (ret < 0)
+		if (bit_test >= 2 && ret < 0)
 			return -ENODEV;
 	}
 

-- 
Jean Delvare
Suse L3
