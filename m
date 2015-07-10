From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v3 07/11] i2c: pxa: enable/disable i2c module across msg
 xfer
Date: Fri, 10 Jul 2015 10:24:19 +0200
Message-ID: <20150710082419.GE1528@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-8-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436210695-19159-8-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2015 at 12:54:51AM +0530, Vaibhav Hiremath wrote:
> From: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>=20
> Enable i2c module/unit before transmission and disable when it finishes.
>=20
> why?
> It's because the i2c bus may be distrubed if the slave device,
> typically a touch, powers on.
>=20
> As we do not want to break slave mode support, this patch introduces
> DT property to control disable of the I2C module after xfer in master mode
> of operation.
>=20
> i2c-disable-after-xfer : If set, driver will disable I2C module after msg=
 xfer

Hmm, I am not sure this property fits into the "describing hardware"
category. And we can't make the below behaviour default, because the
udelay(100) will cause quite some latency.

>=20
> Signed-off-by: Yi Zhang <yizhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-pxa.c | 43 ++++++++++++++++++++++++++++++++++++++=
+++--
>  1 file changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 2de9300..dfd1dd0 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -161,6 +161,7 @@ struct pxa_i2c {
>  	unsigned char		master_code;
>  	unsigned long		rate;
>  	bool			highmode_enter;
> +	bool			disable_after_xfer;
>  };
> =20
>  #define _IBMR(i2c)	((i2c)->reg_ibmr)
> @@ -284,6 +285,24 @@ static void i2c_pxa_scream_blue_murder(struct pxa_i2=
c *i2c, const char *why)
>  static void i2c_pxa_master_complete(struct pxa_i2c *i2c, int ret);
>  static irqreturn_t i2c_pxa_handler(int this_irq, void *dev_id);
> =20
> +/* enable/disable i2c unit */
> +static inline int i2c_pxa_is_enabled(struct pxa_i2c *i2c)
> +{
> +	return (readl(_ICR(i2c)) & ICR_IUE);
> +}
> +
> +static inline void i2c_pxa_enable(struct pxa_i2c *i2c, bool enable)
> +{
> +	if (enable) {
> +		if (!i2c_pxa_is_enabled(i2c)) {
> +			writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
> +			udelay(100);
> +		}
> +	} else {
> +		writel(readl(_ICR(i2c)) & ~ICR_IUE, _ICR(i2c));
> +	}
> +}
> +
>  static inline int i2c_pxa_is_slavemode(struct pxa_i2c *i2c)
>  {
>  	return !(readl(_ICR(i2c)) & ICR_SCLE);
> @@ -480,8 +499,7 @@ static void i2c_pxa_reset(struct pxa_i2c *i2c)
>  	i2c_pxa_set_slave(i2c, 0);
> =20
>  	/* enable unit */
> -	writel(readl(_ICR(i2c)) | ICR_IUE, _ICR(i2c));
> -	udelay(100);
> +	i2c_pxa_enable(i2c, true);
>  }
> =20
> =20
> @@ -832,6 +850,9 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
>  	struct pxa_i2c *i2c =3D adap->algo_data;
>  	int ret, i;
> =20
> +	/* Enable i2c unit */
> +	i2c_pxa_enable(i2c, true);
> +
>  	/* If the I2C controller is disabled we need to reset it
>  	  (probably due to a suspend/resume destroying state). We do
>  	  this here as we can then avoid worrying about resuming the
> @@ -852,6 +873,11 @@ static int i2c_pxa_pio_xfer(struct i2c_adapter *adap,
>  	ret =3D -EREMOTEIO;
>   out:
>  	i2c_pxa_set_slave(i2c, ret);
> +
> +	/* disable i2c unit */
> +	if (i2c->disable_after_xfer)
> +		i2c_pxa_enable(i2c, false);
> +
>  	return ret;
>  }
> =20
> @@ -1067,6 +1093,9 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, s=
truct i2c_msg msgs[], int num
>  	struct pxa_i2c *i2c =3D adap->algo_data;
>  	int ret, i;
> =20
> +	/* Enable i2c unit */
> +	i2c_pxa_enable(i2c, true);
> +
>  	for (i =3D adap->retries; i >=3D 0; i--) {
>  		ret =3D i2c_pxa_do_xfer(i2c, msgs, num);
>  		if (ret !=3D I2C_RETRY)
> @@ -1080,6 +1109,10 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap, =
struct i2c_msg msgs[], int num
>  	ret =3D -EREMOTEIO;
>   out:
>  	i2c_pxa_set_slave(i2c, ret);
> +	/* disable i2c unit */
> +	if (i2c->disable_after_xfer)
> +		i2c_pxa_enable(i2c, false);
> +
>  	return ret;
>  }
> =20
> @@ -1120,6 +1153,9 @@ static int i2c_pxa_probe_dt(struct platform_device =
*pdev, struct pxa_i2c *i2c,
>  	/* For device tree we always use the dynamic or alias-assigned ID */
>  	i2c->adap.nr =3D -1;
> =20
> +	i2c->disable_after_xfer =3D of_property_read_bool(np,
> +				"i2c-disable-after-xfer");
> +
>  	if (of_get_property(np, "mrvl,i2c-polling", NULL))
>  		i2c->use_pio =3D 1;
>  	if (of_get_property(np, "mrvl,i2c-fast-mode", NULL))
> @@ -1271,6 +1307,9 @@ static int i2c_pxa_probe(struct platform_device *de=
v)
> =20
>  	platform_set_drvdata(dev, i2c);
> =20
> +	if (i2c->disable_after_xfer)
> +		i2c_pxa_enable(i2c, false);
> +
>  #ifdef CONFIG_I2C_PXA_SLAVE
>  	dev_info(&i2c->adap.dev, " PXA I2C adapter, slave address %d\n",
>  		i2c->slave_addr);
> --=20
> 1.9.1
>=20

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn4EzAAoJEBQN5MwUoCm2YocP/inURzAhi3x2vTnJQeFAhuSm
Q7OBfGBYe80lSDpz0U765DCaSHKvdq5qD7ixRVghT4SQ8ZOV+ahw4KAE1HAHpZ1V
k4ebsyZm4Q/rlkfGEKQ3ulUelcoqGFTcHwXV5q5fIxiJoc369TWMGDV10rcx90Ya
mQGKxbmnSz0Bvn3bXkLR7waDn9597m9OMaAM+lfc35ny8vZdNX4zJSSZIQ9CmZ96
scCOnAkZIoBRmtJU3rDAH33RX/af8z5caoK3pxJXJcy+BDBsf6FZaKzdXVMwtwAs
VSQX33IUx0qOivtF5ApCSU7xbbTyZngz5vobgecvNf+ikn/4X4qx0FE9DMfmpKd6
sED2RTK2tq7Iu969tCpFX7cIVLAMqZiTYkhTnVyTF8G0xvNkp+e9Xi/tWZN05uCz
x2HesmEVCBfTdar067NWahY4Mww8XQXjZC84WTXM+uw0mXi8ZMeyKLMQ+g/NNuX4
qTGb6TdsHrbURqEN2fiGelWq22An3EUY+/a2nFkhkuHawtSijXq9JHb8qiXpqNea
IA7CJSY9ECFLKNg87ZXM0kwb0jxrLmBLZGDoBYgxzbsOoy11fHAEYL2vYxpUMtGE
W4D0XeJI4e3pmycklLLHaB0GJ8b1uv1hRffOe7I1iPasz0Yw9SaTi+h3/vJoD9Xb
Bs7I9t4TzKKmHJuDtIOT
=Dr8n
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
