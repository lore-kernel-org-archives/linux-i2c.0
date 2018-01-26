From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 1/3] i2c: mv64xxx: Remove useless test before
 clk_disable_unprepare
Date: Fri, 26 Jan 2018 18:40:08 +0100
Message-ID: <20180126174008.a6eqrkottmvq3zfu@ninjato>
References: <20180116163540.1092-1-gregory.clement@free-electrons.com>
 <20180116163540.1092-2-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s5jfyzsvfmzuzwhm"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35626 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeAZRkK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Fri, 26 Jan 2018 12:40:10 -0500
Content-Disposition: inline
In-Reply-To: <20180116163540.1092-2-gregory.clement@free-electrons.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-i2c@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@free-electrons.com>, Nadav Haklai <nadavh@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Omri Itach <omrii@marvell.com>, Hanna Hawa <hannah@marvell.com>, Igal Liberman <igall@marvell.com>, Marcin Wojtas <mw@semihalf.com>


--s5jfyzsvfmzuzwhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 05:35:38PM +0100, Gregory CLEMENT wrote:
> The 2 functions called from clk_disable_unprepare() already check that
> the clock pointer is valid: no need to test it before calling it.

I can't find that in the code for !OF?

> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index a832c45276a4..f69066266faa 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -950,9 +950,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  exit_reset:
>  	reset_control_assert(drv_data->rstc);
>  exit_clk:
> -	/* Not all platforms have a clk */
> -	if (!IS_ERR(drv_data->clk))
> -		clk_disable_unprepare(drv_data->clk);
> +	clk_disable_unprepare(drv_data->clk);
> =20
>  	return rc;
>  }
> @@ -965,9 +963,7 @@ mv64xxx_i2c_remove(struct platform_device *dev)
>  	i2c_del_adapter(&drv_data->adapter);
>  	free_irq(drv_data->irq, drv_data);
>  	reset_control_assert(drv_data->rstc);
> -	/* Not all platforms have a clk */
> -	if (!IS_ERR(drv_data->clk))
> -		clk_disable_unprepare(drv_data->clk);
> +	clk_disable_unprepare(drv_data->clk);
> =20
>  	return 0;
>  }
> --=20
> 2.15.1
>=20

--s5jfyzsvfmzuzwhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlprZ/gACgkQFA3kzBSg
KbZCoRAAh7i0ngR6R5iDvsyRnt6B32/mKMQmujTsnMG6yh6hZLZwfOZs7Hs0Bkv5
dGAkvAuM/XuPves4yeKRorqoPiu24FaU4RqygYUuLvMmhGvwtgC59IMl+JE3lHeT
ovfcxIVuKrKtMRd9k5IJWrHcxgDdUa9xjNxaCAUbEn5ZSKMIwFST980292WY3SN6
7mUDJ6KZYqPlzBPBHxSyxXWktTfC4zxJER8fOWKuYemIr6Aoj1g/D1TOmIfhw39r
xW900pObHTESFMHir/U9R3YOJlvnSb+p6Zaa9nt3XIv5CQxKn3axPnd0Xr2Zha8B
bbVbD0fhXUS2SkgdtOL6E5QCgimXyZ7I+AmIScAJeEpA4lxFJBDUnNIGxLPWYFAm
6S/W30hg903YQDHFNwfBtREqvdLq+LRe9zr4bdd90+gbk0JuZPcUO3T9mQ620eCt
HR2szS6gkPvRyW3xoYHmctDg9B3ziBS1MNCw02xvJgbiFt1+7mhZ2mK1blM6MZ/2
ZkX8++GlfRnLw2ezi8jdufTgOIPOqAMxIK5y5ZdoYlyjH36Ra+N5g7lefZMspGSy
qqvA2i8qH2m2fteKvLIMoWpumTOH2qtEkyKVNDrGn9t12muE+9ZBVdVHjpNTu4Bc
9CQpj4TacexvLoc3RyRtyanhewGr9LbgiCzNp7lCS0og9vPMxPE=
=OPDE
-----END PGP SIGNATURE-----

--s5jfyzsvfmzuzwhm--
