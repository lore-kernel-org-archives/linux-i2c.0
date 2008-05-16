From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 3/3] i2c: add support for i2c bus on
	Freescale	CPM1/CPM2 controllers
Date: Fri, 16 May 2008 10:37:43 +0200
Message-ID: <20080516083743.GA4180@pengutronix.de>
References: <200805142314.m4ENEjPV026316@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7870570749652878877=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <200805142314.m4ENEjPV026316-AB4EexQrvXRQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: vitb-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, htoa-hi6Y0CQ0nG0@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, tmbinc-hi6Y0CQ0nG0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--===============7870570749652878877==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2008 at 04:14:45PM -0700, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:

I just managed to test the latest version of this driver.

> +static int cpm_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, =
int num)
> +{
> +	struct cpm_i2c *cpm =3D i2c_get_adapdata(adap);
> +	struct i2c_reg __iomem *i2c_reg =3D cpm->i2c_reg;
> +	struct i2c_ram __iomem *i2c_ram =3D cpm->i2c_ram;
> +	struct i2c_msg *pmsg;
> +	int ret, i;
> +	int tptr;
> +	int rptr;
> +	cbd_t __iomem *tbdf;
> +	cbd_t __iomem *rbdf;
> +
> +	if (num > CPM_MAXBD)
> +		return -EINVAL;
> +
> +	/* Check if we have any oversized READ requests */
> +	for (i =3D 0; i < num; i++) {
> +		pmsg =3D &msgs[i];
> +		if (pmsg->len >=3D CPM_MAX_READ)
> +			return -EINVAL;
> +	}
> +
> +	/* Reset to use first buffer */
> +	out_be16(&i2c_ram->rbptr, in_be16(&i2c_ram->rbase));
> +	out_be16(&i2c_ram->tbptr, in_be16(&i2c_ram->tbase));
> +
> +	tbdf =3D cpm->tbase;
> +	rbdf =3D cpm->rbase;
> +
> +	tptr =3D 0;
> +	rptr =3D 0;
> +
> +	while (tptr < num) {
> +		pmsg =3D &msgs[tptr];
> +		dev_dbg(&adap->dev, "R: %d T: %d\n", rptr, tptr);
> +
> +		cpm_i2c_parse_message(adap, pmsg, num, tptr, rptr);
> +		if (pmsg->flags & I2C_M_RD)
> +			rptr++;
> +		tptr++;
> +	}
> +	/* Start transfer now */
> +	/* Enable RX/TX/Error interupts */
> +	out_8(&i2c_reg->i2cmr, I2CER_BUSY | I2CER_TXB | I2CER_RXB);
> +	out_8(&i2c_reg->i2cer, 0xff);	/* Clear interrupt status */
> +	/* Chip bug, set enable here */
> +	setbits8(&i2c_reg->i2mod, I2MOD_EN);	/* Enable */
> +	/* Begin transmission */
> +	setbits8(&i2c_reg->i2com, I2COM_MASTER);
Bummer! This should not be I2COM_MASTER but I2COM_START! Otherwise no
I2C communication will happen.

After applying this change, the driver works fine on an MPC8260 (like
the previous version did).

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD4DBQFILUfXD27XaX1/VRsRAsFqAJ9okWIIqx16mXNRCfa+KLytNAVy9gCYnd8J
sbAnHh/ZNcxQx95DvLy4wA==
=CnPn
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


--===============7870570749652878877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============7870570749652878877==--
