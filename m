From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 3/4] i2c: Add Actions Semiconductor Owl family S700
 I2C support
Date: Tue, 11 Dec 2018 21:54:44 +0100
Message-ID: <20181211205444.rpfn5cmsndy4y2lv@ninjato>
References: <20181211080448.24007-1-pn@denx.de>
 <20181211080448.24007-4-pn@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45isqxjr4vjntdmi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211080448.24007-4-pn@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Parthiban Nallathambi <pn@denx.de>
Cc: manivannan.sadhasivam@linaro.org, afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux@cubietech.com, thomas.liau@actions-semi.com, linux-actions@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org


--45isqxjr4vjntdmi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 09:04:47AM +0100, Parthiban Nallathambi wrote:
> Add S700 to the list of devices supported by Owl I2C driver.
>=20
> Add Actions Semiconductor Owl family S700 I2C driver.
>=20
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Rob, is this okay or should we drop this patch and update the DT to
contain first the s700 compatible and then s900 as fallback?

> ---
>  drivers/i2c/busses/i2c-owl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
> index 96b4572e6d9c..b6b5a495118b 100644
> --- a/drivers/i2c/busses/i2c-owl.c
> +++ b/drivers/i2c/busses/i2c-owl.c
> @@ -475,6 +475,7 @@ static int owl_i2c_probe(struct platform_device *pdev)
>  }
> =20
>  static const struct of_device_id owl_i2c_of_match[] =3D {
> +	{ .compatible =3D "actions,s700-i2c" },
>  	{ .compatible =3D "actions,s900-i2c" },
>  	{ /* sentinel */ }
>  };
> --=20
> 2.17.2
>=20

--45isqxjr4vjntdmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwQJA8ACgkQFA3kzBSg
KbYC5w//aduy+YzaN8BUpjKgg9R2sXqoXAc22xC6MfkvASLpCMVL2mdw7eNnUgOr
nkTSKS633l8l1yDzzFdreOMwk0LTYnJzEFwKKAUr/zDHmGZYfWjpx/cS8MhCHv+K
48V+gniY04EpacNvTmQssPGEIF6KDmdCxmacqBISLwVe1Npx5AF3IUxyosoyysv4
+ANDuF+Z3S6yOWnQcoXLHJ8iViSSSPXqoaJ0Jm+bUgZB+5osQbSL+viKsPze2aLA
30wTLJmm4qG3fHewozjO3qxkTTu1JTlvAPZmNB0g8jYRoZ/zlgr1FYC5I1B1ET/K
L8MKvLQfqPjczCJ/4joyl1TyVoikaTg98LYTghcnBe0P/pxSQknz+QHTAXwfsJU+
4xKOPyMpEPSjfIdmcWiWVhd1zXW3/R/lU33Tiw8VumMhK/oan9GHuef9IVmtFMbE
wRf9eR9JXJgIjNObQJ8c/EKy3PnGjwLOFCt6bSPJ7llGstE6JvcUYlZXbxQp4kNa
IdLiOUFxwykCOxrnS0ZuMUSwJaKRxQQrteD+dEuH/lQEiOcD8iAPDYTRxdajoOPB
Ga5Uw4VvM4oShExTlxKfPkhO4tv7NZ503SEFBEnpMo0SFFny+MVCIAERJmB2QkL2
QZdp7gZpsfNxzrNueaUtL92mLNrmrfmhDwQ8rE6tTl8Jb+cHMxI=
=cRo4
-----END PGP SIGNATURE-----

--45isqxjr4vjntdmi--
