From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: [PATCH] i2c: davinci: rename "i2c_recover_bus" function
Date: Thu, 4 Apr 2013 13:54:29 +0000
Message-ID: <201304041354.30024.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

As of commit 5f9296ba "i2c: Add bus recovery infrastructure", there
is now a global function with the same name, which clashes with
the davinci specific one. The obvious solution is to rename the
function with a davinci prefix.

Signed-off-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 7d1e590..3acc65a 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -155,7 +155,7 @@ static void generic_i2c_clock_pulse(unsigned int scl_pin)
 /* This routine does i2c bus recovery as specified in the
  * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
  */
-static void i2c_recover_bus(struct davinci_i2c_dev *dev)
+static void i2c_davinci_recover_bus(struct davinci_i2c_dev *dev)
 {
 	u32 flag = 0;
 	struct davinci_i2c_platform_data *pdata = dev->pdata;
@@ -289,7 +289,7 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
 				return -ETIMEDOUT;
 			} else {
 				to_cnt = 0;
-				i2c_recover_bus(dev);
+				i2c_davinci_recover_bus(dev);
 				i2c_davinci_init(dev);
 			}
 		}
@@ -379,7 +379,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 						      dev->adapter.timeout);
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
-		i2c_recover_bus(dev);
+		i2c_davinci_recover_bus(dev);
 		i2c_davinci_init(dev);
 		dev->buf_len = 0;
 		return -ETIMEDOUT;
