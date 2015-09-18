From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [Patch V7] i2c: imx: add runtime pm support to improve the
 performance
Date: Fri, 18 Sep 2015 10:13:58 +0200
Message-ID: <20150918081358.GU5327@pengutronix.de>
References: <1441764739-23086-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441764739-23086-1-git-send-email-b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, B20596-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Wed, Sep 09, 2015 at 10:12:19AM +0800, Gao Pan wrote:
>  static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
> @@ -894,6 +893,10 @@ static int i2c_imx_xfer(struct i2c_adapter *adap=
ter,
> =20
>  	dev_dbg(&i2c_imx->adapter.dev, "<%s>\n", __func__);
> =20
> +	result =3D pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
> +	if (result < 0)
> +		goto out;
> +
>  	/* Start I2C transfer */
>  	result =3D i2c_imx_start(i2c_imx);
>  	if (result)
> @@ -950,6 +953,10 @@ fail0:
>  	/* Stop I2C transfer */
>  	i2c_imx_stop(i2c_imx);
> =20
> +out:
> +	pm_runtime_mark_last_busy(i2c_imx->adapter.dev.parent);
> +	pm_runtime_put_autosuspend(i2c_imx->adapter.dev.parent);
> +

I doubt that it's correct to call these two functions if
pm_runtime_get_sync failed. Shouldn't the out label be after the two
calls?

Other than that I assume you tested your patch with and without CONFIG_=
PM?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
