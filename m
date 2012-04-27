From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: possible MXS-i2c bug
Date: Fri, 27 Apr 2012 17:41:19 +0200
Message-ID: <20120427154119.GF16504@pengutronix.de>
References: <201204261326.29388.marex@denx.de>
 <201204270110.21377.marex@denx.de>
 <20120427145936.GD16504@pengutronix.de>
 <201204271708.53467.marex@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4VrXvz3cwkc87Wze"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201204271708.53467.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--4VrXvz3cwkc87Wze
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You can get a large list of i2c messages. In the current implementation, =
yes,=20
> they're iterated in mxs_i2c_xfer_msg. Correct.
>=20
> If you want to do DMA transfer do/from the i2c controller, you have to ta=
ke all=20
> these messages and create the chain of DMA transfers according to these=
=20
> messages, correct?

This is what I wonder. I'd think one could work on a per message basis.
Regarding Figure 27-10, the first I2C write command could be sent
seperately (probably even via PIOQUEUE). The only thing to be chained is
the I2C read command and the actual reading of the data.

Just checked, the FSL driver does it basically this way, too.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--4VrXvz3cwkc87Wze
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+avh8ACgkQD27XaX1/VRs9FwCaA2bj+QYNSuLNYVfMpWXgPOFF
U9gAoMlQ40iL//bCxv/4h6ovAzQYIV11
=wLH5
-----END PGP SIGNATURE-----

--4VrXvz3cwkc87Wze--
