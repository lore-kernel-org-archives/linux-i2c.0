From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 07/13] i2c: pnx: Use devm_*() functions
Date: Sat, 4 Jan 2014 22:07:55 +0100
Message-ID: <20140104210755.GB3150@katana>
References: <001601cefaf3$940d0040$bc2700c0$%han@samsung.com>
 <002b01cefaf4$fa737d40$ef5a77c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="St7VIuEGZ6dlpu13"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <002b01cefaf4$fa737d40$ef5a77c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Vitaly Wool' <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Roland Stigge' <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> @@ -674,29 +670,27 @@ static int i2c_pnx_probe(struct platform_device *pd=
ev)
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!res) {
>  		dev_err(&pdev->dev, "Unable to get mem resource.\n");
> -		ret =3D -EBUSY;
> -		goto out_clkget;
> +		return -EBUSY;
>  	}
> -	if (!request_mem_region(res->start, I2C_PNX_REGION_SIZE,
> -				pdev->name)) {
> +	if (!devm_request_mem_region(&pdev->dev, res->start,
> +				     I2C_PNX_REGION_SIZE, pdev->name)) {
>  		dev_err(&pdev->dev,
>  		       "I/O region 0x%08x for I2C already in use.\n",
>  		       res->start);
> -		ret =3D -ENOMEM;
> -		goto out_clkget;
> +		return -ENOMEM;
>  	}
> =20
>  	alg_data->base =3D res->start;
> -	alg_data->ioaddr =3D ioremap(res->start, I2C_PNX_REGION_SIZE);
> +	alg_data->ioaddr =3D devm_ioremap(&pdev->dev, res->start,
> +					I2C_PNX_REGION_SIZE);

Why not converting it to devm_ioremap_resource?


--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSyHgrAAoJEBQN5MwUoCm2zEoP/3AfYyhqdlixY1LhVtP4elZA
mp4H3H30X35RdBPMdLF1EQdq3BcALqI4fQ+OCyLxJiBzxma+LDbyZhh1wyR2Z+i9
+kLTGgnu3uaa10GCJUZaaAMEp0kFEyA2vj00Y2p3xuLymVOdcsd5O5Jj287JOcNW
26Si5AR1kmIuSrWO9GekjDAEgZN5bwiB/M63Fbp5WvoEYfksZCIgcwBKGEwHzMHs
yFPu1+9TNo0m5Vh8HT3qnuJM10qiCiaIqxd2vI+RXj7UA+M3A3MLdJayQBczcyTZ
pp6EvJQLDpb3Hv/ZpqXv0ICiFEw+Y0bWufD5rTg1tkSYv6yReZuL8iRxdnpIByHU
csaz4oRpXkZq/urVlCPvj7ma4VkBnSYuX1n7oht6/wmJyS+I0EQ4SevZc75HjoQh
TyaMynp3d1w/LCsd1MbGmBSl0FPQBv3/ynM3sgZiMaxIc25nVAHD+tjPxp3Kzjpc
ZHyY8wPU1YhzyKqHFQ1hQFzTybYEA6M728kfw03oSt08B3HDhyeffTMgfGWyOjX5
0ash+gpE06kd7VxmN0dDbbG1CgI3z8Ada7iC8JP3s4txSaZrRb+Hoklbb5mfov+g
lCfsDm5Oc36Apwxatr+fAFp23oH1jSqeeX0JQZj/7SZhvoGihIjvt1IbXnUc7xYL
6m3emMNA1j6Vq512Pko8
=J+N2
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
