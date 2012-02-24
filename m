From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH RESEND] i2c: Add Device Tree support to versatile-i2c
 driver
Date: Fri, 24 Feb 2012 11:58:04 +0100
Message-ID: <20120224105804.GA2479@pengutronix.de>
References: <1330021041-29782-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1330021041-29782-1-git-send-email-pawel.moll-5wv7dgnIgG8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> +static struct of_device_id i2c_versatile_match[] =3D {
> +	{ .compatible =3D "arm,versatile-i2c", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, i2c_versatile_match);

const here, but I fixed it up already.

Thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9HbTwACgkQD27XaX1/VRuEDQCgh06Us1+HMS473dJSimc4NsUX
kxEAoIEWCRyvW7KrsMxvrOoMVqysWX1Q
=VsOn
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
