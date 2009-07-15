From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] don't add i2c_imx_driver's probe function to the driver
	struct
Date: Wed, 15 Jul 2009 09:38:30 +0200
Message-ID: <20090715073830.GA24155@pengutronix.de>
References: <1247428431-27315-1-git-send-email-u.kleine-koenig@pengutronix.de> <20090712204010.GA342@pengutronix.de> <20090714225537.GB10277@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090714225537.GB10277-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

i2c_imx_driver is registered using platform_driver_probe which takes
care for the probe function itself.  So don't pass it in the driver
struct, too.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
---
Hi Ben,

On Tue, Jul 14, 2009 at 11:55:37PM +0100, Ben Dooks wrote:
> On Sun, Jul 12, 2009 at 10:40:10PM +0200, Wolfram Sang wrote:
> > On Sun, Jul 12, 2009 at 09:53:50PM +0200, Uwe Kleine-K?nig wrote:
> > > i2c_imx_driver is registered using platform_driver_probe which ta=
kes
> > > care for the probe function itself.  So don't pass it in the driv=
er
> > > struct, too.
> > > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > > Cc: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > > Cc: Darius Augulis <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> >=20
> > Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> >=20
> > Adding linux-i2c to CC...
>=20
> Can I have the original to apply please?
hhhhmm?  According to my sent mail folder you got a Cc of the original
mail.  Anyhow, here it comes again.  The only difference to the first
post is that Wolfram's Cc: became an Acked-by:

Best regards
Uwe

 drivers/i2c/busses/i2c-imx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.=
c
index 0b486a6..b7a0ac7 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -597,7 +597,6 @@ static int __exit i2c_imx_remove(struct platform_de=
vice *pdev)
 }
=20
 static struct platform_driver i2c_imx_driver =3D {
-	.probe		=3D i2c_imx_probe,
 	.remove		=3D __exit_p(i2c_imx_remove),
 	.driver	=3D {
 		.name	=3D DRIVER_NAME,
--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
