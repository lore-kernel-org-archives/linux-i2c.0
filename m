From: Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCHv2 2/2] i2c: adapt debug macros for KERN_* constants
Date: Sun, 08 Feb 2009 15:20:31 +0100
Message-ID: <498EEA2F.5050601@suse.de>
References: <498C3EEA.5060508@suse.de> <498EE9C9.4080002@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <498EE9C9.4080002-l3A5Bk7waGM@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, ukleinek-jNDFPZUTrfROceuj71AUlABBhMqQ4zRThC4ANOJQIlc@public.gmane.org, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, Geert Uytterhoeven <Geert.Uytterhoeven-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Frank Seidel <fseidel-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

From: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>

According to kerneljanitors todo list all printk calls (beginning
a new line) should have an according KERN_* constant.
Those are the changes to the debug macros in the i2c subsystem
to meet this requirement. Also changing no-debug statements
to raw printks again.

Signed-off-by: Frank Seidel <frank-aMRDT+nbkrEb1SvskN2V4Q@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/i2c/algos/i2c-algo-pca.c
+++ b/drivers/i2c/algos/i2c-algo-pca.c
@@ -27,9 +27,12 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-pca.h>
 
-#define DEB1(fmt, args...) do { if (i2c_debug>=1) printk(fmt, ## args); } while(0)
-#define DEB2(fmt, args...) do { if (i2c_debug>=2) printk(fmt, ## args); } while(0)
-#define DEB3(fmt, args...) do { if (i2c_debug>=3) printk(fmt, ## args); } while(0)
+#define DEB1(fmt, args...) do { if (i2c_debug >= 1)			\
+				 printk(KERN_DEBUG fmt, ## args); } while (0)
+#define DEB2(fmt, args...) do { if (i2c_debug >= 2)			\
+				 printk(KERN_DEBUG fmt, ## args); } while (0)
+#define DEB3(fmt, args...) do { if (i2c_debug >= 3)			\
+				 printk(KERN_DEBUG fmt, ## args); } while (0)
 
 static int i2c_debug;
 
@@ -313,7 +316,7 @@ static int pca_xfer(struct i2c_adapter *
 
 	ret = curmsg;
  out:
-	DEB1(KERN_CRIT "}}} transfered %d/%d messages. "
+	DEB1("}}} transfered %d/%d messages. "
 	     "status is %#04x. control is %#04x\n",
 	     curmsg, num, pca_status(adap),
 	     pca_get_con(adap));
@@ -347,7 +350,8 @@ static int pca_init(struct i2c_adapter *
 	pca_reset(pca_data);
 
 	clock = pca_clock(pca_data);
-	DEB1(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name, freqs[clock]);
+	printk(KERN_INFO "%s: Clock frequency is %dkHz\n", adap->name,
+	       freqs[clock]);
 
 	pca_set_con(pca_data, I2C_PCA_CON_ENSIO | clock);
 	udelay(500); /* 500 us for oscilator to stabilise */
