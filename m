From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v6 2/4] i2c: add support for Diolan DLN-2 USB-I2C adapter
Date: Fri, 3 Oct 2014 03:14:33 +0200
Message-ID: <20141003011433.GG1323@katana>
References: <1411661254-5204-1-git-send-email-octavian.purdila@intel.com>
 <1411661254-5204-3-git-send-email-octavian.purdila@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411661254-5204-3-git-send-email-octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, daniel.baluta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index 2ac87fa..6afc17e 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -1021,4 +1021,14 @@ config SCx200_ACB
>  	  This support is also available as a module.  If so, the module
>  	  will be called scx200_acb.
> =20
> +config I2C_DLN2
> +       tristate "Diolan DLN-2 USB I2C adapter"
> +       depends on MFD_DLN2
> +       help
> +         If you say yes to this option, support will be included for Dio=
lan
> +         DLN2, a USB to I2C interface.
> +
> +         This driver can also be built as a module.  If so, the module
> +         will be called i2c-dln2.
> +

Please keep to the existing sorting.


>  endmenu
> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> index 49bf07e..3118fea 100644
> --- a/drivers/i2c/busses/Makefile
> +++ b/drivers/i2c/busses/Makefile
> @@ -100,5 +100,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+=3D i2c-elektor.o
>  obj-$(CONFIG_I2C_PCA_ISA)	+=3D i2c-pca-isa.o
>  obj-$(CONFIG_I2C_SIBYTE)	+=3D i2c-sibyte.o
>  obj-$(CONFIG_SCx200_ACB)	+=3D scx200_acb.o
> +obj-$(CONFIG_I2C_DLN2)		+=3D i2c-dln2.o

Ditto!

> +static int dln2_i2c_enable(struct dln2_i2c *dln2, bool enable)
> +{
> +	int ret;
> +	u16 cmd;
> +
> +	if (enable)
> +		cmd =3D DLN2_I2C_ENABLE;
> +	else
> +		cmd =3D DLN2_I2C_DISABLE;

Ternary operator?

> +
> +	ret =3D dln2_transfer(dln2->pdev, cmd, &dln2->port, sizeof(dln2->port),
> +			    NULL, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int dln2_i2c_set_frequency(struct dln2_i2c *dln2, u32 freq)

Here you have 'set_frequency'...

> +{
> +	int ret;
> +	struct tx_data {
> +		u8 port;
> +		__le32 freq;
> +	} __packed tx;
> +
> +	tx.port =3D dln2->port;
> +	tx.freq =3D cpu_to_le32(freq);
> +
> +	ret =3D dln2_transfer(dln2->pdev, DLN2_I2C_SET_FREQUENCY, &tx, sizeof(t=
x),
> +			    NULL, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	dln2->freq =3D freq;
> +
> +	return 0;
> +}
> +
> +static int dln2_i2c_get_freq(struct dln2_i2c *dln2, u16 cmd, u32 *res)

=2E.. here 'get_freq'. Please keep it consistent.

> +{
> +	int ret;
> +	__le32 freq;
> +	unsigned len =3D sizeof(freq);
> +
> +	ret =3D dln2_transfer(dln2->pdev, cmd, &dln2->port, sizeof(dln2->port),
> +			    &freq, &len);
> +	if (ret < 0)
> +		return ret;
> +	if (len < sizeof(freq))
> +		return -EPROTO;
> +
> +	*res =3D le32_to_cpu(freq);
> +
> +	return 0;
> +}

=2E..

> +
> +static int dln2_i2c_xfer(struct i2c_adapter *adapter,
> +			 struct i2c_msg *msgs, int num)
> +{
> +	struct dln2_i2c *dln2 =3D i2c_get_adapdata(adapter);
> +	struct i2c_msg *pmsg;
> +	int i;
> +
> +	for (i =3D 0; i < num; i++) {
> +		int ret;
> +
> +		pmsg =3D &msgs[i];
> +
> +		if (pmsg->len > DLN2_I2C_MAX_XFER_SIZE)
> +			return -EINVAL;

Rather -EOPNOTSUPP. And we should add a warning here since I2C transfers
can be bigger than 256 byte and this is a flaw of the controller.

> +
> +		if (pmsg->flags & I2C_M_RD) {
> +			ret =3D dln2_i2c_read(dln2, pmsg->addr, pmsg->buf,
> +					    pmsg->len);
> +			if (ret < 0)
> +				return ret;
> +
> +			pmsg->len =3D ret;
> +		} else {
> +			ret =3D dln2_i2c_write(dln2, pmsg->addr, pmsg->buf,
> +					     pmsg->len);
> +			if (ret !=3D pmsg->len)
> +				return -EPROTO;
> +		}
> +	}
> +
> +	return num;
> +}
> +

Thanks,

   Wolfram


--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJULfh5AAoJEBQN5MwUoCm2Ah8P/jHpoFcVcNhOy0Zy+X2Ac2VZ
iiqUlONBMv5VkyYe8b/ZkMptMAYLk8vD6NiBOOX6Jhci23yTxHMdMs1MLKj8zzL8
iKPadcftjf3XxyoJrTEqHH11cPnJT9iEKq3efEtz3NCsRW+3XFyTV2AHVeLfNRov
m6FHCRnl0S4Ckp3jGOFxPdMSgKDJfmGWXOLIfD3j5q/mN6AYyuhR4LBLgpgLiqbE
ECaQ6BmF1XPHgTsvplWvDCqsSSuc+uxgOIyo9ErnvEC7xvPzGTPUzHTwLKGGBOGW
toPxw6rEGeMDn0zPWcsj1SPsnmvPVCnUytbMLJC2gqkEiVKdZTkFZRNvmt88tJCD
hPgRjtsbU133K5DQ5hwx585gsq8xHBB5wSfF5NimYCFgrC0Hut6MFgTAKtfE7OX8
Syz8ndvSkla23gdf9KXA3gHeJigjO+rrxRWu4yNC+8sg35rIQWre67fVpRQ6h7aK
tYDKnR9DN2HStmDJXPlS0ecmFQdtY5M5jxDhUc8utZ5LQQlsiIWcWQXBD7Gs4l2O
ZPxf9dB1jK5eJzq532X8QwdJ3Sk2xcs0FJESAbNnPU5/XwRF2g+6THmJ8FIauFqU
+nnl4Elbgrgfzw/pZY1WGNNyIyuGQacHc7w2/7wuQDr7OtJkSqx94/4FEzEq0Qpf
J6D26KYQrUMxVkqgca1E
=WR2B
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
