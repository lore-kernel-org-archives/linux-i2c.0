From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] fix PCA waitforcompletion() return value
Date: Wed, 22 Sep 2010 11:31:23 +0200
Message-ID: <20100922093123.GE2693@pengutronix.de>
References: <4C99CA70.2070109@visionsystems.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4C99CA70.2070109-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yegor Yefremov <yegor_sub1-ZJVcf1zZPRSebONBosFW4Q@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 22, 2010 at 11:20:48AM +0200, Yegor Yefremov wrote:
> ret is still -1, if during the polling read_byte() returns at once
> with I2C_PCA_CON_SI set. So ret > 0 would lead *_waitforcompletion()
> to return 0, in spite of the proper behavior.
>=20
> The routine was rewritten, so that ret has always a proper value,
> before returning.
>=20
> Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> Reviewed-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Great! Jean, I think this is .36-relevant. Do you plan another
pull-request (hmm, there is still my clientdata-patch ;))? Should
probably go to stable, too.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkyZzOsACgkQD27XaX1/VRtnJgCdHYfVFGnw592fvzjEIkXMdxkN
5XIAn13nGMQAnpfYe+1kHE9rFL2vTkvi
=e3tE
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
