From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] i2c-algo-bit: make sure to call pre/post_xfer for bit_test
Date: Thu, 14 Apr 2011 19:47:06 -0400
Message-ID: <1302824827-7348-1-git-send-email-alexdeucher@gmail.com>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Apparently some distros set i2c-algo-bit.bit_test to 1 by
default.  In some cases this causes i2c_bit_add_bus
to fail and prevents the i2c bus from being added.  In the
radeon case, we fail to add the ddc i2c buses which prevents
the driver from being able to detect attached monitors.
The i2c bus works fine even if bit_test fails.  This is likely
due to gpio switching that is required and handled in the
pre/post_xfer hooks, so call the pre/post_xfer hooks in the
bit test as well.

Fixes:
https://bugs.freedesktop.org/show_bug.cgi?id=36221

Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-algo-bit.c
index 38319a6..e2740e6 100644
--- a/drivers/i2c/algos/i2c-algo-bit.c
+++ b/drivers/i2c/algos/i2c-algo-bit.c
@@ -232,9 +232,16 @@ static int i2c_inb(struct i2c_adapter *i2c_adap)
  * Sanity check for the adapter hardware - check the reaction of
  * the bus lines only if it seems to be idle.
  */
-static int test_bus(struct i2c_algo_bit_data *adap, char *name)
+static int test_bus(struct i2c_adapter *i2c_adap, char *name)
 {
-	int scl, sda;
+	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	int scl, sda, ret;
+
+	if (adap->pre_xfer) {
+		ret = adap->pre_xfer(i2c_adap);
+		if (ret < 0)
+			return -ENODEV;
+	}
 
 	if (adap->getscl == NULL)
 		pr_info("%s: Testing SDA only, SCL is not readable\n", name);
@@ -297,11 +304,19 @@ static int test_bus(struct i2c_algo_bit_data *adap, char *name)
 		       "while pulling SCL high!\n", name);
 		goto bailout;
 	}
+
+	if (adap->post_xfer)
+		adap->post_xfer(i2c_adap);
+
 	pr_info("%s: Test OK\n", name);
 	return 0;
 bailout:
 	sdahi(adap);
 	sclhi(adap);
+
+	if (adap->post_xfer)
+		adap->post_xfer(i2c_adap);
+
 	return -ENODEV;
 }
 
@@ -607,7 +622,7 @@ static int __i2c_bit_add_bus(struct i2c_adapter *adap,
 	int ret;
 
 	if (bit_test) {
-		ret = test_bus(bit_adap, adap->name);
+		ret = test_bus(adap, adap->name);
 		if (ret < 0)
 			return -ENODEV;
 	}
-- 
1.7.1.1
