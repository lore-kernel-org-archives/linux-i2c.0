From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH-v3 06/11] i2c:pxa: Use devm_ variants in probe function
Date: Fri, 10 Jul 2015 10:18:01 +0200
Message-ID: <20150710081801.GD1528@katana>
References: <1436210695-19159-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436210695-19159-7-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436210695-19159-7-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robert.jarzmik-GANU6spQydw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> -	i2c = kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
> +	i2c = devm_kzalloc(&dev->dev, sizeof(struct pxa_i2c), GFP_KERNEL);
>  	if (!i2c) {
> -		ret = -ENOMEM;
> -		goto emalloc;
> +		dev_err(&dev->dev, "memory allocation failed\n");

No message here, we get a dump anyhow.

> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(&dev->dev, "no mem resource\n");
> +		return -ENODEV;
> +	}

You can skip this check, devm_ioremap_resource will do it.

> +		dev_err(&dev->dev, "failed to get the clk: %ld\n",
> +			PTR_ERR(i2c->clk));

Sidenote for all patches: I am not so strict with the 80 char limit. I'd
think the above code would be more readable if it was one line. But you
decide.


--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVn3+4AAoJEBQN5MwUoCm2tQ8P/07DUHwKmvZx1aHS/8po+ORV
fHhTbqIfupQj2N3LZvq8HyPs2hODWT1RpTT1ZaX/0+UntNzaGoJPfdDXVlpLU+43
8IFGJJpWTBj1DfPJdOUAeHoehQis9vK3D6Df6Ld2tylElT0dy+/sdiIdPYRtld3s
sZji8bKu8C1XqM8yMeLJLnANlGnS7Cf+GXDzy7JR+H5XO579C5z8FQJoI6zk/rsi
sgjvwmtk2G9agdGvv3OzkGGdJGEBLcXowIbHe281CQCpkNqqVaOREz3bJLh11780
iZ9mRqXW4L8URC5Aiy+1J2oSO3uUxnLRbd1N559Ep8wP8xuX2ZR3ewiEvjA7qY5x
M9TGIUXSspggtZZCcsdpX7qLAHVT4vJOh4bshzDd4gTRz15g3ZVDwUWKvabnZE+m
UUJ8vmILQMTsVOynd6Upgs5GUYQXXhXb/vUOoUA/VnsTreAo5PKgRM+kB3nx0iTm
edGf0mKKFYZMMl1WkdD1wjSQc8zdAWCHN+d3VeR4HCgdEDEa1/HM3mYwZxkMuQS3
1QhtXU4F7OSxVv3qEYPzpb0FDWBDI/Qy4o9gJUYpVUnQxrRUnzXl1pncLTduztGj
0/ko9XkffwGTv4E70ytj2m3yMG9+k1EfWukpmmuyPlPuMT5z7vpIjgmZ731L/V8D
YPkKBa4gLC+Tu7qnweWM
=61G0
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
