From: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-pnx: fix setting start/stop condition
Date: Mon, 1 Mar 2010 20:19:54 +0100
Message-ID: <20100301191954.GA1811@pengutronix.de>
References: <1267446264-8446-1-git-send-email-l.fu@pengutronix.de> <083DF309106F364B939360100EC290F805CCF9294A@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="98e8jtXdkpgskNou"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <083DF309106F364B939360100EC290F805CCF9294A-SIPbe8o7cfX8DdpCu65jn8FrZmdRls4ZQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>
Cc: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Julia Lawall <julia-dAYI7NvHqcQ@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--98e8jtXdkpgskNou
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 01, 2010 at 07:43:24PM +0100, Kevin Wells wrote:
> Hi Luotao,
>=20
> >=20
> > The start/stop condtions are set in different places repetedly in the i=
2c-
> > pnx
> > driver.  Beside in i2c_pnx_start and i2c_pnx_stop the start/stop bit are
> > also
> > set during the transfer of a i2c message in the master_xmit/rcv calls.
> > This is
> > wrong since we can't set the start/stop condition during the transaction
> > of a
> > single message any way. As a matter of fact, the driver will sometimes =
set
> > both
> > the start and the stop bits at one time. This can be easily reproduced =
by
> > sending a simple read request like e.g
> > struct i2c_msg msgs[] =3D {
> > { addr, 0, 1, buf },
> > { addr, I2C_M_RD, offset, buf }
> > };
> > While processing the first message the i2c_pnx_master_xmit will set both
> > the
> > start_bit and the stop_bit, which will eventually confuse the slave.
> >=20
> > Fixed by remove setting start/stop condition from the transmit routines.
> >=20
> > Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > ---
> >  drivers/i2c/busses/i2c-pnx.c |   11 -----------
> >  1 files changed, 0 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> > index 5d1c260..92c0e46 100644
> > --- a/drivers/i2c/busses/i2c-pnx.c
> > +++ b/drivers/i2c/busses/i2c-pnx.c
> > @@ -175,12 +175,6 @@ static int i2c_pnx_master_xmit(struct i2c_adapter
> > *adap)
> >  		/* We still have something to talk about... */
> >  		val =3D *alg_data->mif.buf++;
> >=20
> > -		if (alg_data->mif.len =3D=3D 1) {
> > -			val |=3D stop_bit;
> > -			if (!alg_data->last)
> > -				val |=3D start_bit;
>=20
> Removing the start bit assertion here should be ok. The initial start
> condition is setup as part of the start of the transfer when the addr
> is sent out. The stop bit needs to stay or the I2C transfer will not
> correctly terminate on the last byte out and you will end up with a
> bus busy failure (clock low, data high) on the next transfer.

I had a closer look into this and think that you are right. I was
irritated by the unregular usage of start_bit and thought the stop bit
is asserted with the i2c_pnx_stop call, which is apparently only used
for zero sized transfers.

Fixed patch is attached with this mail.

cheers
Luotao Fu
--=20
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--HcAYCG3uE/tztfnV
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-i2c-pnx-fix-setting-start-condition.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 4a142700fec80489e3aa38b64d0b519d3968b0d9 Mon Sep 17 00:00:00 2001
=46rom: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Date: Mon, 1 Mar 2010 13:00:20 +0100
Subject: [PATCH] i2c-pnx: fix setting start condition

The start condtions is set in different places repeatedly in the i2c-pnx dr=
iver.
Beside in i2c_pnx_start the start bit is also set during the transfer of a =
i2c
message in the master_xmit/rcv calls. This is wrong since we can't set the =
start
condition during the transaction of a single message any way. As a matter of
fact, the driver will sometimes set both the start and the stop bits at one
time. This can be easily reproduced by sending a simple read request like e=
=2Eg
struct i2c_msg msgs[] =3D {
{ addr, 0, 1, buf },
{ addr, I2C_M_RD, offset, buf }
};
While processing the first message the i2c_pnx_master_xmit will set both the
start_bit and the stop_bit, which will eventually confuse the slave.

Fixed by remove setting start condition from the transmit routines.

Signed-off-by: Luotao Fu <l.fu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Acked-by: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-pnx.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 5d1c260..9edbe98 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -175,11 +175,9 @@ static int i2c_pnx_master_xmit(struct i2c_adapter *ada=
p)
 		/* We still have something to talk about... */
 		val =3D *alg_data->mif.buf++;
=20
-		if (alg_data->mif.len =3D=3D 1) {
+		/* last byte of a message */
+		if (alg_data->mif.len =3D=3D 1)
 			val |=3D stop_bit;
-			if (!alg_data->last)
-				val |=3D start_bit;
-		}
=20
 		alg_data->mif.len--;
 		iowrite32(val, I2C_REG_TX(alg_data));
@@ -254,9 +252,6 @@ static int i2c_pnx_master_rcv(struct i2c_adapter *adap)
 		if (alg_data->mif.len =3D=3D 1) {
 			/* Last byte, do not acknowledge next rcv. */
 			val |=3D stop_bit;
-			if (!alg_data->last)
-				val |=3D start_bit;
-
 			/*
 			 * Enable interrupt RFDAIE (data in Rx fifo),
 			 * and disable DRMIE (need data for Tx)
--=20
1.7.0


--HcAYCG3uE/tztfnV--

--98e8jtXdkpgskNou
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuME1oACgkQkLuxfMCkDTZQygCePDb6L1eBiaIAvhb9KTyOEhNR
et8AmgLLZWqmD0V9dywjsDtsUIf3a8CL
=b0Bu
-----END PGP SIGNATURE-----

--98e8jtXdkpgskNou--
