From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [GIT PULL] i2c updates for 2.6.30
Date: Wed, 8 Apr 2009 10:13:03 +0200
Message-ID: <20090408101303.71399654@hyperion.delvare>
References: <20090328213950.1c788471@hyperion.delvare>
	<10f740e80904071320t2fdd073bs51f3a8abf0f60e36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <10f740e80904071320t2fdd073bs51f3a8abf0f60e36-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Geert,

On Tue, 7 Apr 2009 22:20:29 +0200, Geert Uytterhoeven wrote:
> On Sat, Mar 28, 2009 at 22:39, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrot=
e:
> > Please pull the i2c subsystem updates for Linux 2.6.30 from:
>=20
> > Wolfram Sang (4):
> > =A0 =A0 =A0i2c-algo-pca: Rework waiting for a free bus
>=20
> This one introduced:
>=20
> drivers/i2c/algos/i2c-algo-pca.c:197: warning: 'state' is used
> uninitialized in this function
>=20
> Probably
>=20
>         while (pca_status(adap) !=3D 0xf8) {
>=20
> should become
>=20
>         while ((state =3D pca_status(adap)) !=3D 0xf8) {
>=20
> again.

You're perfectly right, I must have missed it because I didn't build
any kernel with CONFIG_I2C_DEBUG_ALGO=3Dy for a long time. Here's the f=
ix
I will push to Linus soon:

=46rom: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: i2c-algo-pca: Fix use of uninitialized variable in debug messa=
ge

A recent change broke debugging of pca_xfer(), fix it.

Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/i2c/algos/i2c-algo-pca.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.30-rc1.orig/drivers/i2c/algos/i2c-algo-pca.c	2009-04-08 0=
8:52:48.000000000 +0200
+++ linux-2.6.30-rc1/drivers/i2c/algos/i2c-algo-pca.c	2009-04-08 10:06:=
36.000000000 +0200
@@ -190,7 +190,7 @@ static int pca_xfer(struct i2c_adapter *
 	int completed =3D 1;
 	unsigned long timeout =3D jiffies + i2c_adap->timeout;
=20
-	while (pca_status(adap) !=3D 0xf8) {
+	while ((state =3D pca_status(adap)) !=3D 0xf8) {
 		if (time_before(jiffies, timeout)) {
 			msleep(10);
 		} else {


--=20
Jean Delvare
