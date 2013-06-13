From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH] i2c-designware-core: disable adapter before fill dev
 structure
Date: Thu, 13 Jun 2013 10:16:24 +0200
Message-ID: <20130613081621.GB19061@ab42.lan>
References: <CAHp75VfwSTO7UoEGVpd7qdFVSFNYrBG6aXx1Oj8UAkgbmi=1XQ@mail.gmail.com>
 <1370597401-22501-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1370597401-22501-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

As promised, I gave this one some over-night stress testing and I can
confirm what I said previously:

- The patch does _not_ solve the interrupt loop lockups on its own.
- The patch works well in conjunction with
  http://patchwork.ozlabs.org/patch/249622/ (which in turn depends on
  Mika's patch). Under this condition you can assume
  Tested-By: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>

I still think the code is more logical with this patch than without it
and I am in favour of applying both (if Andy agrees that is). We must
keep in mind, however, that http://patchwork.ozlabs.org/patch/249622
does fix a real problem we can observe on our chip and for our TB10x
product we do require some form of it for stability reasons.

Greetings,
  Christian

On Fri, Jun 07, 2013 at 12:30:01PM +0300, Andy Shevchenko wrote:
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-designware-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-core.c b/drivers/i2c/b=
usses/i2c-designware-core.c
> index c41ca63..a1d3d95 100644
> --- a/drivers/i2c/busses/i2c-designware-core.c
> +++ b/drivers/i2c/busses/i2c-designware-core.c
> @@ -366,9 +366,6 @@ static void i2c_dw_xfer_init(struct dw_i2c_dev *d=
ev)
>  	struct i2c_msg *msgs =3D dev->msgs;
>  	u32 ic_con;
> =20
> -	/* Disable the adapter */
> -	__i2c_dw_enable(dev, false);
> -
>  	/* set the slave (target) address */
>  	dw_writel(dev, msgs[dev->msg_write_idx].addr, DW_IC_TAR);
> =20
> @@ -561,6 +558,13 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c=
_msg msgs[], int num)
>  	mutex_lock(&dev->lock);
>  	pm_runtime_get_sync(dev->dev);
> =20
> +	ret =3D i2c_dw_wait_bus_not_busy(dev);
> +	if (ret < 0)
> +		goto done;
> +
> +	/* Disable the adapter */
> +	__i2c_dw_enable(dev, false);
> +
>  	INIT_COMPLETION(dev->cmd_complete);
>  	dev->msgs =3D msgs;
>  	dev->msgs_num =3D num;
> @@ -572,10 +576,6 @@ i2c_dw_xfer(struct i2c_adapter *adap, struct i2c=
_msg msgs[], int num)
>  	dev->abort_source =3D 0;
>  	dev->rx_outstanding =3D 0;
> =20
> -	ret =3D i2c_dw_wait_bus_not_busy(dev);
> -	if (ret < 0)
> -		goto done;
> -
>  	/* start the transfers */
>  	i2c_dw_xfer_init(dev);
> =20
> --=20
> 1.8.2.rc0.22.gb3600c3
>=20

--=20
  Christian Ruppert              ,          <christian.ruppert@abilis.c=
om>
                                /|
  Tel: +41/(0)22 816 19-42     //|                 3, Chemin du Pr=E9-F=
leuri
                             _// | bilis Systems   CH-1228 Plan-les-Oua=
tes
