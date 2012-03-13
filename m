From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/5 v4] i2c/gpio: add DT support
Date: Tue, 13 Mar 2012 15:08:22 +0100
Message-ID: <20120313140822.GD2488@pengutronix.de>
References: <1331642024-19869-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331642024-19869-1-git-send-email-plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 01:33:40PM +0100, Jean-Christophe PLAGNIOL-VILLARD =
wrote:

> update to use devm_kzalloc for private data

Hmm, you need really to work on the commit messages, not everybody is
familiar with DT and its implications:

"To achieve DT support, we need to populate a custom platform_data in a
private struct from DT information. To simplify code, the adapter and
algorithm are also put into the private struct."

Something like this?

> ---
> v4:
>=20
> 	fix timeout

You need to work on the changelogs as well :)

> 	use gpio_is_valid

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk9fVNYACgkQD27XaX1/VRuaPACfZxSWramyrOFoOEMXcx7VGLrN
5doAn2A8SLRjQS9GQKAEu5V7RA7YXiUT
=y1jw
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
