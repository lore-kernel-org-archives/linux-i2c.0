From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-algo-bit: Cleanup bus_test calling convention
Date: Fri, 15 Apr 2011 11:13:23 +0200
Message-ID: <20110415111323.51bef2ac@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Now that we pass the i2c_adapter as the first parameter, it makes
little sense to pass its name separately as the second.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
Alex, I think it would make sense to merge this into your own patch?

 drivers/i2c/algos/i2c-algo-bit.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.39-rc3.orig/drivers/i2c/algos/i2c-algo-bit.c	2011-04-15 10:47:39.000000000 +0200
+++ linux-2.6.39-rc3/drivers/i2c/algos/i2c-algo-bit.c	2011-04-15 11:05:09.000000000 +0200
@@ -232,9 +232,10 @@ static int i2c_inb(struct i2c_adapter *i
  * Sanity check for the adapter hardware - check the reaction of
  * the bus lines only if it seems to be idle.
  */
-static int test_bus(struct i2c_adapter *i2c_adap, char *name)
+static int test_bus(struct i2c_adapter *i2c_adap)
 {
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	const char *name = i2c_adap->name;
 	int scl, sda, ret;
 
 	if (adap->pre_xfer) {
@@ -622,7 +623,7 @@ static int __i2c_bit_add_bus(struct i2c_
 	int ret;
 
 	if (bit_test) {
-		ret = test_bus(adap, adap->name);
+		ret = test_bus(adap);
 		if (ret < 0)
 			return -ENODEV;
 	}


-- 
Jean Delvare
