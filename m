From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [Patch V8] i2c: imx: add runtime pm support to improve the
 performance
Date: Tue, 13 Oct 2015 09:07:11 +0200
Message-ID: <20151013070711.GA3982@pengutronix.de>
References: <1442569869-10584-1-git-send-email-b54642@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47168 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbJMHHP (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Tue, 13 Oct 2015 03:07:15 -0400
Content-Disposition: inline
In-Reply-To: <1442569869-10584-1-git-send-email-b54642@freescale.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Gao Pan <b54642@freescale.com>
Cc: wsa@the-dreams.de, linux-i2c@vger.kernel.org, B20596@freescale.com, b38611@freescale.com, kernel@pengutronix.de, hkallweit1@gmail.com

Hello,

On Fri, Sep 18, 2015 at 05:51:09PM +0800, Gao Pan wrote:
> In our former i2c driver, i2c clk is enabled and disabled in
> xfer function, which contributes to power saving. However,
> the clk enable process brings a busy wait delay until the core
> is stable. As a result, the performance is sacrificed.
>=20
> To weigh the power consumption and i2c bus performance, runtime
> pm is the good solution for it. The clk is enabled when a i2c
> transfer starts, and disabled after a specifically defined delay.
>=20
> Without the patch the test case (many eeprom reads) executes with app=
rox:
> real 1m7.735s
> user 0m0.488s
> sys 0m20.040s
>=20
> With the patch the same test case (many eeprom reads) executes with a=
pprox:
> real 0m54.241s
> user 0m0.440s
> sys 0m5.920s
>=20
> Signed-off-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Gao Pan <b54642@freescale.com>

If runtime-pm is disabled the net result of this patch is that the cloc=
k
is never disabled, right? I think this is ok, but I would have pointed
that out in the commit log.

> @@ -1037,6 +1045,18 @@ static int i2c_imx_probe(struct platform_devic=
e *pdev)
>  	/* Set up adapter data */
>  	i2c_set_adapdata(&i2c_imx->adapter, i2c_imx);
> =20
> +	/* Set up platform driver data */
> +	platform_set_drvdata(pdev, i2c_imx);
> +
> +	pm_runtime_set_autosuspend_delay(&pdev->dev, I2C_PM_TIMEOUT);
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret =3D pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0)
> +		goto rpm_disable;
> +
>  	/* Set up clock divider */
>  	i2c_imx->bitrate =3D IMX_I2C_BIT_RATE;
>  	ret =3D of_property_read_u32(pdev->dev.of_node,
> @@ -1053,12 +1073,11 @@ static int i2c_imx_probe(struct platform_devi=
ce *pdev)
>  	ret =3D i2c_add_numbered_adapter(&i2c_imx->adapter);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "registration failed\n");
> -		goto clk_disable;
> +		goto rpm_disable;

Is it right, that here the same error path is taken as when
pm_runtime_get_sync fails above? Even if it works now, not having the
error cleanup path undo all things in reverse order is a danger to get
it wrong in the next change. So if this is fixable, it would be nice to
implement.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
