From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/3] of/irq: Export of_irq_get()
Date: Thu, 30 Oct 2014 15:16:44 +0100
Message-ID: <20141030141644.GE23852@katana>
References: <1414677578-27412-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414677578-27412-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414677578-27412-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-i2c@vger.kernel.org


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 03:59:36PM +0200, Laurent Pinchart wrote:
> The function will be used by the I2C core which can be compiled as a
> module.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>

I think it makes sense if I take this via I2C to get the dependencies
for the later patches right?

> ---
>  drivers/of/irq.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index 1471e0a223a5..0d7765807f49 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -405,6 +405,7 @@ int of_irq_get(struct device_node *dev, int index)
> =20
>  	return irq_create_of_mapping(&oirq);
>  }
> +EXPORT_SYMBOL_GPL(of_irq_get);
> =20
>  /**
>   * of_irq_get_byname - Decode a node's IRQ and return it as a Linux irq =
number
> --=20
> 2.0.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUkhLAAoJEBQN5MwUoCm27xkQAJ5PCMzIvfPJDRZ7whtkxvNR
U+TadKW5+Z5FIp8BtqP2mCJI5Sl5S5LFr2zuZHzLA3WbZfYLMi7rs7pn+Y+VWl7N
MNrmMZeUttd3Ub+wkC26hzCWWPp0P3rAhQuFyv89OiTtZZypZJ05Xr9oxP6+mB1a
yVxtNtWarvP0aASQ7+k3hWnUN62hgTfp8p03mH0VvxqmadB8ZD4qgo0Xp5Zeyr/b
zawhYpH6xB9CbVL8jJe7ZTYdm+7QNbuEjv/k3pmFONdG97yJvaX2RQo/jz0iXSnb
m8sbIQ/09//IjmSOGocH+FBEJdRGtd8ov+x0+HzLA0tqHEG3VFfjrsO4W9HDieb6
PYNbR0IffBPQa2RIEfYux7l3qNKvssphGqPX+3YPDvZy1BpQHLYm+so1KCv5xeKU
9oRGi/8o1/JI9tR99D4yxJ7/IYQcRiisSRJaOCvriUvpH0A1QVhkaIjJaUMTrUwU
0siES/KTkbF9NmdrXkNPZPxeG44j1C/mqcSHVmyIUw2dhj2szr5sS5/kPIFYYu1E
zWvujXzpL8cHyBhilWULbGbSqnhudboYdAjnKzWdG5JJsPlD1pHnXI9JoA6upyFG
tyPECmIFnICyjtsZkGEajgQGarZMOJQinlZVw8jCmfjZ1F1KpzuV47dNWSjigt2F
DS1KS6tNVUNTDZWit7xL
=xnR+
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
