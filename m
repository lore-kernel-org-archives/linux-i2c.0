From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2] i2c:at91: Add device tree property to set
 clock-frequency
Date: Mon, 10 Mar 2014 17:29:55 +0100
Message-ID: <20140310162955.GF11592@katana>
References: <1393293045-31849-1-git-send-email-mark.roszko@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393293045-31849-1-git-send-email-mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Roszko <mark.roszko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> @@ -711,6 +711,7 @@ static int at91_twi_probe(struct platform_device *pde=
v)
>  	struct resource *mem;
>  	int rc;
>  	u32 phy_addr;
> +	int bus_clk_rate;
> =20
>  	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
> @@ -756,7 +757,12 @@ static int at91_twi_probe(struct platform_device *pd=
ev)
>  			dev->use_dma =3D true;
>  	}
> =20
> -	at91_calc_twi_clock(dev, TWI_CLK_HZ);
> +	rc =3D of_property_read_u32(dev->dev->of_node, "clock-frequency",
> +			&bus_clk_rate);

The function is named read_u32, so the variable used should be u32.


--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTHeiDAAoJEBQN5MwUoCm2hmEP/0Tq8Neh7Q5F+bMFkpyYxnFb
s3GfL67JjqWc9OXTzQ6s8NMmfFQ3qtyu736GfZQBj5zB+xMnyerdtNyjsBBmEHBz
xp+Cj/o4TAhGB9Q7iJf76GBGLq8t8sLGhqE8R9r9nSNqwv0eQS9jbgNdSA5ULEgy
tJH13MSxj3gczfwZVg4QuTyUuBB7sFj9+IYaJzkQ0NrPWByuJDmTJYKsC9dm87gG
5hRnuz+3jqUuHTB556C+sxBfVzX1kzGkD6XKfHXmHgOGRSaAe8PXaG6zg5+4MLEh
T0RV89m+H5tK/UOymqWaTSv86xgwjRRGi58IJvGusvdkujcorbRmnG3M2LXD3tSy
6/LfkeN0kQO36p/RmRV+uDOWNv9DwnVsSV+/FUjaNPfUbIoXcfKhVyjATSZKIQMC
KOvaQ9m6H6nw5cyzmejnhxJQ6uN0yclzxO+0JcNLdERVtn0CbFVazodxObuYfREm
wYKW/04SFijXPlj+KgGXQrufl+FbjnIqH3TXRq00Ht1ipKj+zjNBHiQQTZr7kXsW
1ugHyHUuL/6WuyhzNrlNSYvOgeAgER4NiPl8ea44BRq3vTn+WjW5zYWQ4/FRABLA
Bc4pjq456SIuxBjFNjnP4QG9NnYM+4rZUmaiVy2Ei+cWesMDKAbYSqzFU/ACami4
APm2aXrjjJBYhroWWj2w
=2q/V
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
