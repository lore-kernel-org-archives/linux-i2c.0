From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] mxc i2c: let time to generate stop bit
Date: Thu, 21 Jan 2010 12:42:16 +0100
Message-ID: <20100121114216.GA3738@pengutronix.de>
References: <1264073263-16374-1-git-send-email-valentin.longchamp@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1264073263-16374-1-git-send-email-valentin.longchamp-p8DiymsW2f8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Valentin Longchamp <valentin.longchamp-p8DiymsW2f8@public.gmane.org>
Cc: s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2010 at 12:27:43PM +0100, Valentin Longchamp wrote:
> After generating the stop bit by changing MSTA from 1 to 0,
> the i2c_imx->stopped was immediatly set to 1. The second test
> on i2c_imx->stopped then is correct and the controller never
> waits if the bus is busy. This patch corrects this.
>=20
> On mx31moboard, stop bit was not generated on single write transfers.
> This was kept unnoticed other transfers are made afterwards that
> help the write recipient to resynchronize.

"as other transfers"?

> Thanks to Philippe and Michael for the debugging.

Either full names, or maybe even Reported-by or Tested-by tags?

> Signed-off-by: Valentin Longchamp <valentin.longchamp-p8DiymsW2f8@public.gmane.org>

Patch itself looks good to me:

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktYPZgACgkQD27XaX1/VRv3XwCglTn+rTB80xLCcKLiPOBG+cXY
YCQAn248D+TrBHPzILUSwwQCt9uzAN0N
=CNxZ
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
