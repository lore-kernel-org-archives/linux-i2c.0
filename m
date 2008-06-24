From: Laurent Pinchart <laurentp-BSmb2szPELAwsLKNixborgC/G2K4zDHf@public.gmane.org>
Subject: Re: [PATCH] Bugfixes for i2c-cpm.c
Date: Tue, 24 Jun 2008 16:15:04 +0200
Message-ID: <200806241615.08826.laurentp@cse-semaphore.com>
References: <20080620084155.GA17701@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4616240001715318097=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080620084155.GA17701-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

--===============4616240001715318097==
Content-Type: multipart/signed; boundary="nextPart1677227.aQeLyqX5XN";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1677227.aQeLyqX5XN
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 20 June 2008 10:41, Wolfram Sang wrote:
>=20
> Bugfixes to the i2c-cpm driver
>=20
> - enable correct interrupts (I2CER_TXE instead of I2CER_BUSY)
> - replace forgotten iic with i2c
> - fix typo (devided)
> - prefix debug-output on init with 0x and add frequency
>=20
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Tested on a MPC8247 board. I have experienced I2C issues since migration fr=
om=20
ppc to powerpc. This patch seems to solve the problem.

> ---
> Sorry for the resend; the CC to Jochen was dropped, haven't figured out
> why, yet.
>=20
>  drivers/i2c/busses/i2c-cpm.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> Index: drivers/i2c/busses/i2c-cpm.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/i2c/busses/i2c-cpm.c.orig
> +++ drivers/i2c/busses/i2c-cpm.c
> @@ -241,7 +241,7 @@
>  		eieio();
>  		setbits16(&tbdf->cbd_sc, BD_SC_READY);
>  	} else {
> -		dev_dbg(&adap->dev, "cpm_iic_write(abyte=3D0x%x)\n", addr);
> +		dev_dbg(&adap->dev, "cpm_i2c_write(abyte=3D0x%x)\n", addr);
> =20
>  		memcpy(tb+1, pmsg->buf, pmsg->len);
> =20
> @@ -350,7 +350,7 @@
>  	}
>  	/* Start transfer now */
>  	/* Enable RX/TX/Error interupts */
> -	out_8(&i2c_reg->i2cmr, I2CER_BUSY | I2CER_TXB | I2CER_RXB);
> +	out_8(&i2c_reg->i2cmr, I2CER_TXE | I2CER_TXB | I2CER_RXB);
>  	out_8(&i2c_reg->i2cer, 0xff);	/* Clear interrupt status */
>  	/* Chip bug, set enable here */
>  	setbits8(&i2c_reg->i2mod, I2MOD_EN);	/* Enable */
> @@ -553,8 +553,8 @@
> =20
>  	cpm_reset_i2c_params(cpm);
> =20
> -	dev_dbg(&cpm->ofdev->dev, "i2c_ram %p, i2c_addr 0x%04x\n",
> -		cpm->i2c_ram, cpm->i2c_addr);
> +	dev_dbg(&cpm->ofdev->dev, "i2c_ram 0x%p, i2c_addr 0x%04x, freq %d\n",
> +		cpm->i2c_ram, cpm->i2c_addr, cpm->freq);
>  	dev_dbg(&cpm->ofdev->dev, "tbase 0x%04x, rbase 0x%04x\n",
>  		(u8 __iomem *)cpm->tbase - DPRAM_BASE,
>  		(u8 __iomem *)cpm->rbase - DPRAM_BASE);
> @@ -568,7 +568,7 @@
> =20
>  	/*
>  	 * PDIV is set to 00 in i2mod, so brgclk/32 is used as input to the
> -	 * i2c baud rate generator. This is devided by 2 x (DIV + 3) to get
> +	 * i2c baud rate generator. This is divided by 2 x (DIV + 3) to get
>  	 * the actual i2c bus frequency.
>  	 */
>  	brg =3D get_brgfreq() / (32 * 2 * cpm->freq) - 3;
>=20

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1677227.aQeLyqX5XN
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIYQFs8y9gWxC9vpcRAi0hAKCRpRDufpa5+eP6gsFGLeiDQy1WpACdGBFz
iVXchZPW97FmJiYvDEYieD0=
=uSBQ
-----END PGP SIGNATURE-----

--nextPart1677227.aQeLyqX5XN--


--===============4616240001715318097==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============4616240001715318097==--
