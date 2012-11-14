From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v2] i2c: i2c-gpio: fix name issue when i2c gpio node GT 1
Date: Wed, 14 Nov 2012 09:59:44 +0100
Message-ID: <20121114085944.GA5954@pengutronix.de>
References: <1350287477-30936-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1350287477-30936-1-git-send-email-voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2012 at 03:51:17PM +0800, Bo Shen wrote:
> When i2c-gpio node number is greater than 1, the name for each is same
> So add the patch to fix it.
>=20
> The adap->name printing information is add by myself
>=20
> without this patch the log information is as following
> ---<8---
> adap->name =3D i2c-gpio-1
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name =3D i2c-gpio-1
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---
>=20
> with this patch, the log information is as following
> ---<8---
> adap->name =3D i2c.2
> i2c-gpio i2c.2: using pins 30 (SDA) and 31 (SCL)
> adap->name =3D i2c.3
> i2c-gpio i2c.3: using pins 64 (SDA) and 65 (SCL)
> --->8---
>=20
> Signed-off-by: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Applied to for-next, thanks.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCjXYAACgkQD27XaX1/VRu7hgCcDYO2jO8wLUqkNTtlMxKjKlbp
5cgAnjqjssmE7VB5MTtakljpY+LiCOAc
=msUl
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
