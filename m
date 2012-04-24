From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V1 2/2] i2c: tegra: support for I2C_M_NOSTART protocol
 mangling
Date: Tue, 24 Apr 2012 15:01:18 +0200
Message-ID: <20120424130118.GD4030@pengutronix.de>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>
 <1335251976-31925-3-git-send-email-ldewangan@nvidia.com>
 <20120424105557.7ac07232@endymion.delvare>
 <4F967089.3050004@nvidia.com>
 <20120424143241.0d66fd2e@endymion.delvare>
 <20120424124030.GD13747@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120424124030.GD13747-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > * We should allocate a new functionality flag for it.
> > * We should update the documentation to reflect the two use cases.
>=20
> That sounds like a good plan.  I'll try to get round to it if nobody
> beats me to it.

Would it make sense to make all four I2C_M_* mangling features seperate
I2C_FUNC_* options? The old I2C_FUNC_PROTOCOL_MANGLING could then be all
four (seperately) exposed mangling features ORed. That's what I was
wondering when looking at the patch.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+WpB4ACgkQD27XaX1/VRsiywCeJwDI97Dx6+k0XxHuduZw3cbt
se8AmgPy9Y767S2+rssNea6vqblhRIr/
=EQLA
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
