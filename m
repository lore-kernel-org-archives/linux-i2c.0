From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: added support for I2C_M_STOP flag
Date: Thu, 20 Jun 2013 21:39:16 +0200
Message-ID: <20130620193915.GD2961@katana>
References: <1371731837-1476-1-git-send-email-r.cerrato@til-technologies.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371731837-1476-1-git-send-email-r.cerrato-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Renaud Cerrato <r.cerrato-6YL8BHNr0ZqHdZQakrT3ElaPQRlvutdw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2013 at 02:37:17PM +0200, Renaud Cerrato wrote:
> Current i2c bit algo implementation doesn't actually support I2C_M_STOP f=
lag despite I2C_FUNC_PROTOCOL_MANGLING functionnality.

Signed-Off is missing :( Please run checkpatch.pl before sending
patches!

What was your testcase?

> ---
>  drivers/i2c/algos/i2c-algo-bit.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/i2c/algos/i2c-algo-bit.c b/drivers/i2c/algos/i2c-alg=
o-bit.c
> index fad22b0..00446a6 100644
> --- a/drivers/i2c/algos/i2c-algo-bit.c
> +++ b/drivers/i2c/algos/i2c-algo-bit.c
> @@ -557,6 +557,12 @@ static int bit_xfer(struct i2c_adapter *i2c_adap,
>  	for (i =3D 0; i < num; i++) {
>  		pmsg =3D &msgs[i];
>  		nak_ok =3D pmsg->flags & I2C_M_IGNORE_NAK;
> +		if (pmsg->flags & I2C_M_STOP) {
> +			if (i) {

Why 'if (i)'?

> +				bit_dbg(3, &i2c_adap->dev, "emitting stop condition\n");
> +				i2c_stop(adap);
> +			}
> +		}
>  		if (!(pmsg->flags & I2C_M_NOSTART)) {
>  			if (i) {
>  				bit_dbg(3, &i2c_adap->dev, "emitting "
> --=20
> 1.7.2.5
>=20
>=20

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRw1pjAAoJEBQN5MwUoCm2xfgP/Rn9y9Fg/wShnqmhtA8swWfr
WW7R2NK5+nfUPCuoBQD2WXg3mOAfofDhRa/CVmX3lXl7B4spxQmBOMrkEzoOxAym
y8ERSkRTDQzoGiBGm4cblig6i/3mr2h9YEdlOeTojXL1zrmVC/itt4+mpoPyqsN+
L0xoilvgsSTg2IfKRJIekS4Br+7s5ELC5/TV2o+Q5J1QXVYSLUeDRWB+VbFjfhv0
p2ez0IfX9rT5D2o3uQY2poUTyLTGYHkSJXCQqxrtOCneCFe6PyNN7Ch3xTMJguvj
dRTx9245mzvIV+UfiIUXkv2M6xZwIymxzynyy/TGcDWLE4v1puuBjSlgtNEuMKdJ
rhR4JqnoC6FIAXbQHUOI/lSVnV5b5h+YEGv4MjFff5KF1Ok71AYgHRqt+iUsG6cS
LiBot+bJcSykCx6LyjtoY5t/5hGmL8grE7tQVJZRFFzX35mpkAPSKZplmB1gEDUK
LFgcRm2kkKoEa9jro6QOpQHIOIAhjG/6gVv42kdU+eFHiva+wTbCwAbT/jjs7H/v
tDluAYUryQAoPDgCVEsHh6F1YNxdrJIcVbtK6TMIl5Oqv8AD6eTYCT8BvYWCFtNd
h0FAfILzkbWODtm7U82an1JFAikBMpv2OHJACVPDkfDIZC86PqgQcuuwbk/rXrWk
k5hdgpe37/Ql37vZcheh
=/BCB
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
