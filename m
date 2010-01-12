From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v3 2/2] i2c: Davinci i2c bus recovery procedure to clear
 the bus
Date: Tue, 12 Jan 2010 16:47:16 +0530
Message-ID: <1263295036.3437.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

>From 2565eeda807e49376298ec895a0d9a91a7668417 Mon Sep 17 00:00:00 2001
From: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Date: Mon, 11 Jan 2010 22:39:44 +0530
Subject: [PATCH 2/2] Davinci i2c bus recovery procedure to clear the bus

Come out of i2c time out condition by following the
bus recovery procedure outlined in the i2c protocol v3 spec.
The kernel must be robust enough to gracefully recover
from i2c bus failure without having to reset the machine.
This is done by first NACKing the slave, pulsing the SCL
line 9 times and then sending the stop command.

This patch has been tested on a DM6446 and DM355

Signed-off-by: Philby John <pjohn-k0rHJ+Hhz/SB+jHODAdFcQ@public.gmane.org>
Signed-off-by: Srinivasan, Nageswari <nageswari-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-davinci.c |   57 +++++++++++++++++++++++++++++++++++--
 1 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 35f9daa..5459065 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -36,6 +36,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/cpufreq.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <mach/i2c.h>
@@ -43,6 +44,7 @@
 /* ----- global defines ----------------------------------------------- */
 
 #define DAVINCI_I2C_TIMEOUT	(1*HZ)
+#define DAVINCI_I2C_MAX_TRIES	2
 #define I2C_DAVINCI_INTR_ALL    (DAVINCI_I2C_IMR_AAS | \
 				 DAVINCI_I2C_IMR_SCD | \
 				 DAVINCI_I2C_IMR_ARDY | \
@@ -130,6 +132,44 @@ static inline u16 davinci_i2c_read_reg(struct davinci_i2c_dev *i2c_dev, int reg)
 	return __raw_readw(i2c_dev->base + reg);
 }
 
+/* Generate a pulse on the i2c clock pin. */
+static void generic_i2c_clock_pulse(unsigned int scl_pin)
+{
+	u16 i;
+
+	if (scl_pin) {
+		/* Send high and low on the SCL line */
+		for (i = 0; i < 9; i++) {
+			gpio_set_value(scl_pin, 0);
+			udelay(20);
+			gpio_set_value(scl_pin, 1);
+			udelay(20);
+		}
+	}
+}
+
+/* This routine does i2c bus recovery as specified in the
+ * i2c protocol Rev. 03 section 3.16 titled "Bus clear"
+ */
+static void i2c_recover_bus(struct davinci_i2c_dev *dev)
+{
+	u32 flag = 0;
+	struct davinci_i2c_platform_data *pdata = dev->dev->platform_data;
+
+	dev_err(dev->dev, "initiating i2c bus recovery\n");
+	/* Send NACK to the slave */
+	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
+	flag |=  DAVINCI_I2C_MDR_NACK;
+	/* write the data into mode register */
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+	if (pdata)
+		generic_i2c_clock_pulse(pdata->scl_pin);
+	/* Send STOP */
+	flag = davinci_i2c_read_reg(dev, DAVINCI_I2C_MDR_REG);
+	flag |= DAVINCI_I2C_MDR_STP;
+	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, flag);
+}
+
 static inline void davinci_i2c_reset_ctrl(struct davinci_i2c_dev *i2c_dev,
 								int val)
 {
@@ -235,14 +275,22 @@ static int i2c_davinci_wait_bus_not_busy(struct davinci_i2c_dev *dev,
 					 char allow_sleep)
 {
 	unsigned long timeout;
+	static u16 to_cnt;
 
 	timeout = jiffies + dev->adapter.timeout;
 	while (davinci_i2c_read_reg(dev, DAVINCI_I2C_STR_REG)
 	       & DAVINCI_I2C_STR_BB) {
-		if (time_after(jiffies, timeout)) {
-			dev_warn(dev->dev,
-				 "timeout waiting for bus ready\n");
-			return -ETIMEDOUT;
+		if (to_cnt <= DAVINCI_I2C_MAX_TRIES) {
+			if (time_after(jiffies, timeout)) {
+				dev_warn(dev->dev,
+				"timeout waiting for bus ready\n");
+				to_cnt++;
+				return -ETIMEDOUT;
+			} else {
+				to_cnt = 0;
+				i2c_recover_bus(dev);
+				i2c_davinci_init(dev);
+			}
 		}
 		if (allow_sleep)
 			schedule_timeout(1);
@@ -324,6 +372,7 @@ i2c_davinci_xfer_msg(struct i2c_adapter *adap, struct i2c_msg *msg, int stop)
 						      dev->adapter.timeout);
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
+		i2c_recover_bus(dev);
 		i2c_davinci_init(dev);
 		dev->buf_len = 0;
 		return -ETIMEDOUT;
-- 
1.6.3.3.MVISTA
