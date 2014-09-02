From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: imx: Add arbitration lost check
Date: Tue, 2 Sep 2014 12:43:24 +0200
Message-ID: <20140902104323.GD1266@katana>
References: <1409561920-9939-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409561920-9939-1-git-send-email-haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -268,6 +268,14 @@ static int i2c_imx_bus_busy(struct imx_i2c_struct *i=
2c_imx, int for_busy)
> =20
>  	while (1) {
>  		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> +
> +		/** check for arbitration lost **/

One '*' is enough on each side.

> +		if (temp & I2SR_IAL) {
> +			temp &=3D ~I2SR_IAL;
> +			imx_i2c_write_reg(temp, i2c_imx, IMX_I2C_I2SR);
> +			return -EIO;

Documentation/i2c/fault-codes defines 'EAGAIN' for arbitration lost.

> +		}
> +
>  		if (for_busy && (temp & I2SR_IBB))
>  			break;
>  		if (!for_busy && !(temp & I2SR_IBB))
> --=20
> 1.9.1
>=20

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUBZ9LAAoJEBQN5MwUoCm2JeYP/3JWs8FOTOYcBGMK9nHd0ylX
XH9WBBLtKpdcPB8knBr311qyC840Gh44LajtD2eSOVHjEMdPA1ePCA8JWcur4mOr
Dj24pz6qfw0l59k9GrbsKXLZmkn8V0e+gTriUv5MZb0uSvvlRBHiiFZNW2/lPbUQ
iYcaPHiKAj2k1I4jrDWcF79cZIXiafQ7WPiQFcAcZqeQw6XyKenk7B70pihO3hkM
IsinjrLSuELX8qnUJNR1nfANbvL4ODBJ8FEJUWIOQLWzbXZBp188AGs86xOksWgO
pEv4M1kngp2ntNsr+sPiLwppT9QTrkLgtjqnS6EMvfGZv5ih76Pv1CAnw/gUlFOf
fnHABlldlvqM0KKBUViYVq7WRnKnsDepsCdXXd6nDhfVNqZp9SKhTf7rgRtKLyKD
xKSECJxU7cHrqg/mSIVROysprQzY7neIBXUmCz2QejgcZeppsga/8clPVSZT/nY0
fvC1VkshCheq0tUCu6xN/PaBPRzLRU7h9i74UK5YwYkbltiThoJ4r1F/TfeOy+YX
RHcpN2tHMzjNoEJxW55uN9yZzStKRgvOCCcT/56o2tba7vYkJAtwuEDQTwt7i/Hi
sUCSHww4hFmFe+NofB2TfUCXDf/knAS9LMR/F0WZFMDMPT1Bz1OYNu2zinGStgSy
I3lSugtkFDk/pOkg2UGt
=+quL
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
