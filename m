From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v7 3/3] i2c: zx2967: add i2c controller driver for ZTE's
  zx2967 family
Date: Tue, 21 Feb 2017 23:23:25 +0100
Message-ID: <20170221222325.7w2h3w2qp2n2gzte@ninjato>
References: <1487224844-10973-1-git-send-email-baoyou.xie@linaro.org>
 <1487224844-10973-3-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bkivfo2o4oz4y7st"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1487224844-10973-3-git-send-email-baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Baoyou Xie <baoyou.xie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xie.baoyou-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, chen.chaokai-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org, wang.qiang01-Th6q7B73Y6EnDS1+zs4M5A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--bkivfo2o4oz4y7st
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> +static int
> +zx2967_i2c_xfer_read_bytes(struct zx2967_i2c_info *zx_i2c, u32 bytes)
> +{
> +	unsigned long time_left;
> +
> +	reinit_completion(&zx_i2c->complete);
> +	zx2967_i2c_writel(zx_i2c, bytes - 1, REG_RDCONF);
> +	zx2967_i2c_start_ctrl(zx_i2c);
> +
> +	time_left = wait_for_completion_timeout(&zx_i2c->complete,
> +				I2C_TIMEOUT);
> +	if (time_left == 0) {
> +		dev_err(DEV(zx_i2c), "read i2c transfer timed out\n");
> +		disable_irq(zx_i2c->irq);
> +		zx2967_i2c_reset_hardware(zx_i2c);
> +		return -EIO;
> +	}
> +
> +	return zx2967_i2c_empty_rx_fifo(zx_i2c, bytes);
> +}

Timeouts do happen on an I2C bus (e.g. when an EEPROM is in an erase
cycle). Or try 'i2cdetect -r'. At least, the dev_err should go. But I
also wonder if you really need to reset the hardware?

> +static int zx2967_i2c_xfer_read(struct zx2967_i2c_info *zx_i2c)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < zx_i2c->access_cnt; i++) {
> +		ret = zx2967_i2c_xfer_read_bytes(zx_i2c, I2C_FIFO_MAX);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (zx_i2c->residue > 0) {
> +		ret = zx2967_i2c_xfer_read_bytes(zx_i2c, zx_i2c->residue);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	zx_i2c->residue = 0;
> +	zx_i2c->access_cnt = 0;
> +	return 0;
> +}
> +

This function...

> +static int zx2967_i2c_xfer_write(struct zx2967_i2c_info *zx_i2c)
> +{
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < zx_i2c->access_cnt; i++) {
> +		ret = zx2967_i2c_xfer_write_bytes(zx_i2c, I2C_FIFO_MAX);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (zx_i2c->residue > 0) {
> +		ret = zx2967_i2c_xfer_write_bytes(zx_i2c, zx_i2c->residue);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	zx_i2c->residue = 0;
> +	zx_i2c->access_cnt = 0;
> +	return 0;
> +}

... and this are one example where the read- and write-counterparts are
very similar. I wonder if we would do better having just one function
and handle the difference with some if(). Example here: If you'd unify
zx2967_i2c_xfer_write_bytes() and zx2967_i2c_xfer_read_bytes() into one
generic function then zx2967_i2c_xfer_write() and zx2967_i2c_xfer_read
automatically become identical AFAICS. Thoughts?

   Wolfram


--bkivfo2o4oz4y7st
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlisvc4ACgkQFA3kzBSg
KbbHdhAAnpPCuthPsVJ7cpwOwEtd7DwEjDakAl7aHUAGnnNpfugvvYjHQqtX1cyI
U2jURiwoexmBTS/Ka+9c8GjYjz2KKCY+3U7Lhs5FWrAHlvYlxrqHo7KZQqT74U4F
Vfr0tb3n9QNJUVdiYQuznnDPZmkuljz+FMEhthQTqOlpBXgQpZ7fYinFNo4+Duy5
jbUscAfzwblvRh1rzNkddQaM+zulziE96N6zJoatyaWPRp7G7tL5IKqb3S761eP1
AIqGHe6Zax40YHEOWhs1k/YpMoeQyBVi/1i0AQIJsq5+OXHqq0h21d3tZDHW/ezA
FIwjMbIK3befCOHZowUE2bZthK/KaLdj3aigPZDKYf1FZBUPhMKI7+cTYkaE4vFp
6U3RBCfIs7mUxXNhA7kD80dmEsVA6PYkfAY1Tej5Jib9cA7891Zlj0GA1Exp6UTL
pDnC1ruA3ZtbTAAlTa5W2HLqjmab+YzCDQnxU01TbdbMcwwUgC85SoEzGI873LTE
UHykEi9F1p5TA725369/LeGYCISVQm6htynH5Cvtc0EdLnj1YgGX3kQPueh+9Jvq
KmTSOt1PdlIUSzndR0YUKvDQRov3ZUrWTXm9LDKlAQRBmLPQrnI4nvWHZ958dQ05
K4GNCKfyGtsnullvCZoa1wmpiLtPbrJTiL7kzYJYp9wQjeM9cJI=
=xd+b
-----END PGP SIGNATURE-----

--bkivfo2o4oz4y7st--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
