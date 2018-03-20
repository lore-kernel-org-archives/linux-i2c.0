From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/3] i2c: mux: pca9541: namespace cleanup
Date: Tue, 20 Mar 2018 10:31:59 +0100
Message-ID: <20180320093200.19179-3-peda@axentia.se>
References: <20180320061909.5775-1-chen.kenyy@inventec.com>
 <20180320093200.19179-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180320093200.19179-1-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Ken Chen <chen.kenyy@inventec.com>, joel@jms.id.au, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

In preparation for PCA9641 support, convert the mybus and busoff macros
to functions, and in the process prefix them with pca9541_. Also prefix
remaining chip specific macros with PCA9541_.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/i2c/muxes/i2c-mux-pca9541.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
index ad168125d23d..47685eb4e0e9 100644
--- a/drivers/i2c/muxes/i2c-mux-pca9541.c
+++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
@@ -59,10 +59,8 @@
 #define PCA9541_ISTAT_MYTEST	BIT(6)
 #define PCA9541_ISTAT_NMYTEST	BIT(7)
 
-#define BUSON		(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
-#define MYBUS		(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
-#define mybus(x)	(!((x) & MYBUS) || ((x) & MYBUS) == MYBUS)
-#define busoff(x)	(!((x) & BUSON) || ((x) & BUSON) == BUSON)
+#define PCA9541_BUSON	(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
+#define PCA9541_MYBUS	(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
 
 /* arbitration timeouts, in jiffies */
 #define ARB_TIMEOUT	(HZ / 8)	/* 125 ms until forcing bus ownership */
@@ -93,6 +91,20 @@ static const struct of_device_id pca9541_of_match[] = {
 MODULE_DEVICE_TABLE(of, pca9541_of_match);
 #endif
 
+static int pca9541_mybus(int ctl)
+{
+	if (!(ctl & PCA9541_MYBUS))
+		return 1;
+	return (ctl & PCA9541_MYBUS) == PCA9541_MYBUS;
+}
+
+static int pca9541_busoff(int ctl)
+{
+	if (!(ctl & PCA9541_BUSON))
+		return 1;
+	return (ctl & PCA9541_BUSON) == PCA9541_BUSON;
+}
+
 /*
  * Write to chip register. Don't use i2c_transfer()/i2c_smbus_xfer()
  * as they will try to lock the adapter a second time.
@@ -181,7 +193,7 @@ static void pca9541_release_bus(struct i2c_client *client)
 	int reg;
 
 	reg = pca9541_reg_read(client, PCA9541_CONTROL);
-	if (reg >= 0 && !busoff(reg) && mybus(reg))
+	if (reg >= 0 && !pca9541_busoff(reg) && pca9541_mybus(reg))
 		pca9541_reg_write(client, PCA9541_CONTROL,
 				  (reg & PCA9541_CTL_NBUSON) >> 1);
 }
@@ -233,7 +245,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 	if (reg < 0)
 		return reg;
 
-	if (busoff(reg)) {
+	if (pca9541_busoff(reg)) {
 		int istat;
 		/*
 		 * Bus is off. Request ownership or turn it on unless
@@ -258,7 +270,7 @@ static int pca9541_arbitrate(struct i2c_client *client)
 			 */
 			data->select_timeout = SELECT_DELAY_LONG * 2;
 		}
-	} else if (mybus(reg)) {
+	} else if (pca9541_mybus(reg)) {
 		/*
 		 * Bus is on, and we own it. We are done with acquisition.
 		 * Reset NTESTON and BUSINIT, then return success.
-- 
2.11.0
