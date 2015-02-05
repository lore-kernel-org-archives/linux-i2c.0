From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: i2c-ocores: add common clock support
Date: Thu, 5 Feb 2015 20:15:11 +0100
Message-ID: <20150205191510.GB15307@katana>
References: <1422890893-30989-1-git-send-email-jcmvbkbc@gmail.com>
 <1422890893-30989-3-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422890893-30989-3-git-send-email-jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> -	if (of_property_read_u32(np, "opencores,ip-clock-frequency", &val)) {
> +#ifdef CONFIG_HAVE_CLK
> +	i2c->clk = devm_clk_get(&pdev->dev, NULL);
> +
> +	if (!IS_ERR(i2c->clk)) {
> +		int ret = clk_prepare_enable(i2c->clk);
> +
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"clk_prepare_enable failed: %d\n", ret);
> +			return ret;
> +		}
> +		i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
> +		if (clock_frequency_present)
> +			i2c->bus_clock_khz = clock_frequency / 1000;
> +	} else
> +#endif
> +		if (of_property_read_u32(np, "opencores,ip-clock-frequency",
> +					 &val)) {

This is not very readable (wrong indentation) and fragile. I'd suggest
to leave out #ifdeffery, the compiler will remove the code for !HAVE_CLK
because of the empty dummy functions[1]. Then, you can write properly
formatted code again.

[1] Well, it should if there wasn't a bug in that: https://lkml.org/lkml/2015/2/5/544

> +#ifdef CONFIG_HAVE_CLK
> +	if (!IS_ERR(i2c->clk)) {
> +		int ret = clk_prepare_enable(i2c->clk);
> +
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"clk_prepare_enable failed: %d\n", ret);
> +			return ret;
> +		}
> +		i2c->ip_clock_khz = clk_get_rate(i2c->clk) / 1000;
> +	}
> +#endif

Ahem, there is a build error in here :(


--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU08E+AAoJEBQN5MwUoCm2yKoP/2y8QmU9K2y24Bbz7OC6Q7ps
x5s8wB0MJconrpmmwvE7fyliGuXIOozqyVan7wXJ00qnGkLltVqBqj7PiNDA3rqH
dE/uSV/qLWO8olszRKcYqg+qLw6H6ZUA8ZQ+aLmcbPaQvFV6F2U4m81tXjNBDn//
30Is6pPkm/65+wLC5VKbdxF5o2wXy3ROz8MUXYKLH7kq8wivqmTpbsu8e7JRl6xZ
unk2fUIn8PGT553HxcQbXvIYFmL0oaqPOPqJ2X4wNvBqDMMfmtHIHuR/ZiwaY8/r
8XHfJOMivDZ0WekEtj7WnBvDA0dOqkLxQm4Czm6Sc0+Jq/f0lgqk0uniu7bJCM+v
mOmGdF3R/hT+4OZAJRl+WHsIvvd4vHW77pjbumbnP6UPk05oXoJBO4zD2JSIUmQH
QMBgwozRWsdK9+Tt737NIfg6nkXIdAad2SYbd50ySfgH6cmnAAIs0fHhv9XTNGXU
faFNZBhLMFdrj8Eg/Rp+lGuwu93nxmqMflCIZyz9rJRWMkq7sgZJ33h2bBn8XTBm
TyaLnNYt42D3V8WKv6Zkkw6yWNO9dSimoV+60mUUEFVjg2CDjP2XBFJL5CHE1DSw
TRZIUJenqixAlPIFoncv54v2pwAB6t/iyhFiAyKhrNBIGAauAH7zV8mcPTQrHeGO
fwM+FOs228cg//+kAny6
=Iwrq
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
