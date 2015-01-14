From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c: imx: whitespace and checkpatch cleanup
Date: Wed, 14 Jan 2015 15:25:16 +0100
Message-ID: <20150114142516.GC1598@katana>
References: <1420555701-24645-1-git-send-email-p.zabel@pengutronix.de>
 <1420555701-24645-3-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1420555701-24645-3-git-send-email-p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Yao Yuan <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2015 at 03:48:21PM +0100, Philipp Zabel wrote:
> This patch fixes up some whitespace issues and addresses a few
> checkpatch warnings.

Well, since you asked for it... I am not so strict with the 80 char
limit:

> @@ -527,8 +528,10 @@ static int i2c_imx_start(struct imx_i2c_struct *i2c_=
imx)
>  		return result;
>  	imx_i2c_write_reg(i2c_imx->ifdr, i2c_imx, IMX_I2C_IFDR);
>  	/* Enable I2C controller */
> -	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2=
SR);
> -	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode, i2c_imx, IMX_I2C_I2=
CR);
> +	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
> +			  IMX_I2C_I2SR);
> +	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode, i2c_imx,
> +			  IMX_I2C_I2CR);

Please keep the old way, this is not more readable.

> @@ -781,7 +784,8 @@ static int i2c_imx_write(struct imx_i2c_struct *i2c_i=
mx, struct i2c_msg *msgs)
>  	return 0;
>  }
> =20
> -static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *=
msgs, bool is_lastmsg)
> +static int i2c_imx_read(struct imx_i2c_struct *i2c_imx, struct i2c_msg *=
msgs,
> +			bool is_lastmsg)

ditto

> @@ -843,8 +848,9 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_im=
x, struct i2c_msg *msgs, bo
>  		if (i =3D=3D (msgs->len - 1)) {
>  			if (is_lastmsg) {
>  				/*
> -				 * It must generate STOP before read I2DR to prevent
> -				 * controller from generating another clock cycle
> +				 * It must generate STOP before read I2DR to
> +				 * prevent controller from generating another
> +				 * clock cycle

ditto

> @@ -855,11 +861,13 @@ static int i2c_imx_read(struct imx_i2c_struct *i2c_=
imx, struct i2c_msg *msgs, bo
>  				i2c_imx->stopped =3D 1;
>  			} else {
>  				/*
> -				 * For i2c master receiver repeat restart operation like:
> +				 * For i2c master receiver repeat restart
> +				 * operation like:
>  				 * read -> repeat MSTA -> read/write
> -				 * The controller must set MTX before read the last byte in
> -				 * the first read operation, otherwise the first read cost
> -				 * one extra clock cycle.
> +				 * The controller must set MTX before read the
> +				 * last byte in the first read operation,
> +				 * otherwise the first read cost one extra clock
> +				 * cycle.

ditto

> @@ -918,15 +926,16 @@ static int i2c_imx_xfer(struct i2c_adapter *adapter,
>  		/* write/read data */
>  #ifdef CONFIG_I2C_DEBUG_BUS
>  		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> -		dev_dbg(&i2c_imx->adapter.dev, "<%s> CONTROL: IEN=3D%d, IIEN=3D%d, "
> -			"MSTA=3D%d, MTX=3D%d, TXAK=3D%d, RSTA=3D%d\n", __func__,
> +		dev_dbg(&i2c_imx->adapter.dev,
> +			"<%s> CONTROL: IEN=3D%d, IIEN=3D%d, MSTA=3D%d, MTX=3D%d, TXAK=3D%d, R=
STA=3D%d\n",
> +			__func__,

This is better than before, good.

>  			(temp & I2CR_IEN ? 1 : 0), (temp & I2CR_IIEN ? 1 : 0),
>  			(temp & I2CR_MSTA ? 1 : 0), (temp & I2CR_MTX ? 1 : 0),
>  			(temp & I2CR_TXAK ? 1 : 0), (temp & I2CR_RSTA ? 1 : 0));
>  		temp =3D imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
>  		dev_dbg(&i2c_imx->adapter.dev,
> -			"<%s> STATUS: ICF=3D%d, IAAS=3D%d, IBB=3D%d, "
> -			"IAL=3D%d, SRW=3D%d, IIF=3D%d, RXAK=3D%d\n", __func__,
> +			"<%s> STATUS: ICF=3D%d, IAAS=3D%d, IBB=3D%d, IAL=3D%d, SRW=3D%d, IIF=
=3D%d, RXAK=3D%d\n",
> +			__func__,

ditto

> @@ -1001,11 +1010,12 @@ static int i2c_imx_probe(struct platform_device *=
pdev)
>  				platform_get_device_id(pdev)->driver_data;
> =20
>  	/* Setup i2c_imx driver structure */
> -	strlcpy(i2c_imx->adapter.name, pdev->name, sizeof(i2c_imx->adapter.name=
));
> +	strlcpy(i2c_imx->adapter.name, pdev->name,
> +		sizeof(i2c_imx->adapter.name));

This not IMO.

> @@ -1045,7 +1055,8 @@ static int i2c_imx_probe(struct platform_device *pd=
ev)
>  	/* Set up chip registers to defaults */
>  	imx_i2c_write_reg(i2c_imx->hwdata->i2cr_ien_opcode ^ I2CR_IEN,
>  			i2c_imx, IMX_I2C_I2CR);
> -	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx, IMX_I2C_I2=
SR);
> +	imx_i2c_write_reg(i2c_imx->hwdata->i2sr_clr_opcode, i2c_imx,
> +			  IMX_I2C_I2SR);

ditto

Rest is appreciated, thanks.


--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtnxMAAoJEBQN5MwUoCm2mPQP/Azb8L6UT9vVF9ovFA/kEOpB
aG1KnysUM9npBkIBuL8sR4eNRAY4XZDuDvlvyrRUWmvuBDg6dEf9DJjap14BQejL
XTq5sdzGO0rZxAdo8IG4lfVqDDidc4qKgAfzZRrjXxJ6/UoF7SAi/JSWnG1Dx0jD
aQfLfsvnPq5dKKl76e56V1YdrxFnLRzLahTp9G41ISelGd+Ie3Oazd2Yigw//O/F
1BjuTM+jKlUo0+aTsTzLAQuS50W2595ANRii92YyvMQv6BOfQCqZ1KdSgi3sIriF
Iqd5S/wYnVjk2nntaFMvlRv+w53BRMH/A7Za5Xz7SAep3az3K4BjAK6atO3ZpnwM
CbeYc3ZVNtKF29NyV2RoYI0YGqsrT/3cxzWlsWfnU47RchAdw8onCpb+qkPjityO
/sxgy9w18nMar4aBTYuQMu6ceGBZCFIPuLf44UPWEkEHbOr3r7jD9xglbBEvEicy
imCw25Ib1ffOxBlksp0WSsYNJALL4BOWAKLe08JPn6jvC7Ehw+8TmUuILg0pg0i8
KXx9+/hy269lwEfccdQOt0k/5sgkUsyNQwsc6Y++5VUslnzSi7gcf9OjnHjPo+cL
bI+roKhZxHW2fyWKaJi5I91kBS8CISZ7mtCXvvbVoO9CqyocWYHfzpX0ctWENFW9
vxbsoiy+/YjPers9SHn3
=coQm
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
