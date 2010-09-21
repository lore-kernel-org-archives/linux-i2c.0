From: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Subject: [PATCH v2] fix i2c_pca_pf_waitforcompletion() return value
Date: Tue, 21 Sep 2010 11:15:47 +0200
Message-ID: <4C9877C3.30106@visionsystems.de>
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
with I2C_PCA_CON_SI set. So ret > 0 would lead 
i2c_pca_pf_waitforcompletion() to return 0, in spite of
the proper behavior. 

Solution: get rid of ret and make immediate return where possible.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

Index: b/drivers/i2c/busses/i2c-pca-platform.c
===================================================================
--- a/drivers/i2c/busses/i2c-pca-platform.c	2010-09-21 10:53:46.000000000 +0200
+++ b/drivers/i2c/busses/i2c-pca-platform.c	2010-09-21 10:59:18.000000000 +0200
@@ -80,23 +80,26 @@
 static int i2c_pca_pf_waitforcompletion(void *pd)
 {
 	struct i2c_pca_pf_data *i2c = pd;
-	long ret = ~0;
 	unsigned long timeout;
 
 	if (i2c->irq) {
-		ret = wait_event_timeout(i2c->wait,
+		return wait_event_timeout(i2c->wait,
 			i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
 			& I2C_PCA_CON_SI, i2c->adap.timeout);
 	} else {
 		/* Do polling */
 		timeout = jiffies + i2c->adap.timeout;
-		while (((i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
-				& I2C_PCA_CON_SI) == 0)
-				&& (ret = time_before(jiffies, timeout)))
-			udelay(100);
+		while (!(i2c->algo_data.read_byte(i2c, I2C_PCA_CON)
+				& I2C_PCA_CON_SI))
+		{
+			if(time_before(jiffies, timeout))
+				udelay(100);
+			else
+				return 0;
+		}
 	}
 
-	return ret > 0;
+	return ~0;
 }
 
 static void i2c_pca_pf_dummyreset(void *pd)
