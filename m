From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help to fix some issues with the linux driver "i2c-gpio"
Date: Wed, 15 Dec 2010 15:42:55 +0100
Message-ID: <20101215154255.20d471a4@endymion.delvare>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
	<20101130182150.3bbc8f01@endymion.delvare>
	<4CF62AFD020000AA000080E3@center.bmk-electronics.de>
	<20101202172322.43ea4698@endymion.delvare>
	<4CFCB095020000AA00008187@center.bmk-electronics.de>
	<20101206112557.3dc8ffe3@endymion.delvare>
	<4D025397020000AA00008248@center.bmk-electronics.de>
	<20101211172336.35c434ef@endymion.delvare>
	<4D0789C5020000AA00008346@center.bmk-electronics.de>
	<20101214175828.0a62ce3f@endymion.delvare>
	<4D08C6B2020000AA0000835E@center.bmk-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/m7GJGLUbq+eBQ_1//SXj1Qp"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D08C6B2020000AA0000835E-PZWwcLLCDcw8dQ1qNLwSjGRXbTvXh2ZWs0AfqQuZ5sE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Zacharias <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--MP_/m7GJGLUbq+eBQ_1//SXj1Qp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hallo Matthias,

On Wed, 15 Dec 2010 13:46:26 +0100, Matthias Zacharias wrote:
> Thank you for the new patch.
> I tried it and it works fine for our system with i2c_debug < 2.

Great, thanks for the feedback.

> For i2c_debug >=2 the debug outputs leads to timeout condition when
> address should be acknowledged.

Hmm, calling printk() with the spinlock held wasn't the smartest thing
to do, I guess. Updated patch attached, I've made sure to always
release the spinlock before calling bit_dbg(), hopefully it should fix
your last issue.

> I'll try to publish the "mlx90614" driver after doing some
> optimizations. Are you interested to review this driver before, because
> it is the first driver we try to publish?

Just publish it as is, and I'll review it publicly. It will certainly
take a number of round trips to get it right, if this is your first
contribution, but that's OK.

FYI, I have asked Melexis for an MLX90614 evaluation board, they have
sent something to me, so as soon as I receive it I should be able to
test your driver.

> Do plan to include your patch on the "i2c-algo-bit" into the lastest
> kernel?

Yes. Please test the new version of the patch, and if it works OK for
you, I'll schedule it for merge in kernel 2.6.38. For 2.6.37 it's too
late, the patch is quite intrusive and i2c-algo-bit is used by many
many drivers including very popular ones, so I can't merge it that late
in the release cycle.

> I had applied the patch and done my tests on the 2.6.25.4 kernel, with
> a bunch of other patches needed for my system. 
> 
> Thanks a lot for your fast and good support for fixing this issue we
> had.

You're welcome.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

--MP_/m7GJGLUbq+eBQ_1//SXj1Qp
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=i2c-algo-bit-protect-scl-high.patch

Candidate fix for SCL getting stretched when high resulting in
slave timeouts.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |   34 ++++++++++++++++++++++++++++++----
 include/linux/i2c-algo-bit.h     |    3 +++
 2 files changed, 33 insertions(+), 4 deletions(-)

--- linux-2.6.27.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-12-15 15:25:12.000000000 +0100
+++ linux-2.6.27/drivers/i2c/algos/i2c-algo-bit.c	2010-12-15 15:25:26.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/spinlock.h>
 
 
 /* ----- global defines ----------------------------------------------- */
@@ -131,12 +132,17 @@ static void i2c_start(struct i2c_algo_bi
 
 static void i2c_repstart(struct i2c_algo_bit_data *adap)
 {
+	unsigned long flags;
+
 	/* assert: scl is low */
 	sdahi(adap);
+	spin_lock_irqsave(&adap->lockscl, flags);
 	sclhi(adap);
 	setsda(adap, 0);
 	udelay(adap->udelay);
-	scllo(adap);
+	setscl(adap, 0);
+	spin_unlock_irqrestore(&adap->lockscl, flags);
+	udelay(adap->udelay / 2);
 }
 
 
@@ -164,13 +170,16 @@ static int i2c_outb(struct i2c_adapter *
 	int sb;
 	int ack;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	unsigned long flags;
 
 	/* assert: scl is low */
 	for (i = 7; i >= 0; i--) {
 		sb = (c >> i) & 1;
 		setsda(adap, sb);
 		udelay((adap->udelay + 1) / 2);
+		spin_lock_irqsave(&adap->lockscl, flags);
 		if (sclhi(adap) < 0) { /* timed out */
+			spin_unlock_irqrestore(&adap->lockscl, flags);
 			bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
 				"timeout at bit #%d\n", (int)c, i);
 			return -ETIMEDOUT;
@@ -181,10 +190,14 @@ static int i2c_outb(struct i2c_adapter *
 		 * Report a unique code, so higher level code can retry
 		 * the whole (combined) message and *NOT* issue STOP.
 		 */
-		scllo(adap);
+		setscl(adap, 0);
+		spin_unlock_irqrestore(&adap->lockscl, flags);
+		udelay(adap->udelay / 2);
 	}
 	sdahi(adap);
+	spin_lock_irqsave(&adap->lockscl, flags);
 	if (sclhi(adap) < 0) { /* timeout */
+		spin_unlock_irqrestore(&adap->lockscl, flags);
 		bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
 			"timeout at ack\n", (int)c);
 		return -ETIMEDOUT;
@@ -194,10 +207,13 @@ static int i2c_outb(struct i2c_adapter *
 	 * NAK (usually to report problems with the data we wrote).
 	 */
 	ack = !getsda(adap);    /* ack: sda is pulled low -> success */
+	setscl(adap, 0);
+	spin_unlock_irqrestore(&adap->lockscl, flags);
+	udelay(adap->udelay / 2);
+
 	bit_dbg(2, &i2c_adap->dev, "i2c_outb: 0x%02x %s\n", (int)c,
 		ack ? "A" : "NA");
 
-	scllo(adap);
 	return ack;
 	/* assert: scl is low (sda undef) */
 }
@@ -210,11 +226,14 @@ static int i2c_inb(struct i2c_adapter *i
 	int i;
 	unsigned char indata = 0;
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	unsigned long flags;
 
 	/* assert: scl is low */
 	sdahi(adap);
 	for (i = 0; i < 8; i++) {
+		spin_lock_irqsave(&adap->lockscl, flags);
 		if (sclhi(adap) < 0) { /* timeout */
+			spin_unlock_irqrestore(&adap->lockscl, flags);
 			bit_dbg(1, &i2c_adap->dev, "i2c_inb: timeout at bit "
 				"#%d\n", 7 - i);
 			return -ETIMEDOUT;
@@ -223,6 +242,7 @@ static int i2c_inb(struct i2c_adapter *i
 		if (getsda(adap))
 			indata |= 0x01;
 		setscl(adap, 0);
+		spin_unlock_irqrestore(&adap->lockscl, flags);
 		udelay(i == 7 ? adap->udelay / 2 : adap->udelay);
 	}
 	/* assert: scl is low */
@@ -385,16 +405,21 @@ static int sendbytes(struct i2c_adapter 
 static int acknak(struct i2c_adapter *i2c_adap, int is_ack)
 {
 	struct i2c_algo_bit_data *adap = i2c_adap->algo_data;
+	unsigned long flags;
 
 	/* assert: sda is high */
 	if (is_ack)		/* send ack */
 		setsda(adap, 0);
 	udelay((adap->udelay + 1) / 2);
+	spin_lock_irqsave(&adap->lockscl, flags);
 	if (sclhi(adap) < 0) {	/* timeout */
+		spin_unlock_irqrestore(&adap->lockscl, flags);
 		dev_err(&i2c_adap->dev, "readbytes: ack/nak timeout\n");
 		return -ETIMEDOUT;
 	}
-	scllo(adap);
+	setscl(adap, 0);
+	spin_unlock_irqrestore(&adap->lockscl, flags);
+	udelay(adap->udelay / 2);
 	return 0;
 }
 
@@ -603,6 +628,7 @@ static int i2c_bit_prepare_bus(struct i2
 	}
 
 	/* register new adapter to i2c module... */
+	spin_lock_init(&bit_adap->lockscl);
 	adap->algo = &i2c_bit_algo;
 
 	adap->timeout = 100;	/* default values, should	*/
--- linux-2.6.27.orig/include/linux/i2c-algo-bit.h	2010-12-15 15:25:12.000000000 +0100
+++ linux-2.6.27/include/linux/i2c-algo-bit.h	2010-12-15 15:25:44.000000000 +0100
@@ -24,6 +24,8 @@
 #ifndef _LINUX_I2C_ALGO_BIT_H
 #define _LINUX_I2C_ALGO_BIT_H
 
+#include <linux/spinlock.h>
+
 /* --- Defines for bit-adapters ---------------------------------------	*/
 /*
  * This struct contains the hw-dependent functions of bit-style adapters to
@@ -36,6 +38,7 @@ struct i2c_algo_bit_data {
 	void (*setscl) (void *data, int state);
 	int  (*getsda) (void *data);
 	int  (*getscl) (void *data);
+	spinlock_t lockscl;
 
 	/* local settings */
 	int udelay;		/* half clock cycle time in us,

--MP_/m7GJGLUbq+eBQ_1//SXj1Qp--
