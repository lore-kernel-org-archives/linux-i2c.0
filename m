From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH 2/2] i2c: (algo-pca) Fix mode selection for PCA9665
Date: Wed, 12 Sep 2012 20:39:51 -0700
Message-ID: <1347507591-32352-2-git-send-email-linux@roeck-us.net>
References: <1347507591-32352-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1347507591-32352-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>

As implemented, the code always selects turbo mode for PCA9665, no matter which
clock frequency is configured. This is because it compares clock boundaries
against constants reflecting (boundary / 100), but uses the actual clock frequency
to compare against. To fix the problem, use a variable reflecting (clock / 100),
not the actual clock frequency, when comparing against (boundary / 100).

Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
Signed-off-by: Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 07ccbef..572251b 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -477,17 +477,17 @@ static int pca_init(struct i2c_adapter *adap)
 		/* To avoid integer overflow, use clock/100 for calculations */
 		clock = pca_clock(pca_data) / 100;
 
-		if (pca_data->i2c_clock > 10000) {
+		if (clock > 10000) {
 			mode = I2C_PCA_MODE_TURBO;
 			min_tlow = 14;
 			min_thi  = 5;
 			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
-		} else if (pca_data->i2c_clock > 4000) {
+		} else if (clock > 4000) {
 			mode = I2C_PCA_MODE_FASTP;
 			min_tlow = 17;
 			min_thi  = 9;
 			raise_fall_time = 22; /* Raise 11e-8s, Fall 11e-8s */
-		} else if (pca_data->i2c_clock > 1000) {
+		} else if (clock > 1000) {
 			mode = I2C_PCA_MODE_FAST;
 			min_tlow = 44;
 			min_thi  = 20;
-- 
1.7.9.7
