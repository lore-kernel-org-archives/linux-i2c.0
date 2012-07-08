From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v3] i2c: imx: convert to use managed functions
Date: Sun, 8 Jul 2012 13:22:55 +0200
Message-ID: <20120708112255.GA18362@pengutronix.de>
References: <1338776481-23710-1-git-send-email-richard.zhao@freescale.com>
 <1338807865-5487-1-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1338807865-5487-1-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 04, 2012 at 07:04:25PM +0800, Richard Zhao wrote:
> - convert to use devm_request_and_ioremap, devm_kzalloc, devm_clk_get,
>   devm_request_irq.
> - clean up unused variables.
>=20
> Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Reviewed-by: Shubhrajyoti D <Shubhrajyoti-l0cyMroinI0@public.gmane.org>

Thanks, applied to for-next.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/5bY8ACgkQD27XaX1/VRv4CQCgy3/wv15gNG6JHSbpd5DnCK0n
zZoAmwWaoL5MuNFUSf7DsKxUmaob8VUx
=7mpo
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
