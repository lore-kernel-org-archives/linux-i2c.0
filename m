From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 3/9] I2C: mv64xxx: use devm_ioremap_resource()
Date: Fri, 17 May 2013 11:23:16 +0200
Message-ID: <20130517112316.12a3ddc3@armhf>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
	<E1Ud4rN-0004Jc-CL@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1Ud4rN-0004Jc-CL-eh5Bv4kxaXIANfyc6IWni62ZND6+EDdj@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Mark A. Greer" <mgreer-luAo+O/VEmrlveNOaEYElw@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, 16 May 2013 21:33:09 +0100
Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

> Eliminate reg_base_p and reg_size, mv64xxx_i2c_unmap_regs() and an
> unchecked ioremap() return from this driver by using the devm_*
> API for requesting and ioremapping resources.
>=20
> Signed-off-by: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c |   46 +++++-----------------------=
----------
>  1 files changed, 6 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2=
c-mv64xxx.c
> index 0339cd8..19cc9bf 100644
> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
	[snip]
> @@ -704,7 +671,6 @@ mv64xxx_i2c_remove(struct platform_device *dev)
> =20
>  	rc =3D i2c_del_adapter(&drv_data->adapter);
>  	free_irq(drv_data->irq, drv_data);
> -	mv64xxx_i2c_unmap_regs(drv_data);
>  #if defined(CONFIG_HAVE_CLK)
>  	/* Not all platforms have a clk */
>  	if (!IS_ERR(drv_data->clk)) {

The patch does not apply: it seems it lacks:

+	int rc;

-	i2c_del_adapter(&drv_data->adapter);
+	rc =3D i2c_del_adapter(&drv_data->adapter);

-	return 0;
+	return rc;

BTW, is this return code useful?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
