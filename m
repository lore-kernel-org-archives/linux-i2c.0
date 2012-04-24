From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH V1 2/2] i2c: tegra: support for I2C_M_NOSTART protocol
 mangling
Date: Tue, 24 Apr 2012 15:28:10 +0200
Message-ID: <20120424132810.GE4030@pengutronix.de>
References: <1335251976-31925-1-git-send-email-ldewangan@nvidia.com>
 <1335251976-31925-3-git-send-email-ldewangan@nvidia.com>
 <20120424105557.7ac07232@endymion.delvare>
 <4F967089.3050004@nvidia.com>
 <20120424143241.0d66fd2e@endymion.delvare>
 <20120424124030.GD13747@opensource.wolfsonmicro.com>
 <20120424130118.GD4030@pengutronix.de>
 <20120424150750.36f8c2fc@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120424150750.36f8c2fc-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I think the assumption was that mangling requires full control of the
> bus lines, so a driver would either support all quirks (i2c-algo-bit)
> or none (everybody else), thus having a single functionality flag. As
> it seems I2C_M_NOSTART no longer fits the "quirky" category, having a
> separate flag for it would make sense. But I would leave the rest alone
> for the time being.

OK. We can still do what I proposed just in case the other mangling
features should ever become equally important ;)

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk+WqmoACgkQD27XaX1/VRuLpQCfZ/O8piFutX04a4tw0wpzXaYA
Es4AoKiZiBoWXCd6+EWv7Aj2MpiknRRp
=TvEQ
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
