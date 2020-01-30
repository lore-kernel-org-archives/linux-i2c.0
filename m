From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 2/4] i2c: cadence: Fix power management order of
 operations
Date: Thu, 30 Jan 2020 09:16:25 +0100
Message-ID: <20200130081625.GD2208@ninjato>
References: <1575888052-20447-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1575888052-20447-2-git-send-email-shubhrajyoti.datta@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2iBwrppp/7QCDedR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575888052-20447-2-git-send-email-shubhrajyoti.datta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: shubhrajyoti.datta@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, michal.simek@xilinx.com, Topi Kuutela <topi.kuutela@gmail.com>, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
List-Id: linux-i2c@vger.kernel.org


--2iBwrppp/7QCDedR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 04:10:50PM +0530, shubhrajyoti.datta@gmail.com wrot=
e:
> From: Topi Kuutela <topi.kuutela@gmail.com>
>=20
> E.g. pm_runtime_set_active must be called while the power
> management system is disabled. Fixes extra hanging clk_enable.
>=20
> Signed-off-by: Topi Kuutela <topi.kuutela@gmail.com>
> Acked-by: S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Applied to for-next, thanks!


--2iBwrppp/7QCDedR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4ykNkACgkQFA3kzBSg
KbZLSw//Qj2IsaxaO7GNfF/3meWOEJFTqbhUE9zXJoJfxJf0NouwK/IuGil5BbuX
ifFprSf4UweNaa5FIxj96bKE0XRtEJt8TiuzGr6+LJl9TFWakD5YMdPsPMG3+AS7
yT8tfmp69NkHkE0Sav1hu7nQHTD/a8c0pxu2+PUvy9yp+NuiXxBYLaHTgLjSW9qf
Z8ncMN9YTY55cFPS1JdQCfEBrvv0DZA4v5BeykAe8BLGb3iGUAipqNO+BE3eCPsp
HoCWPy+reIdxgJJ6lk2OuSZg0ffHy/lmpLejE2ty7De4cUrM97TNZijgw7/sxGcP
dESRNX1fU2q6GGTKReJnW6b5dM/6iHOn75eE/X79CtrE0wloEKmmcQPdI9WX5fGA
0agW2CEBDD5r9f4nkQepzY9fGec7NzLKWfrdvigUMu8Kumez0DREqj5i+yIT6j4M
OSuXzI6ZaiinVbqlqli6toG4LqguQ35n1P2VVdO/0P4xR9+OSDYoWSlZ3x6Vzsli
9o9KwW1z+9DfwYzr6W3BQmGssNkUbXSl8bq5ObbQfzQrhM9QoMFI3Jd/87/+Tr3h
JioVxSZagyo/iF8m9lsVE6aTXLHnTpgX3IW2QPLNiTuleDbRgQM3iWuhJtt9KaFU
u2YS6uVQVSIePkSp0sHcg9hCi0HD/lI62vGfkjSnuwbqSSjszWo=
=61Uf
-----END PGP SIGNATURE-----

--2iBwrppp/7QCDedR--
