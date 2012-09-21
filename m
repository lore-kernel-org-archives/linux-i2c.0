From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: [PATCH v2 RESEND] i2c: (algo-pca) Fix chip reset function for PCA9665
Date: Thu, 20 Sep 2012 20:20:46 -0700
Message-ID: <1348197646-5864-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>

The parameter passed to pca9665_reset is adap->data (which is bus driver
specific), not i2c_algp_pca_data *adap. pca9665_reset expects it to be
i2c_algp_pca_data *adap. All other wrappers from the algo call back to
the bus driver, which knows to handle its custom data. Only pca9665_reset
resides inside the algorithm code and does not know how to handle a custom
data structure. This can result in a kernel crash.

Fix by re-factoring pca_reset() from a macro to a function handling chip
specific code, and only call adap->reset_chip() if the chip is not PCA9665.

Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Thomas Kavanagh <tkavanagh-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
Signed-off-by: Guenter Roeck <groeck-3r7Miqu9kMnR7s880joybQ@public.gmane.org>
---
v2: Improve patch description

Wolfram, if there is anything else you are looking for (more detailed
explanation, maybe ?), please let us know.

 drivers/i2c/algos/i2c-algo-pca.c |   27 ++++++++++++++-------------
 include/linux/i2c-algo-pca.h     |    1 +
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/algos/i2c-algo-pca.c b/drivers/i2c/algos/i2c-algo-pca.c
index 73133b1..07ccbef 100644
--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -46,14 +46,19 @@ static int i2c_debug;
 #define pca_set_con(adap, val) pca_outw(adap, I2C_PCA_CON, val)
 #define pca_get_con(adap) pca_inw(adap, I2C_PCA_CON)
 #define pca_wait(adap) adap->wait_for_completion(adap->data)
-#define pca_reset(adap) adap->reset_chip(adap->data)
 
-static void pca9665_reset(void *pd)
+static void pca_reset(struct i2c_algo_pca_data *adap)
 {
-	struct i2c_algo_pca_data *adap = pd;
-	pca_outw(adap, I2C_PCA_INDPTR, I2C_PCA_IPRESET);
-	pca_outw(adap, I2C_PCA_IND, 0xA5);
-	pca_outw(adap, I2C_PCA_IND, 0x5A);
+	if (adap->chip == I2C_PCA_CHIP_9665) {
+		/* Ignore the reset function from the module,
+		 * we can use the parallel bus reset.
+		 */
+		pca_outw(adap, I2C_PCA_INDPTR, I2C_PCA_IPRESET);
+		pca_outw(adap, I2C_PCA_IND, 0xA5);
+		pca_outw(adap, I2C_PCA_IND, 0x5A);
+	} else {
+		adap->reset_chip(adap->data);
+	}
 }
 
 /*
@@ -378,11 +383,12 @@ static unsigned int pca_probe_chip(struct i2c_adapter *adap)
 	pca_outw(pca_data, I2C_PCA_INDPTR, I2C_PCA_IADR);
 	if (pca_inw(pca_data, I2C_PCA_IND) == 0xAA) {
 		printk(KERN_INFO "%s: PCA9665 detected.\n", adap->name);
-		return I2C_PCA_CHIP_9665;
+		pca_data->chip = I2C_PCA_CHIP_9665;
 	} else {
 		printk(KERN_INFO "%s: PCA9564 detected.\n", adap->name);
-		return I2C_PCA_CHIP_9564;
+		pca_data->chip = I2C_PCA_CHIP_9564;
 	}
+	return pca_data->chip;
 }
 
 static int pca_init(struct i2c_adapter *adap)
@@ -456,11 +462,6 @@ static int pca_init(struct i2c_adapter *adap)
 		 */
 		int raise_fall_time;
 
-		/* Ignore the reset function from the module,
-		 * we can use the parallel bus reset
-		 */
-		pca_data->reset_chip = pca9665_reset;
-
 		if (pca_data->i2c_clock > 1265800) {
 			printk(KERN_WARNING "%s: I2C clock speed too high."
 				" Using 1265.8kHz.\n", adap->name);
diff --git a/include/linux/i2c-algo-pca.h b/include/linux/i2c-algo-pca.h
index 1364d62..a3c3ecd 100644
--- a/include/linux/i2c-algo-pca.h
+++ b/include/linux/i2c-algo-pca.h
@@ -62,6 +62,7 @@ struct i2c_algo_pca_data {
 	 * 330000, 288000, 217000, 146000, 88000, 59000, 44000, 36000
 	 * For PCA9665, use the frequency you want here. */
 	unsigned int			i2c_clock;
+	unsigned int			chip;
 };
 
 int i2c_pca_add_bus(struct i2c_adapter *);
-- 
1.7.9.7
