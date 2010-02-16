From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] i2c-algo-pca: Drop duplicate variable
Date: Tue, 16 Feb 2010 12:22:28 +0100
Message-ID: <20100216122228.63984b93@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Thanks to -Wshadow.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-2.6.33-rc8.orig/drivers/i2c/algos/i2c-algo-pca.c	2009-06-10 05:05:27.000000000 +0200
+++ linux-2.6.33-rc8/drivers/i2c/algos/i2c-algo-pca.c	2010-02-16 12:04:46.000000000 +0100
@@ -453,8 +453,6 @@ static int pca_init(struct i2c_adapter *
 		 */
 		int raise_fall_time;
 
-		struct i2c_algo_pca_data *pca_data = adap->algo_data;
-
 		/* Ignore the reset function from the module,
 		 * we can use the parallel bus reset
 		 */


-- 
Jean Delvare
