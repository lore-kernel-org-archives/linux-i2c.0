From: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Subject: [PATCH] fix PCA waitforcompletion() return value
Date: Wed, 22 Sep 2010 11:20:48 +0200
Message-ID: <4C99CA70.2070109@visionsystems.de>
Reply-To: yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

ret is still -1, if during the polling read_byte() returns at once
with I2C_PCA_CON_SI set. So ret > 0 would lead *_waitforcompletion()
to return 0, in spite of the proper behavior.

The routine was rewritten, so that ret has always a proper value,
before returning.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Index: b/drivers/i2c/busses/i2c-pca-platform.c
===================================================================
--- a/drivers/i2c/busses/i2c-pca-platform.c	2010-09-22 09:31:12.000000000 +0200
+++ b/drivers/i2c/busses/i2c-pca-platform.c	2010-09-22 11:10:58.000000000 +0200
@@ -80,8 +80,8 @@
 static int i2c_pca_pf_waitforcompletion(void *pd)
 {
 	struct i2c_pca_pf_data *i2c = pd;
-	long ret = ~0;
 	unsigned long timeout;
+	long ret;
 
 	if (i2c->irq) {
 		ret = wait_event_timeout(i2c->wait,
@@ -90,10 +90,13 @@
 	} else {
 		/* Do polling */
 		timeout = jiffies + i2c->adap.timeout;
-		while (((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
-				& I2C_PCA_CON_SI) == 0)
-				&& (ret = time_before(jiffies, timeout)))
+		do {
+			ret = time_before(jiffies, timeout);
+			if (i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
+					& I2C_PCA_CON_SI)
+				break;
 			udelay(100);
+		} while (ret);
 	}
 
 	return ret > 0;
Index: b/drivers/i2c/busses/i2c-pca-isa.c
===================================================================
--- a/drivers/i2c/busses/i2c-pca-isa.c	2010-08-27 01:47:12.000000000 +0200
+++ b/drivers/i2c/busses/i2c-pca-isa.c	2010-09-22 11:10:38.000000000 +0200
@@ -71,8 +71,8 @@
 
 static int pca_isa_waitforcompletion(void *pd)
 {
-	long ret = ~0;
 	unsigned long timeout;
+	long ret;
 
 	if (irq > -1) {
 		ret = wait_event_timeout(pca_wait,
@@ -81,11 +81,15 @@
 	} else {
 		/* Do polling */
 		timeout = jiffies + pca_isa_ops.timeout;
-		while (((pca_isa_readbyte(pd, I2C_PCA_CON)
-				& I2C_PCA_CON_SI) == 0)
-				&& (ret = time_before(jiffies, timeout)))
+		do {
+			ret = time_before(jiffies, timeout);
+			if (pca_isa_readbyte(pd, I2C_PCA_CON)
+					& I2C_PCA_CON_SI)
+				break;
 			udelay(100);
+		} while (ret);
 	}
+
 	return ret > 0;
 }
 
