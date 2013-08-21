From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v5 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
Date: Wed, 21 Aug 2013 23:01:17 +0200
Message-ID: <20130821210116.GA3130@katana>
References: <1376039158-1896-1-git-send-email-gregory.clement@free-electrons.com>
 <1376039158-1896-2-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1376039158-1896-2-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Maen Suleiman <maen-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Eran Ben-Avi <benavi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Yehuda Yitschak <yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ike Pan <ike.pan-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Chris Van Hoof <vanhoof-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Dan Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Leif Lindholm <leif.lindholm-5wv7dgnIgG8@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Marlin <dmarlin-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

here is the review. BTW have you tested with and without the offload
engine?

> +static int mv64xxx_i2c_offload_msg(struct mv64xxx_i2c_data *drv_data)
> +{
> +	unsigned long data_reg_hi =3D 0;
> +	unsigned long data_reg_lo =3D 0;
> +	unsigned long ctrl_reg;
> +	unsigned int i;
> +	struct i2c_msg *msg =3D drv_data->msgs;
> +
> +	drv_data->msg =3D msg;
> +	drv_data->byte_posn =3D 0;
> +	drv_data->bytes_left =3D msg->len;
> +	drv_data->aborting =3D 0;
> +	drv_data->rc =3D 0;
> +	/* Only regular transactions can be offloaded */
> +	if ((msg->flags & ~(I2C_M_TEN | I2C_M_RD)) !=3D 0)
> +		return 1;

-EINVAL?

> +
> +	/* Only 1-8 byte transfers can be offloaded */
> +	if (msg->len < 1 || msg->len > 8)
> +		return 1;

ditto

> +
> +	/* Build transaction */
> +	ctrl_reg =3D MV64XXX_I2C_BRIDGE_CONTROL_ENABLE |
> +		   (msg->addr << MV64XXX_I2C_BRIDGE_CONTROL_ADDR_SHIFT);
> +
> +	if ((msg->flags & I2C_M_TEN) !=3D 0)
> +		ctrl_reg |=3D  MV64XXX_I2C_BRIDGE_CONTROL_ADDR_EXT;
> +
> +	if ((msg->flags & I2C_M_RD) =3D=3D 0) {
> +		for (i =3D 0; i < 4 && i < msg->len; i++)
> +			data_reg_lo =3D data_reg_lo |
> +					(msg->buf[i] << ((i & 0x3) * 8));
> +
> +		for (i =3D 4; i < 8 && i < msg->len; i++)
> +			data_reg_hi =3D data_reg_hi |
> +					(msg->buf[i] << ((i & 0x3) * 8));

What about:

	local_buf[8] =3D { 0 };

	memcpy(local_buf, msg->buf, msg->len);
	cpu_to_be32(...)

? A lot less lines and be32 macros are likely more efficient. Copy loop
probably, too.

> +
> +		ctrl_reg |=3D MV64XXX_I2C_BRIDGE_CONTROL_WR |
> +		    (msg->len - 1) << MV64XXX_I2C_BRIDGE_CONTROL_TX_SIZE_SHIFT;
> +	} else {
> +		ctrl_reg |=3D MV64XXX_I2C_BRIDGE_CONTROL_RD |
> +		    (msg->len - 1) << MV64XXX_I2C_BRIDGE_CONTROL_RX_SIZE_SHIFT;
> +	}
> +
> +	/* Execute transaction */
> +	writel_relaxed(data_reg_lo,
> +		drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_LO);
> +	writel_relaxed(data_reg_hi,
> +		drv_data->reg_base + MV64XXX_I2C_REG_TX_DATA_HI);

Do you need to write the 0 in case of I2C_M_RD?

> +	writel(ctrl_reg, drv_data->reg_base + MV64XXX_I2C_REG_BRIDGE_CONTROL);
> +
> +	return 0;
> +}
> +
> +static void
> +mv64xxx_i2c_update_offload_data(struct i2c_msg *msg, unsigned long data_=
reg_hi,
> +	unsigned long data_reg_lo)
> +{
> +	int i;
> +
> +	if ((msg->flags & I2C_M_RD) !=3D 0) {

!=3D 0 is superfluous

> +		for (i =3D 0; i < 4 && i < msg->len; i++) {
> +			msg->buf[i] =3D data_reg_lo & 0xFF;
> +			data_reg_lo >>=3D 8;
> +		}
> +
> +		for (i =3D 4; i < 8 && i < msg->len; i++) {
> +			msg->buf[i] =3D data_reg_hi & 0xFF;
> +			data_reg_hi >>=3D 8;
> +		}
> +	}

Same idea as above?

> @@ -298,21 +420,36 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, =
u32 status)
>  static void
>  mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_data)
>  {
> +	unsigned long data_reg_hi =3D 0;
> +	unsigned long data_reg_lo =3D 0;
> +
>  	switch(drv_data->action) {
> +	case MV64XXX_I2C_ACTION_OFFLOAD_RESTART:
> +		data_reg_lo =3D readl(drv_data->reg_base +
> +				MV64XXX_I2C_REG_RX_DATA_LO);
> +		data_reg_hi =3D readl(drv_data->reg_base +
> +				MV64XXX_I2C_REG_RX_DATA_HI);

Initializing data_reg_* is the same for both calls to
update_offload_data, so it could be moved into the function.
Probably not needed when using the local_buf idea.

> @@ -326,6 +463,12 @@ mv64xxx_i2c_do_action(struct mv64xxx_i2c_data *drv_d=
ata)
>  			drv_data->reg_base + drv_data->reg_offsets.control);
>  		break;
> =20
> +	case MV64XXX_I2C_ACTION_OFFLOAD_SEND_START:
> +		if (mv64xxx_i2c_offload_msg(drv_data) <=3D 0)

needs to be adjusted when using -EINVAL above. I'd prefer the error case
in the else branch, though. Easier to read.

> +			break;
> +		else
> +			drv_data->action =3D MV64XXX_I2C_ACTION_SEND_START;
> +		/* FALLTHRU */
>  	case MV64XXX_I2C_ACTION_SEND_START:
>  		writel(drv_data->cntl_bits | MV64XXX_I2C_REG_CONTROL_START,
>  			drv_data->reg_base + drv_data->reg_offsets.control);

> @@ -601,6 +779,13 @@ mv64xxx_of_config(struct mv64xxx_i2c_data *drv_data,
> =20
>  	memcpy(&drv_data->reg_offsets, device->data, sizeof(drv_data->reg_offse=
ts));
> =20
> +	/*
> +	 * For controllers embedded in new SoCs activate the
> +	 * Transaction Generator support.
> +	 */
> +	if (of_device_is_compatible(np, "marvell,mv78230-i2c"))
> +		drv_data->offload_enabled =3D true;

For now OK, if there are more users, someone will need to convert it to
be included in match_data.

> @@ -654,6 +839,7 @@ mv64xxx_i2c_probe(struct platform_device *pd)
>  		drv_data->freq_n =3D pdata->freq_n;
>  		drv_data->irq =3D platform_get_irq(pd, 0);
>  		drv_data->adapter.timeout =3D msecs_to_jiffies(pdata->timeout);
> +		drv_data->offload_enabled =3D 0;

'false' instead of 0.

Regards,

   Wolfram


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSFSqcAAoJEBQN5MwUoCm2RRsP+wUtqOnePytyCXqK5aEHUUf3
5lNGIe9luQf179y96qEZbAHSaHLhsT758qMEWHAfdzndE/fnLvyByEi6yN6yn+eD
Uj3rdZd0LfwSnyr0SICnXl5HBQrkxS3pCoP8DNvDC2ZG1zmtcYCJwXKRkzneW7sO
ekvS3G7wk6aR0YGOVBv/IGqA505jOq7ZbUglWwJRepIo8ZTvuqGYwT4jyRIMABq2
TfiF+YPyVZifBIBwjDSnZ4IkILHa10vjukd6uwNXBHaHT2FP6dcqHwuQ6/GI/xEt
RThTAlyRIfRb8nqVe8i/aWhzlZp1QroM5RDGAB3N3MN89g4ITZpML306u5SAPpXr
b8JYIAVILy0I4BxWDxv6fP9JH7jVetVkJlsXYqVZ5688ogJeN44+zVQPwvHm9f7W
2Cgn9jeuNDKolhVOVXBtuU5o5pWDVQmyM/cXtCFf7tR53T73CvWYaNyX/f57fYm3
erlK/r6VfdXXMZxhNCC6d+u4ESgNviQN1GPpUToAbieM0CUFeun4YDFAE5zvpV4x
GhHga0N9mj6ZICmHy9NXjtxkZgkEMQ1Sifz5ou8UejXR5oNN2T63yhxrChrkPlPW
fToWXgwzDrncURQsq70glsmEhpnCFaov9z8IcE22JbT099EyVb+lWahInuXSeU8P
VoTzzRVdDX4Pd9jaM54d
=fTGB
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
