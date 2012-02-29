From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] i2c-mpc: avoid I2C abnormal after resuming from deep
 sleep
Date: Wed, 29 Feb 2012 19:45:23 +0100
Message-ID: <20120229183436.GA30545@pengutronix.de>
References: <1330511961-22498-1-git-send-email-chenhui.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1330511961-22498-1-git-send-email-chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 29, 2012 at 06:39:21PM +0800, Zhao Chenhui wrote:
> When entering deep sleep, the value in the registers I2CFDR and
> I2CDFSRR are lost. This causes I2C access to fail after resuming.
>=20
> Add suspend/resume routines to save/restore the registers
> I2CFDR and I2CDFSRR.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mpc.c |   34 +++++++++++++++++++++++++++++++++-
>  1 files changed, 33 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index a8ebb84..f95a647 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -1,7 +1,9 @@
>  /*
>   * (C) Copyright 2003-2004
>   * Humboldt Solutions Ltd, adrian-nKrwMtk+6WksDtB2XHyCLA@public.gmane.org
> -
> + *
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + *

I'd think the change is too trivial to claim copyright on the file.

Thanks for the contribution,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk9OckMACgkQD27XaX1/VRs2XACfQQbveoJtm/WnfrQckyPPPsfA
y6UAoJpeCjnmJNx18U8q0SMkraFDmwmv
=pAbL
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--
