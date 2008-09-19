From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: PCA9665 support added to i2c-algo-pca and i2c-pca-isa.c
Date: Fri, 19 Sep 2008 16:55:00 +0200
Message-ID: <20080919145500.GH4307@pengutronix.de>
References: <48D3B5B7.1060402@gamic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4235653748625944810=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48D3B5B7.1060402-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Marco Aurelio da Costa <costa-nrw9SyMmU14AvxtiuMwx3w@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============4235653748625944810==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0XhtP95kHFp3KGBe"
Content-Disposition: inline


--0XhtP95kHFp3KGBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Here is the patch against 2.6.26.5.
> Please tell me if I did something very wrong ;)

I'm just about to leave the office, so just the first notes. Will have a
deeper look later this evening...

> +static void pca9665_reset(void *pd)
> +{
> +	struct i2c_algo_pca_data *adap =3D pd;
> +	pca_outw(adap,I2C_PCA_INDPTR,I2C_PCA_IPRESET);
> +	pca_outw(adap,I2C_PCA_IND,0xA5);
> +	pca_outw(adap,I2C_PCA_IND,0x5A);

CodingStyle issues (space after comma)...

> +	if (pca_data->i2c_chip_type !=3D I2C_PCA_CHIP_9564 && pca_data->i2c_chi=
p_type !=3D I2C_PCA_CHIP_9665 ) {

Line is longer than 80 chars. Please be sure to have run checkpatch.pl
before submitting.

> +=09

Trailing whitespaces here (and in some other places).


> +		int minTLow, minTHi;

This style of naming is at least unusual in kernel. Maybe min_tlow?

So much for now, more later...

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--0XhtP95kHFp3KGBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFI071BD27XaX1/VRsRAlzlAJ0Rk2uWyFeSeyh/OAfXRnnwDQzd2wCgivDm
JNbwdhqbzHQ8+f4v29dHcz8=
=d6+v
-----END PGP SIGNATURE-----

--0XhtP95kHFp3KGBe--


--===============4235653748625944810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4235653748625944810==--
