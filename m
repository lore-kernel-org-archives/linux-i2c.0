From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 6/8] i2c: mux: inform the i2c mux core about how it is
 used
Date: Thu, 25 Aug 2016 18:19:01 +0200
Message-ID: <20160825161900.GD2856@katana>
References: <1471268431-5148-1-git-send-email-peda@axentia.se>
 <1471268431-5148-7-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1471268431-5148-7-git-send-email-peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> diff --git a/drivers/i2c/muxes/i2c-mux-pca9541.c b/drivers/i2c/muxes/i2c-mux-pca9541.c
> index 3cb8af635db5..f052c3067791 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca9541.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca9541.c
> @@ -349,7 +349,8 @@ static int pca9541_probe(struct i2c_client *client,
>  	force = 0;
>  	if (pdata)
>  		force = pdata->modes[0].adap_id;
> -	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data), 0,
> +	muxc = i2c_mux_alloc(adap, &client->dev, 1, sizeof(*data),
> +			     I2C_MUX_ARBITRATOR,

Does it make sense to rename the file to i2c-arb-* somewhen then? Just
asking, I'll apply the patch anyhow.


--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvxp0AAoJEBQN5MwUoCm2T6wP+gKqGD73U3CEn0nIaKK2/2TS
KJG1P7cJo0AlBzVE1zMRU5EWVnoLJSsb9Qo6WoM7OfPFiQ86clo76TZoBd9aqmnM
EbQ8T9Sdz6ENpegp6gRLRpdgV9ANZkfnE+w+2kUFTWAfULjXssiBAKzMWJSqDd94
S7Msovg3cDL4ZBb8B+2X+0X92Vgi0OTlWaa5sFgC21ApCqWH/nxtY+M62S2pgNQW
n9NUjtAlK6lm+4NqijrFTfiHqBPS8mlM9TC/gt/f8w5+IPp8NkRWkSS6ec4lm45Z
zo5ZcOty7sqU0xPtqt2Vlyc3V/2yS7bUcoqKQzlu+LT7QAVfpVQk0jjW90SyGmyT
1vFDghOUX4YqDgzrbfrvfMvcWoAfkb+yOYlmb/aMGRi5OKjI2dhvXF5uA22tGEM5
lxdB8RGxQV5Dw+VHL4EtJOPv43ThEWdd236ZNLWygitjo9INmLfofUn2vWDjg7sn
r86T+aN1WOIB5gXW52jVb7avd5aouz3bfeZ7uFbYvRXcVTmudRzqWKyqmeOZIpiR
WRgT9GTPATIfu9HxY0F1WWFo+8Bi3VWM1HrBN3ajsSOUeTmz9qhGt3F7UZ1A/L2i
ZyBwsoEp8vufCgwAvt0DdVexNRx5+MFPjJ216OovykF+AhcmebkDdD777bR/oLiw
xO4g0BpWVvWDAQzbn7I7
=o7Nj
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
