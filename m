From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH RFC v3 2/3] i2c: pxa: convert to devm_* API
Date: Wed, 12 Jun 2013 12:02:33 +0200
Message-ID: <20130612100232.GB3008@katana>
References: <1369310408-10348-1-git-send-email-libo.chen@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1369310408-10348-1-git-send-email-libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: guz.fnst-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org, sonic.zhang-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2013 at 08:00:08PM +0800, Libo Chen wrote:
> when i2c malloc faild, we should not try to call release_mem_region.
> aovid this, convert them to devm_* API.
>=20
> Signed-off-by: Libo Chen <libo.chen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

First, you did it right. This patch should not be combined with 1/3. It
is not a trivial cleanup, so I prefer to keep them seperated.

BTW did you test these patches on real hardware?

> @@ -1198,19 +1187,6 @@ static int i2c_pxa_probe(struct platform_device *d=
ev)
>  #endif
>  	return 0;
> =20
> -eadapt:
> -	if (!i2c->use_pio)
> -		free_irq(irq, i2c);
> -ereqirq:
> -	clk_disable(i2c->clk);
> -	iounmap(i2c->reg_base);
> -eremap:
> -	clk_put(i2c->clk);
> -eclk:
> -	kfree(i2c);
> -emalloc:
> -	release_mem_region(res->start, resource_size(res));
> -	return ret;
>  }
> =20
>  static int i2c_pxa_remove(struct platform_device *dev)
> @@ -1218,15 +1194,6 @@ static int i2c_pxa_remove(struct platform_device *=
dev)
>  	struct pxa_i2c *i2c =3D platform_get_drvdata(dev);
> =20
>  	i2c_del_adapter(&i2c->adap);
> -	if (!i2c->use_pio)
> -		free_irq(i2c->irq, i2c);
> -
> -	clk_disable(i2c->clk);
> -	clk_put(i2c->clk);
> -
> -	iounmap(i2c->reg_base);
> -	release_mem_region(i2c->iobase, i2c->iosize);
> -	kfree(i2c);

You remove too much. Who disables the clock now?


--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuEc4AAoJEBQN5MwUoCm2mGkP/iItUVeJjl4zftnUr9O5u0Jk
6f0d5H41XJKgpJJYhdHiaYMCVL2rgvBtzkG4jARI+5tJS3m+mY+j2aTWvCbVM720
hoSq4tNNWJnwpCNy9M6Pk6CZYOuXvRr3B0amWqyqeLHeYTejNihhSr5EDUAzRgpm
E0II/9+wsHkWWG5enopNPOERiTEwtntgMxNgtIiFZDGQg7Lj+d2oxHCU2xKTsz6Q
q0x8quIUshDscpZKfU8pjv+5iElNjgWcHUFAyTBXClE5VPKDIqjfyGztjiaGaYMI
oSCxVjsxAiRUAExC2GZaipUtrF20iEJl0avMKiCIGVcWcwtTb4FEFCiNy6OO9ORn
uRDS7cvKWAXmseOU/cQKvjXAzuv9PIFHYq+ltjp8nHPuFfGpywy3QKxp4ojaO9Di
0yRunCX4TzFB1+OuErInXzcs9yWYbs84gg3qCmEKGw/NUSnUEgECZyAbrFymnwc1
aUNIOHIASNlZYLR9nBWbPCAOOu0inOlbJJe6KuXNV0XkLq4r81yx3FskIdmOqIgW
GedIXhTNQA9F6INouK4trgW6iuWMyCOw+n0R6W+tF6pQJJag6kq+3RQfc/qF7HHZ
9c+XWkn7OmyBf4YlZtZrZJXfoHImUyCcADLpfdhcDECglfMJc6fCkDAxZ/i6jjic
Cz75FWT5b5ZJmBqIbfFT
=LaEb
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
