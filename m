From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: =?UTF-8?q?=5BPATCH=2013/15=5D=20i2c=3A=20iop3xx=3A=20clean-up=20trailing=20whitespace?=
Date: Fri,  6 Jul 2012 13:40:38 -0500
Message-ID: <1341600040-30993-14-git-send-email-robherring2@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1341600040-30993-1-git-send-email-robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

=46rom: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>

Remove a bunch of trailing whitespace. No functional changes.

Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 drivers/i2c/busses/i2c-iop3xx.c |  112 +++++++++++++++++++------------=
--------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-i=
op3xx.c
index 93f147a..567d873 100644
--- a/drivers/i2c/busses/i2c-iop3xx.c
+++ b/drivers/i2c/busses/i2c-iop3xx.c
@@ -4,13 +4,13 @@
 /* Copyright (C) 2003 Peter Milne, D-TACQ Solutions Ltd
  *                    <Peter dot Milne at D hyphen TACQ dot com>
  *
- * With acknowledgements to i2c-algo-ibm_ocp.c by=20
+ * With acknowledgements to i2c-algo-ibm_ocp.c by
  * Ian DaSilva, MontaVista Software, Inc. idasilva-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
  *
  * And i2c-algo-pcf.c, which was created by Simon G. Vogl and Hans Ber=
glund:
  *
  * Copyright (C) 1995-1997 Simon G. Vogl, 1998-2000 Hans Berglund
- * =20
+ *
  * And which acknowledged Ky=C3=B6sti M=C3=A4lkki <kmalkki-kf+aQKke1yb1KXRcyAk9cg@public.gmane.org>,
  * Frodo Looijaard <frodol-B0qZmFHriGg@public.gmane.org>, Martin Bailey<mbailey@littlefeet-i=
nc.com>
  *
@@ -45,8 +45,8 @@
 /* global unit counter */
 static int i2c_id;
=20
-static inline unsigned char=20
-iic_cook_addr(struct i2c_msg *msg)=20
+static inline unsigned char
+iic_cook_addr(struct i2c_msg *msg)
 {
 	unsigned char addr;
=20
@@ -55,24 +55,24 @@ iic_cook_addr(struct i2c_msg *msg)
 	if (msg->flags & I2C_M_RD)
 		addr |=3D 1;
=20
-	return addr;  =20
+	return addr;
 }
=20
-static void=20
+static void
 iop3xx_i2c_reset(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	/* Follows devman 9.3 */
 	__raw_writel(IOP3XX_ICR_UNIT_RESET, iop3xx_adap->ioaddr + CR_OFFSET);
 	__raw_writel(IOP3XX_ISR_CLEARBITS, iop3xx_adap->ioaddr + SR_OFFSET);
 	__raw_writel(0, iop3xx_adap->ioaddr + CR_OFFSET);
-}=20
+}
=20
-static void=20
+static void
 iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	u32 cr =3D IOP3XX_ICR_GCD | IOP3XX_ICR_SCLEN | IOP3XX_ICR_UE;
=20
-	/*=20
+	/*
 	 * Every time unit enable is asserted, GPOD needs to be cleared
 	 * on IOP3XX to avoid data corruption on the bus.
 	 */
@@ -86,7 +86,7 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx=
_adap)
 	}
 #endif
 	/* NB SR bits not same position as CR IE bits :-( */
-	iop3xx_adap->SR_enabled =3D=20
+	iop3xx_adap->SR_enabled =3D
 		IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD |
 		IOP3XX_ISR_RXFULL | IOP3XX_ISR_TXEMPTY;
=20
@@ -96,23 +96,23 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3=
xx_adap)
 	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
=20
-static void=20
+static void
 iop3xx_i2c_transaction_cleanup(struct i2c_algo_iop3xx_data *iop3xx_ada=
p)
 {
 	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
-=09
-	cr &=3D ~(IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE |=20
+
+	cr &=3D ~(IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE |
 		IOP3XX_ICR_MSTOP | IOP3XX_ICR_SCLEN);
=20
 	__raw_writel(cr, iop3xx_adap->ioaddr + CR_OFFSET);
 }
=20
-/*=20
- * NB: the handler has to clear the source of the interrupt!=20
+/*
+ * NB: the handler has to clear the source of the interrupt!
  * Then it passes the SR flags of interest to BH via adap data
  */
-static irqreturn_t=20
-iop3xx_i2c_irq_handler(int this_irq, void *dev_id)=20
+static irqreturn_t
+iop3xx_i2c_irq_handler(int this_irq, void *dev_id)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D dev_id;
 	u32 sr =3D __raw_readl(iop3xx_adap->ioaddr + SR_OFFSET);
@@ -126,7 +126,7 @@ iop3xx_i2c_irq_handler(int this_irq, void *dev_id)
 }
=20
 /* check all error conditions, clear them , report most important */
-static int=20
+static int
 iop3xx_i2c_error(u32 sr)
 {
 	int rc =3D 0;
@@ -135,12 +135,12 @@ iop3xx_i2c_error(u32 sr)
 		if ( !rc ) rc =3D -I2C_ERR_BERR;
 	}
 	if ((sr & IOP3XX_ISR_ALD)) {
-		if ( !rc ) rc =3D -I2C_ERR_ALD;	=09
+		if ( !rc ) rc =3D -I2C_ERR_ALD;
 	}
-	return rc;=09
+	return rc;
 }
=20
-static inline u32=20
+static inline u32
 iop3xx_i2c_get_srstat(struct i2c_algo_iop3xx_data *iop3xx_adap)
 {
 	unsigned long flags;
@@ -161,8 +161,8 @@ iop3xx_i2c_get_srstat(struct i2c_algo_iop3xx_data *=
iop3xx_adap)
 typedef int (* compare_func)(unsigned test, unsigned mask);
 /* returns 1 on correct comparison */
=20
-static int=20
-iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap,=20
+static int
+iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data *iop3xx_adap,
 			  unsigned flags, unsigned* status,
 			  compare_func compare)
 {
@@ -192,47 +192,47 @@ iop3xx_i2c_wait_event(struct i2c_algo_iop3xx_data=
 *iop3xx_adap,
 }
=20
 /*
- * Concrete compare_funcs=20
+ * Concrete compare_funcs
  */
-static int=20
+static int
 all_bits_clear(unsigned test, unsigned mask)
 {
 	return (test & mask) =3D=3D 0;
 }
=20
-static int=20
+static int
 any_bits_set(unsigned test, unsigned mask)
 {
 	return (test & mask) !=3D 0;
 }
=20
-static int=20
+static int
 iop3xx_i2c_wait_tx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int =
*status)
 {
-	return iop3xx_i2c_wait_event(=20
-		iop3xx_adap,=20
+	return iop3xx_i2c_wait_event(
+		iop3xx_adap,
 	        IOP3XX_ISR_TXEMPTY | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status, any_bits_set);
 }
=20
-static int=20
+static int
 iop3xx_i2c_wait_rx_done(struct i2c_algo_iop3xx_data *iop3xx_adap, int =
*status)
 {
-	return iop3xx_i2c_wait_event(=20
-		iop3xx_adap,=20
+	return iop3xx_i2c_wait_event(
+		iop3xx_adap,
 		IOP3XX_ISR_RXFULL | IOP3XX_ISR_ALD | IOP3XX_ISR_BERRD,
 		status,	any_bits_set);
 }
=20
-static int=20
+static int
 iop3xx_i2c_wait_idle(struct i2c_algo_iop3xx_data *iop3xx_adap, int *st=
atus)
 {
-	return iop3xx_i2c_wait_event(=20
+	return iop3xx_i2c_wait_event(
 		iop3xx_adap, IOP3XX_ISR_UNITBUSY, status, all_bits_clear);
 }
=20
-static int=20
-iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,=20
+static int
+iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap,
 				struct i2c_msg* msg)
 {
 	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
@@ -247,7 +247,7 @@ iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_=
data *iop3xx_adap,
 	}
=20
 	__raw_writel(iic_cook_addr(msg), iop3xx_adap->ioaddr + DBR_OFFSET);
-=09
+
 	cr &=3D ~(IOP3XX_ICR_MSTOP | IOP3XX_ICR_NACK);
 	cr |=3D IOP3XX_ICR_MSTART | IOP3XX_ICR_TBYTE;
=20
@@ -257,8 +257,8 @@ iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_=
data *iop3xx_adap,
 	return rc;
 }
=20
-static int=20
-iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char b=
yte,=20
+static int
+iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char b=
yte,
 				int stop)
 {
 	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
@@ -277,10 +277,10 @@ iop3xx_i2c_write_byte(struct i2c_algo_iop3xx_data=
 *iop3xx_adap, char byte,
 	rc =3D iop3xx_i2c_wait_tx_done(iop3xx_adap, &status);
=20
 	return rc;
-}=20
+}
=20
-static int=20
-iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char* b=
yte,=20
+static int
+iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data *iop3xx_adap, char* b=
yte,
 				int stop)
 {
 	unsigned long cr =3D __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
@@ -304,19 +304,19 @@ iop3xx_i2c_read_byte(struct i2c_algo_iop3xx_data =
*iop3xx_adap, char* byte,
 	return rc;
 }
=20
-static int=20
+static int
 iop3xx_i2c_writebytes(struct i2c_adapter *i2c_adap, const char *buf, i=
nt count)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
 	int ii;
 	int rc =3D 0;
=20
-	for (ii =3D 0; rc =3D=3D 0 && ii !=3D count; ++ii)=20
+	for (ii =3D 0; rc =3D=3D 0 && ii !=3D count; ++ii)
 		rc =3D iop3xx_i2c_write_byte(iop3xx_adap, buf[ii], ii=3D=3Dcount-1);
 	return rc;
 }
=20
-static int=20
+static int
 iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, char *buf, int coun=
t)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
@@ -325,7 +325,7 @@ iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, =
char *buf, int count)
=20
 	for (ii =3D 0; rc =3D=3D 0 && ii !=3D count; ++ii)
 		rc =3D iop3xx_i2c_read_byte(iop3xx_adap, &buf[ii], ii=3D=3Dcount-1);
-=09
+
 	return rc;
 }
=20
@@ -336,8 +336,8 @@ iop3xx_i2c_readbytes(struct i2c_adapter *i2c_adap, =
char *buf, int count)
  * Each transfer (i.e. a read or a write) is separated by a repeated s=
tart
  * condition.
  */
-static int=20
-iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pm=
sg)=20
+static int
+iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap, struct i2c_msg* pm=
sg)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
 	int rc;
@@ -357,8 +357,8 @@ iop3xx_i2c_handle_msg(struct i2c_adapter *i2c_adap,=
 struct i2c_msg* pmsg)
 /*
  * master_xfer() - main read/write entry
  */
-static int=20
-iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *m=
sgs,=20
+static int
+iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_adap, struct i2c_msg *m=
sgs,
 				int num)
 {
 	struct i2c_algo_iop3xx_data *iop3xx_adap =3D i2c_adap->algo_data;
@@ -375,14 +375,14 @@ iop3xx_i2c_master_xfer(struct i2c_adapter *i2c_ad=
ap, struct i2c_msg *msgs,
 	}
=20
 	iop3xx_i2c_transaction_cleanup(iop3xx_adap);
-=09
+
 	if(ret)
 		return ret;
=20
-	return im;  =20
+	return im;
 }
=20
-static u32=20
+static u32
 iop3xx_i2c_func(struct i2c_adapter *adap)
 {
 	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
@@ -393,11 +393,11 @@ static const struct i2c_algorithm iop3xx_i2c_algo=
 =3D {
 	.functionality	=3D iop3xx_i2c_func,
 };
=20
-static int=20
+static int
 iop3xx_i2c_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *padapter =3D platform_get_drvdata(pdev);
-	struct i2c_algo_iop3xx_data *adapter_data =3D=20
+	struct i2c_algo_iop3xx_data *adapter_data =3D
 		(struct i2c_algo_iop3xx_data *)padapter->algo_data;
 	struct resource *res =3D platform_get_resource(pdev, IORESOURCE_MEM, =
0);
 	unsigned long cr =3D __raw_readl(adapter_data->ioaddr + CR_OFFSET);
@@ -419,7 +419,7 @@ iop3xx_i2c_remove(struct platform_device *pdev)
 	return 0;
 }
=20
-static int=20
+static int
 iop3xx_i2c_probe(struct platform_device *pdev)
 {
 	struct resource *res;
--=20
1.7.9.5
