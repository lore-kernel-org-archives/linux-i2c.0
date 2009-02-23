From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: Clarification on i2c-pca-platform driver timeout
Date: Mon, 23 Feb 2009 15:50:27 +0100
Message-ID: <20090223145027.GA3052@pengutronix.de>
References: <20090223152308.1db394a6@hyperion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090223152308.1db394a6-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jean,

On Mon, Feb 23, 2009 at 03:23:08PM +0100, Jean Delvare wrote:
> Hi Wolfram,
>=20
> I would like you to clarify the situation when it comes to the value of
> the timeout field of struct i2c_pca9564_pf_platform_data:
>=20
> struct i2c_pca9564_pf_platform_data {
> 	(...)
> 	int timeout;		/* timeout =3D this value * 10us */
> };
>=20
> The only user, board-sh7785lcr.c, sets this value to 100, resulting in
> a 1 ms timeout. This seems really short. Is this really intended?

This is a typo. It should say 10ms as a unit, resulting in 1s total.

> Why is the timeout value defined in such a strange unit?

I didn't change this in i2c-algo-pca.c back then, look at the beginning
of pca_xfer:

while ((state =3D pca_status(adap)) !=3D 0xf8 && timeout--) {
        msleep(10);
}

So, timeout acts as a loop counter in waiting for a free bus, which is
why your change in "Adapter timeout is in jiffies" alone won't do for
pca-based drivers. There seems to be a bigger rework needed for handling
the timeout :( I wanted to look into it this evening, but it seems to
be a bit urgent?

> static int __devinit i2c_pca_pf_probe(struct platform_device *pdev)
> {
> 	struct i2c_pca_pf_data *i2c;
> 	(...)
> 	struct i2c_pca9564_pf_platform_data *platform_data =3D
> 				pdev->dev.platform_data;
> 	(...)
> 	i2c->adap.timeout =3D platform_data->timeout;
>=20
> The problem is that i2c->adap.timeout is supposed to be expressed in
> jiffies, not units of 10 us. So there is a conversion missing.

Yup, see above.

> Lastly, you define a timeout value but never use it. Shouldn't you use
> wait_event_interruptible_timeout() instead of
> wait_event_interruptible() in i2c_pca_pf_waitforcompletion?

This is probably one part of the complete solution.

> An upcoming patch will add code which handles a timeout at i2c-core
> level, so it matters to get all i2c bus drivers right first.

Sounds reasonable...

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmit7MACgkQD27XaX1/VRtdZQCdGXXxOkwfiKPeE+NZmD2GPYTz
EUcAnR15kURn7rZ/anTWtKITZyTKcexO
=Eoxx
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
