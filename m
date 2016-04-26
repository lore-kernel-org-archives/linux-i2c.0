From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] The input clock of I2C should be platform/2
Date: Tue, 26 Apr 2016 23:31:57 +0200
Message-ID: <20160426213157.GH4587@katana>
References: <1453880893-3015-1-git-send-email-ying.zhang22455@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:52463 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbcDZVcA (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 26 Apr 2016 17:32:00 -0400
Content-Disposition: inline
In-Reply-To: <1453880893-3015-1-git-send-email-ying.zhang22455@nxp.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: ying.zhang22455@nxp.com
Cc: linux-i2c@vger.kernel.org, xiaobo.xie@nxp.com, york.sun@nxp.com, b45385@freescale.com, Ying Zhang <b40530@freescale.com>


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 27, 2016 at 03:48:13PM +0800, ying.zhang22455@nxp.com wrote:
> From: Ying Zhang <b40530@freescale.com>
>=20

The patch description should state where this information comes from.

> Signed-off-by: Ying Zhang <b40530@freescale.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index a2b132c..806cb99 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -475,7 +475,7 @@ static void i2c_imx_set_clk(struct imx_i2c_struct *i2=
c_imx)
>  	int i;
> =20
>  	/* Divider value calculation */
> -	i2c_clk_rate =3D clk_get_rate(i2c_imx->clk);
> +	i2c_clk_rate =3D clk_get_rate(i2c_imx->clk) / 2;
>  	if (i2c_imx->cur_clk =3D=3D i2c_clk_rate)
>  		return;
> =20
> --=20
> 2.1.0.27.g96db324
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXH95NAAoJEBQN5MwUoCm2E54P+QFJhphatv62QQ8fMKu0gcff
qoWhjXo8L05tOpTkH6NsjqEPvAoDG6ebck5dHWqQIf/GM1rr0xfUSfRlFrXHad80
uXBfqFSP3HGVr2OA1Nm55MKW2RG2SCQ5wVlEZQZJIvdqJzLSBEGHOGkcb9nHzq+L
qH8QulFPu1rINiJYraH1B6B4EU6u4qtRaPhIS8N9eTt3zgt6M0LxlGzOa41p+ort
auj/cK5MMmq5gb1S1vSCgKJ7ecZyje8Nxa+i+eprxhGegt459f8XVbSyOrxlceQZ
IFryFFrjIv9/Z8F8493G6y32jmog+aUjSvkYQkaanhaurcVBLrr2qvKGJKKsCQJy
K/d19KZ8BSlbIEodgqraA3cwbdLcg36TSW0tqzmtNmBMa9ABfVryBGBNFA9+9NaM
rd08dVNr1MfhWutCOx1kY/nKhelp5SM0W/2LSDCiuPVEYx80AI6ENoEFMd44lGg1
xhKtwKJeqVbmdAfkKFMrgs/TlfAJh/gApt4OtnibGjdbrqS/tSdQ23t3WygKvYyl
FKERfZqFBZDvcLA931N0zMM2R23fdPZ/Q9UQ5ReQnTFNJPlaQj2u6xzs+UymgUNi
TTdK84IHgK0aBQHwM2661uNjU766WOcOCAbBT/u8AoMdztbxlcphDvw3vqv0L2dN
WizaIhe4ZR5+qnzGaG30
=KoZS
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
