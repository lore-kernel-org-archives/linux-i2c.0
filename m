From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/2] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
Date: Thu, 2 Jan 2014 19:41:21 +0100
Message-ID: <20140102184120.GD3914@katana>
References: <1388678476-12875-1-git-send-email-gregory.clement@free-electrons.com>
 <1388678476-12875-3-git-send-email-gregory.clement@free-electrons.com>
 <20140102182822.GI19878@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140102182822.GI19878@titan.lakedaemon.net>
Sender: stable-owner@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Wolfram Sang <w.sang@pengutronix.de>, linux-i2c@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2014 at 01:28:22PM -0500, Jason Cooper wrote:
> Wolfram,
>=20
> On Thu, Jan 02, 2014 at 05:01:16PM +0100, Gregory CLEMENT wrote:
> > The first variants of Armada XP SoCs (A0 stepping) have issues related
> > to the i2c controller which prevent to use the offload mechanism and
> > lead to a kernel hang during boot.
> >=20
> > The driver now check the revision of the SoC. If the revision is not
> > more recent than the A0 or if the driver can't get the SoC revision
> > then it disables the offload mechanism.
> >=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> >  drivers/i2c/busses/i2c-mv64xxx.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-=
mv64xxx.c
> > index 8be7e42aa4de..089a3663ad86 100644
> > --- a/drivers/i2c/busses/i2c-mv64xxx.c
> > +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> >  #include <linux/delay.h>
> > +#include <linux/mvebu-soc-id.h>
> > =20
> >  #define MV64XXX_I2C_ADDR_ADDR(val)			((val & 0x7f) << 1)
> >  #define MV64XXX_I2C_BAUD_DIV_N(val)			(val & 0x7)
> > @@ -779,8 +780,16 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_dat=
a,
> >  	 * Transaction Generator support and the errata fix.
> >  	 */
> >  	if (of_device_is_compatible(np, "marvell,mv78230-i2c")) {
> > -		drv_data->offload_enabled =3D true;
> > +		u32 dev, rev;
> > +
> >  		drv_data->errata_delay =3D true;
> > +		/*
> > +		 * Only revison more recent than A0 support offload
> > +		 * mechanism. In case we can't get the SoC revision
> > +		 * weplay safe and we don't enable it
> > +		 */
> > +		if (!mvebu_get_soc_id(&rev, &dev) && (dev > MV78XX0_A0_REV))

Very minor nits:

I'd prefer (mvebu_get_soc_id =3D=3D 0) here, since !mvebu_get_soc_id can
easily be read as "if not get soc id" which leads to the assumption the
function failed. And the parantheses around the second comparison are
superfluous.

> > +			drv_data->offload_enabled =3D true;
>=20
> Since this depends on arch-specific code in the previous patch, I'd like
> to keep the two of them together in a topic branch.  Would you prefer to
> take both with my Ack, or vice-versa?  I'm fine either way.

I'd think you better take it:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSxbLQAAoJEBQN5MwUoCm2KBgQAIw/UtphnrcLlQWZ3JZYJENu
5j5JBb2hkzmUKV1xge8jtruCV6qIF1tyZ0cxkqdOGL/riEtqsKOKFkx1oDHaELZG
Aq5qtVNtd3DBUKIia26xrjs7evx9RYeRddkr5mryLxa/foOUsWp8lt+5gOx1CG3N
Vmq+/z9IN6ZtFu3Dna9FsLNJFbdN5bZIpX849GStdwWmEkaSgk5RS8b4PdX02SYt
OpoT8PQDDaFSi8Xj/CH2pgAcmE+WhIHQpwr2+ggRrkHaUAJ7SGsZKLvituxkeiRa
FVUYsYFMpz8mhQ+kmcDxy3erapCnnzIb5JREt3h75MxQ0Ta2/UVrLbvcHMRckbG0
ay0qIoKlzii/bK0fbk+NTpsHNvu4Z8TKcmR5djFnyFsYyOlQ+Dx7PxEkHdN7KQUd
PNgxW1bb8AivVqkmBnZnCmW783iS2AO4OhnNM+R6F+eRdM3SY7EN37pLHjusDNaP
QVY2wmC1tmLjZF1tHdylOp+pdCQL1pRMqtYrlwWrDEAZ6xkzgFW4rCSzF0QN6M/l
Y1489C67DGFOOVPQBssmILNaEJchoDhfsGxWIGn2QNQqY3NarhpDq2Zkd499rvqk
Z8JHySwElj3QeO1rTCP8oWlN2Vbh4pjDV+0svBrzS87YrBIhepi6+uiRZ1qEVKe4
op4KbvNANDLooZGJ2wvZ
=F8E4
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
