From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Need help to fix some issues with the linux driver   "i2c-gpio"
Date: Tue, 14 Dec 2010 17:58:28 +0100
Message-ID: <20101214175828.0a62ce3f@endymion.delvare>
References: <4CF4DF5E020000AA0000808F@center.bmk-electronics.de>
	<20101130182150.3bbc8f01@endymion.delvare>
	<4CF62AFD020000AA000080E3@center.bmk-electronics.de>
	<20101202172322.43ea4698@endymion.delvare>
	<4CFCB095020000AA00008187@center.bmk-electronics.de>
	<20101206112557.3dc8ffe3@endymion.delvare>
	<4D025397020000AA00008248@center.bmk-electronics.de>
	<20101211172336.35c434ef@endymion.delvare>
	<4D0789C5020000AA00008346@center.bmk-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4D0789C5020000AA00008346-PZWwcLLCDcw8dQ1qNLwSjGRXbTvXh2ZWs0AfqQuZ5sE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Zacharias <Matthias.Zacharias-zGrmWZs6xXT+aS/vkh9bjw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Matthias,

On Tue, 14 Dec 2010 15:14:13 +0100, Matthias Zacharias wrote:
> Thanks for your patch. It is working very well.=20
> But one problem is left:
>     see "101214_1058_MLX_I2C_patched_0001.bmp" in my dropbox
> (http://www.dropbox.com/gallery/16457261/1/I2C_2_MLX90614?h=3D8e2a46)
>=20
> If between the read command (0x5a.0x6) and the answer (0x5a <3x
> data_bytes) the timeout condition:  SCL =3D High for 43=B5s match, th=
e
> MLX90614 go thru reset and returns an invalid value (0xFFFF).
>=20
> Where can I place the call for "spin_lock_irqsave" and
> "spin_unlock_irqrestore" to block this timeout situation.

Ah, I forgot the repeated start condition. The following updated patch
fixes this. I have also changed the code to no longer call scllo() when
the spinlock is held. That way we can release the spinlock (and thus
enable interrupts again) faster, which lowers the system latency.

So please give a try to this new patch, and report.

* * * * *

Candidate fix for SCL getting stretched when high resulting in
slave timeouts.

Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-bit.c |   33 +++++++++++++++++++++++++++++-=
---
 include/linux/i2c-algo-bit.h     |    3 +++
 2 files changed, 32 insertions(+), 4 deletions(-)

--- linux-2.6.27.orig/drivers/i2c/algos/i2c-algo-bit.c	2010-12-14 17:34=
:48.000000000 +0100
+++ linux-2.6.27/drivers/i2c/algos/i2c-algo-bit.c	2010-12-14 17:34:50.0=
00000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/sched.h>
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
+#include <linux/spinlock.h>
=20
=20
 /* ----- global defines ----------------------------------------------=
- */
@@ -131,12 +132,17 @@ static void i2c_start(struct i2c_algo_bi
=20
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
=20
=20
@@ -164,15 +170,18 @@ static int i2c_outb(struct i2c_adapter *
 	int sb;
 	int ack;
 	struct i2c_algo_bit_data *adap =3D i2c_adap->algo_data;
+	unsigned long flags;
=20
 	/* assert: scl is low */
 	for (i =3D 7; i >=3D 0; i--) {
 		sb =3D (c >> i) & 1;
 		setsda(adap, sb);
 		udelay((adap->udelay + 1) / 2);
+		spin_lock_irqsave(&adap->lockscl, flags);
 		if (sclhi(adap) < 0) { /* timed out */
 			bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
 				"timeout at bit #%d\n", (int)c, i);
+			spin_unlock_irqrestore(&adap->lockscl, flags);
 			return -ETIMEDOUT;
 		}
 		/* FIXME do arbitration here:
@@ -181,12 +190,16 @@ static int i2c_outb(struct i2c_adapter *
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
 		bit_dbg(1, &i2c_adap->dev, "i2c_outb: 0x%02x, "
 			"timeout at ack\n", (int)c);
+		spin_unlock_irqrestore(&adap->lockscl, flags);
 		return -ETIMEDOUT;
 	}
=20
@@ -197,7 +210,9 @@ static int i2c_outb(struct i2c_adapter *
 	bit_dbg(2, &i2c_adap->dev, "i2c_outb: 0x%02x %s\n", (int)c,
 		ack ? "A" : "NA");
=20
-	scllo(adap);
+	setscl(adap, 0);
+	spin_unlock_irqrestore(&adap->lockscl, flags);
+	udelay(adap->udelay / 2);
 	return ack;
 	/* assert: scl is low (sda undef) */
 }
@@ -210,19 +225,23 @@ static int i2c_inb(struct i2c_adapter *i
 	int i;
 	unsigned char indata =3D 0;
 	struct i2c_algo_bit_data *adap =3D i2c_adap->algo_data;
+	unsigned long flags;
=20
 	/* assert: scl is low */
 	sdahi(adap);
 	for (i =3D 0; i < 8; i++) {
+		spin_lock_irqsave(&adap->lockscl, flags);
 		if (sclhi(adap) < 0) { /* timeout */
 			bit_dbg(1, &i2c_adap->dev, "i2c_inb: timeout at bit "
 				"#%d\n", 7 - i);
+			spin_unlock_irqrestore(&adap->lockscl, flags);
 			return -ETIMEDOUT;
 		}
 		indata *=3D 2;
 		if (getsda(adap))
 			indata |=3D 0x01;
 		setscl(adap, 0);
+		spin_unlock_irqrestore(&adap->lockscl, flags);
 		udelay(i =3D=3D 7 ? adap->udelay / 2 : adap->udelay);
 	}
 	/* assert: scl is low */
@@ -385,16 +404,21 @@ static int sendbytes(struct i2c_adapter=20
 static int acknak(struct i2c_adapter *i2c_adap, int is_ack)
 {
 	struct i2c_algo_bit_data *adap =3D i2c_adap->algo_data;
+	unsigned long flags;
=20
 	/* assert: sda is high */
 	if (is_ack)		/* send ack */
 		setsda(adap, 0);
 	udelay((adap->udelay + 1) / 2);
+	spin_lock_irqsave(&adap->lockscl, flags);
 	if (sclhi(adap) < 0) {	/* timeout */
 		dev_err(&i2c_adap->dev, "readbytes: ack/nak timeout\n");
+		spin_unlock_irqrestore(&adap->lockscl, flags);
 		return -ETIMEDOUT;
 	}
-	scllo(adap);
+	setscl(adap, 0);
+	spin_unlock_irqrestore(&adap->lockscl, flags);
+	udelay(adap->udelay / 2);
 	return 0;
 }
=20
@@ -603,6 +627,7 @@ static int i2c_bit_prepare_bus(struct i2
 	}
=20
 	/* register new adapter to i2c module... */
+	spin_lock_init(&bit_adap->lockscl);
 	adap->algo =3D &i2c_bit_algo;
=20
 	adap->timeout =3D 100;	/* default values, should	*/
--- linux-2.6.27.orig/include/linux/i2c-algo-bit.h	2010-12-14 17:34:49.=
000000000 +0100
+++ linux-2.6.27/include/linux/i2c-algo-bit.h	2010-12-14 17:35:30.00000=
0000 +0100
@@ -24,6 +24,8 @@
 #ifndef _LINUX_I2C_ALGO_BIT_H
 #define _LINUX_I2C_ALGO_BIT_H
=20
+#include <linux/spinlock.h>
+
 /* --- Defines for bit-adapters --------------------------------------=
-	*/
 /*
  * This struct contains the hw-dependent functions of bit-style adapte=
rs to
@@ -36,6 +38,7 @@ struct i2c_algo_bit_data {
 	void (*setscl) (void *data, int state);
 	int  (*getsda) (void *data);
 	int  (*getscl) (void *data);
+	spinlock_t lockscl;
=20
 	/* local settings */
 	int udelay;		/* half clock cycle time in us,


--=20
Jean Delvare
