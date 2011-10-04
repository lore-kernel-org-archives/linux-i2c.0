From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/2] i2c-algo-bit: Be verbose on bus testing failure
Date: Tue, 4 Oct 2011 14:45:56 +0200
Message-ID: <201110041445.57054.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

If bus testing fails due to the bus being seen as busy, it might be
helpful for developers to know which line is unexpectedly low.

Signed-off-by: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-3.0.orig/drivers/i2c/algos/i2c-algo-bit.c	2011-10-03 18:50:34.000000000 +0200
+++ linux-3.0/drivers/i2c/algos/i2c-algo-bit.c	2011-10-03 18:55:14.000000000 +0200
@@ -250,7 +250,9 @@ static int test_bus(struct i2c_adapter *
 	sda = getsda(adap);
 	scl = (adap->getscl == NULL) ? 1 : getscl(adap);
 	if (!scl || !sda) {
-		printk(KERN_WARNING "%s: bus seems to be busy\n", name);
+		printk(KERN_WARNING
+		       "%s: bus seems to be busy (scl=%d, sda=%d)\n",
+		       name, scl, sda);
 		goto bailout;
 	}
 

-- 
Jean Delvare
Suse L3
