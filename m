From: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] Use resource_size macro
Date: Wed, 6 May 2009 23:35:23 +0200
Message-ID: <20090506213523.GB17311@pengutronix.de>
References: <1241641718-14585-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DKU6Jbt7q3WqK7+M"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1241641718-14585-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


--DKU6Jbt7q3WqK7+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2009 at 10:28:38PM +0200, Linus Walleij wrote:
> From: root <root@fecusia.(none)>

Hello root :)

> This replace all instances in the i2c busses tree of
> res->end - res->start + 1 with the handy macro resource_size(res)
> from ioport.h (coming in from platform_device.h).

The include-chain is: platform_device.h -> device.h -> ioport.h

Looks somewhat safe to me; then again ~20 drivers have included it directly
already. Hmm, the latter one is the bullet-proof method, after all. Maybe t=
his
could be done here, too?

>=20
> This was created with a simple
> sed -i -e 's/\([a-z]*\)->end *- *[a-z]*->start *+ *1/resource_size(\1)/g'
>=20
> Then manually replacing the PXA redefiniton of the same kind
> of macro manually. Recompiled some ARM defconfigs I could find to
> make a rough test so it shouldn't break anything, though I
> couldn't see exactly which configs you need for all the drivers.
>=20
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Rest looked good to me:

Acked-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-at91.c         |    8 ++++----
>  drivers/i2c/busses/i2c-au1550.c       |    2 +-
>  drivers/i2c/busses/i2c-bfin-twi.c     |    2 +-
>  drivers/i2c/busses/i2c-highlander.c   |    2 +-
>  drivers/i2c/busses/i2c-mv64xxx.c      |    2 +-
>  drivers/i2c/busses/i2c-ocores.c       |    8 ++++----
>  drivers/i2c/busses/i2c-omap.c         |    2 +-
>  drivers/i2c/busses/i2c-pca-platform.c |   10 ++++------
>  drivers/i2c/busses/i2c-pmcmsp.c       |    8 ++++----
>  drivers/i2c/busses/i2c-pxa.c          |    9 ++++-----
>  drivers/i2c/busses/i2c-versatile.c    |    6 +++---
>  11 files changed, 28 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 67d9dc5..06e1ecb 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -200,10 +200,10 @@ static int __devinit at91_i2c_probe(struct platform=
_device *pdev)
>  	if (!res)
>  		return -ENXIO;
> =20
> -	if (!request_mem_region(res->start, res->end - res->start + 1, "at91_i2=
c"))
> +	if (!request_mem_region(res->start, resource_size(res), "at91_i2c"))
>  		return -EBUSY;
> =20
> -	twi_base =3D ioremap(res->start, res->end - res->start + 1);
> +	twi_base =3D ioremap(res->start, resource_size(res));
>  	if (!twi_base) {
>  		rc =3D -ENOMEM;
>  		goto fail0;
> @@ -252,7 +252,7 @@ fail2:
>  fail1:
>  	iounmap(twi_base);
>  fail0:
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
> =20
>  	return rc;
>  }
> @@ -268,7 +268,7 @@ static int __devexit at91_i2c_remove(struct platform_=
device *pdev)
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	iounmap(twi_base);
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
> =20
>  	clk_disable(twi_clk);		/* disable peripheral clock */
>  	clk_put(twi_clk);
> diff --git a/drivers/i2c/busses/i2c-au1550.c b/drivers/i2c/busses/i2c-au1=
550.c
> index f78ce52..532828b 100644
> --- a/drivers/i2c/busses/i2c-au1550.c
> +++ b/drivers/i2c/busses/i2c-au1550.c
> @@ -389,7 +389,7 @@ i2c_au1550_probe(struct platform_device *pdev)
>  		goto out;
>  	}
> =20
> -	priv->ioarea =3D request_mem_region(r->start, r->end - r->start + 1,
> +	priv->ioarea =3D request_mem_region(r->start, resource_size(r),
>  					  pdev->name);
>  	if (!priv->ioarea) {
>  		ret =3D -EBUSY;
> diff --git a/drivers/i2c/busses/i2c-bfin-twi.c b/drivers/i2c/busses/i2c-b=
fin-twi.c
> index fc548b3..1fceaf0 100644
> --- a/drivers/i2c/busses/i2c-bfin-twi.c
> +++ b/drivers/i2c/busses/i2c-bfin-twi.c
> @@ -632,7 +632,7 @@ static int i2c_bfin_twi_probe(struct platform_device =
*pdev)
>  		goto out_error_get_res;
>  	}
> =20
> -	iface->regs_base =3D ioremap(res->start, res->end - res->start + 1);
> +	iface->regs_base =3D ioremap(res->start, resource_size(res));
>  	if (iface->regs_base =3D=3D NULL) {
>  		dev_err(&pdev->dev, "Cannot map IO\n");
>  		rc =3D -ENXIO;
> diff --git a/drivers/i2c/busses/i2c-highlander.c b/drivers/i2c/busses/i2c=
-highlander.c
> index e5a8dae..87ecace 100644
> --- a/drivers/i2c/busses/i2c-highlander.c
> +++ b/drivers/i2c/busses/i2c-highlander.c
> @@ -373,7 +373,7 @@ static int __devinit highlander_i2c_probe(struct plat=
form_device *pdev)
>  	if (unlikely(!dev))
>  		return -ENOMEM;
> =20
> -	dev->base =3D ioremap_nocache(res->start, res->end - res->start + 1);
> +	dev->base =3D ioremap_nocache(res->start, resource_size(res));
>  	if (unlikely(!dev->base)) {
>  		ret =3D -ENXIO;
>  		goto err;
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv=
64xxx.c
> index 5a4945d..c3869d9 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> @@ -469,7 +469,7 @@ mv64xxx_i2c_map_regs(struct platform_device *pd,
>  	if (!r)
>  		return -ENODEV;
> =20
> -	size =3D r->end - r->start + 1;
> +	size =3D resource_size(r);
> =20
>  	if (!request_mem_region(r->start, size, drv_data->adapter.name))
>  		return -EBUSY;
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-oco=
res.c
> index e5193bf..eec9ab2 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -233,14 +233,14 @@ static int __devinit ocores_i2c_probe(struct platfo=
rm_device *pdev)
>  	if (!i2c)
>  		return -ENOMEM;
> =20
> -	if (!request_mem_region(res->start, res->end - res->start + 1,
> +	if (!request_mem_region(res->start, resource_size(res),
>  				pdev->name)) {
>  		dev_err(&pdev->dev, "Memory region busy\n");
>  		ret =3D -EBUSY;
>  		goto request_mem_failed;
>  	}
> =20
> -	i2c->base =3D ioremap(res->start, res->end - res->start + 1);
> +	i2c->base =3D ioremap(res->start, resource_size(res));
>  	if (!i2c->base) {
>  		dev_err(&pdev->dev, "Unable to map registers\n");
>  		ret =3D -EIO;
> @@ -278,7 +278,7 @@ add_adapter_failed:
>  request_irq_failed:
>  	iounmap(i2c->base);
>  map_failed:
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
>  request_mem_failed:
>  	kfree(i2c);
> =20
> @@ -306,7 +306,7 @@ static int __devexit ocores_i2c_remove(struct platfor=
m_device* pdev)
> =20
>  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (res)
> -		release_mem_region(res->start, res->end - res->start + 1);
> +		release_mem_region(res->start, resource_size(res));
> =20
>  	kfree(i2c);
> =20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index ece0125..af14635 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -807,7 +807,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  	dev->idle =3D 1;
>  	dev->dev =3D &pdev->dev;
>  	dev->irq =3D irq->start;
> -	dev->base =3D ioremap(mem->start, mem->end - mem->start + 1);
> +	dev->base =3D ioremap(mem->start, resource_size(mem));
>  	if (!dev->base) {
>  		r =3D -ENOMEM;
>  		goto err_free_mem;
> diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i=
2c-pca-platform.c
> index 7b23891..c4df9d4 100644
> --- a/drivers/i2c/busses/i2c-pca-platform.c
> +++ b/drivers/i2c/busses/i2c-pca-platform.c
> @@ -27,8 +27,6 @@
>  #include <asm/irq.h>
>  #include <asm/io.h>
> =20
> -#define res_len(r)		((r)->end - (r)->start + 1)
> -
>  struct i2c_pca_pf_data {
>  	void __iomem			*reg_base;
>  	int				irq;	/* if 0, use polling */
> @@ -148,7 +146,7 @@ static int __devinit i2c_pca_pf_probe(struct platform=
_device *pdev)
>  		goto e_print;
>  	}
> =20
> -	if (!request_mem_region(res->start, res_len(res), res->name)) {
> +	if (!request_mem_region(res->start, resource_size(res), res->name)) {
>  		ret =3D -ENOMEM;
>  		goto e_print;
>  	}
> @@ -161,13 +159,13 @@ static int __devinit i2c_pca_pf_probe(struct platfo=
rm_device *pdev)
> =20
>  	init_waitqueue_head(&i2c->wait);
> =20
> -	i2c->reg_base =3D ioremap(res->start, res_len(res));
> +	i2c->reg_base =3D ioremap(res->start, resource_size(res));
>  	if (!i2c->reg_base) {
>  		ret =3D -ENOMEM;
>  		goto e_remap;
>  	}
>  	i2c->io_base =3D res->start;
> -	i2c->io_size =3D res_len(res);
> +	i2c->io_size =3D resource_size(res);
>  	i2c->irq =3D irq;
> =20
>  	i2c->adap.nr =3D pdev->id >=3D 0 ? pdev->id : 0;
> @@ -250,7 +248,7 @@ e_reqirq:
>  e_remap:
>  	kfree(i2c);
>  e_alloc:
> -	release_mem_region(res->start, res_len(res));
> +	release_mem_region(res->start, resource_size(res));
>  e_print:
>  	printk(KERN_ERR "Registering PCA9564/PCA9665 FAILED! (%d)\n", ret);
>  	return ret;
> diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmc=
msp.c
> index 0bdb2d7..7b57d5f 100644
> --- a/drivers/i2c/busses/i2c-pmcmsp.c
> +++ b/drivers/i2c/busses/i2c-pmcmsp.c
> @@ -283,7 +283,7 @@ static int __devinit pmcmsptwi_probe(struct platform_=
device *pldev)
>  	}
> =20
>  	/* reserve the memory region */
> -	if (!request_mem_region(res->start, res->end - res->start + 1,
> +	if (!request_mem_region(res->start, resource_size(res),
>  				pldev->name)) {
>  		dev_err(&pldev->dev,
>  			"Unable to get memory/io address region 0x%08x\n",
> @@ -294,7 +294,7 @@ static int __devinit pmcmsptwi_probe(struct platform_=
device *pldev)
> =20
>  	/* remap the memory */
>  	pmcmsptwi_data.iobase =3D ioremap_nocache(res->start,
> -						res->end - res->start + 1);
> +						resource_size(res));
>  	if (!pmcmsptwi_data.iobase) {
>  		dev_err(&pldev->dev,
>  			"Unable to ioremap address 0x%08x\n", res->start);
> @@ -360,7 +360,7 @@ ret_unmap:
>  	iounmap(pmcmsptwi_data.iobase);
> =20
>  ret_unreserve:
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
> =20
>  ret_err:
>  	return rc;
> @@ -385,7 +385,7 @@ static int __devexit pmcmsptwi_remove(struct platform=
_device *pldev)
>  	iounmap(pmcmsptwi_data.iobase);
> =20
>  	res =3D platform_get_resource(pldev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, res->end - res->start + 1);
> +	release_mem_region(res->start, resource_size(res));
> =20
>  	return 0;
>  }
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index c1405c8..b330883 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -979,7 +979,6 @@ static const struct i2c_algorithm i2c_pxa_pio_algorit=
hm =3D {
>  	.functionality	=3D i2c_pxa_functionality,
>  };
> =20
> -#define res_len(r)		((r)->end - (r)->start + 1)
>  static int i2c_pxa_probe(struct platform_device *dev)
>  {
>  	struct pxa_i2c *i2c;
> @@ -993,7 +992,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  	if (res =3D=3D NULL || irq < 0)
>  		return -ENODEV;
> =20
> -	if (!request_mem_region(res->start, res_len(res), res->name))
> +	if (!request_mem_region(res->start, resource_size(res), res->name))
>  		return -ENOMEM;
> =20
>  	i2c =3D kzalloc(sizeof(struct pxa_i2c), GFP_KERNEL);
> @@ -1023,7 +1022,7 @@ static int i2c_pxa_probe(struct platform_device *de=
v)
>  		goto eclk;
>  	}
> =20
> -	i2c->reg_base =3D ioremap(res->start, res_len(res));
> +	i2c->reg_base =3D ioremap(res->start, resource_size(res));
>  	if (!i2c->reg_base) {
>  		ret =3D -EIO;
>  		goto eremap;
> @@ -1031,7 +1030,7 @@ static int i2c_pxa_probe(struct platform_device *de=
v)
>  	i2c->reg_shift =3D (cpu_is_pxa3xx() && (dev->id =3D=3D 1)) ? 0 : 1;
> =20
>  	i2c->iobase =3D res->start;
> -	i2c->iosize =3D res_len(res);
> +	i2c->iosize =3D resource_size(res);
> =20
>  	i2c->irq =3D irq;
> =20
> @@ -1095,7 +1094,7 @@ eremap:
>  eclk:
>  	kfree(i2c);
>  emalloc:
> -	release_mem_region(res->start, res_len(res));
> +	release_mem_region(res->start, resource_size(res));
>  	return ret;
>  }
> =20
> diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-=
versatile.c
> index fede619..70de821 100644
> --- a/drivers/i2c/busses/i2c-versatile.c
> +++ b/drivers/i2c/busses/i2c-versatile.c
> @@ -76,7 +76,7 @@ static int i2c_versatile_probe(struct platform_device *=
dev)
>  		goto err_out;
>  	}
> =20
> -	if (!request_mem_region(r->start, r->end - r->start + 1, "versatile-i2c=
")) {
> +	if (!request_mem_region(r->start, resource_size(r), "versatile-i2c")) {
>  		ret =3D -EBUSY;
>  		goto err_out;
>  	}
> @@ -87,7 +87,7 @@ static int i2c_versatile_probe(struct platform_device *=
dev)
>  		goto err_release;
>  	}
> =20
> -	i2c->base =3D ioremap(r->start, r->end - r->start + 1);
> +	i2c->base =3D ioremap(r->start, resource_size(r));
>  	if (!i2c->base) {
>  		ret =3D -ENOMEM;
>  		goto err_free;
> @@ -118,7 +118,7 @@ static int i2c_versatile_probe(struct platform_device=
 *dev)
>   err_free:
>  	kfree(i2c);
>   err_release:
> -	release_mem_region(r->start, r->end - r->start + 1);
> +	release_mem_region(r->start, resource_size(r));
>   err_out:
>  	return ret;
>  }
> --=20
> 1.6.0.6
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--DKU6Jbt7q3WqK7+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoCApsACgkQD27XaX1/VRtjDgCfV/qN9J9zAXtLOfkHddxWtkMr
dmIAn0DUmIuheheg5k+Joq5Yp7P5nPis
=Flv4
-----END PGP SIGNATURE-----

--DKU6Jbt7q3WqK7+M--
