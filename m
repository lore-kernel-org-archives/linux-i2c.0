From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3 0/3] i2c: at91: add dma support
Date: Thu, 22 Nov 2012 22:40:56 +0100
Message-ID: <20121122214056.GC14851@pengutronix.de>
References: <1352911493-6979-1-git-send-email-ludovic.desroches@atmel.com>
 <20121116170514.GA21903@pengutronix.de>
 <50ACA2D4.9040904@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50ACA2D4.9040904-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "ludovic.desroches" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >Thanks, looks mostly good. I have problems applying patch 3. What is
> >this series based against?
> >
>=20
> It was based against v3.7-rc4. Do you want me to rebase it against an
> over version?

That should be fine, but it still fails. The other patches apply, but
have offsets which is suspicious, too. Can you re-check, please?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCum+gACgkQD27XaX1/VRvSHwCgw/SijjOcudV7TcvVWeuq9W6n
kT8AnirkYhhNaUlZyStgPoLoJWrjsz77
=vTrG
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
