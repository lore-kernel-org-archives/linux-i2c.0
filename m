From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] i2c: designware-platdrv: fix unbalanced clk enable
 and prepare
Date: Thu, 21 Apr 2016 15:29:20 +0300
Message-ID: <1461241760.6620.315.camel@linux.intel.com>
References: <1461237767-7928-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29494 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbcDUM2U (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 21 Apr 2016 08:28:20 -0400
In-Reply-To: <1461237767-7928-1-git-send-email-jszhang@marvell.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, wsa@the-dreams.de
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 2016-04-21 at 19:22 +0800, Jisheng Zhang wrote:
> If i2c_dw_probe() fails, we should disable and unprepare the clock,
> otherwise the clock enable and prepare is left unbalanced.
>=20
> In dw_i2c_plat_remove(), we'd better to not rely on rpm to disable

Sorry, didn't notice earlier
rpm -> runtime PM

> and unprepare the clock since CONFIG_PM may be disabled when
> configuring the kernel. So we explicitly disable and unprepare the
> clock in dw_i2c_plat_remove() rather than implicitly rely on
> pm_runtime_put_sync(). To keep the device usage count balanced, we
> call pm_runtime_put_noidle(() to decrease the usage count.

(() -> ()

>=20
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

I don't know if Wolfram wants you to send new version, and I dunno if
others still have comments, but

Patch is in a good shape, but I think we have to carefully check the
runtime PM change.

> ---
> Since v2:
> =C2=A0- s/clk/clock
> =C2=A0- describe why use pm_runtime_put_noidle()
>=20
> Since v1:
> =C2=A0- fix commit msg: "not rely on rpm" rather than "rely on rpm"
> =C2=A0- call i2c_dw_plat_prepare_clk after pm_rumtime_disable()
>=20
> =C2=A0drivers/i2c/busses/i2c-designware-platdrv.c | 16 ++++++++++----=
--
> =C2=A01 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c
> b/drivers/i2c/busses/i2c-designware-platdrv.c
> index d656657..a771781 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -253,8 +253,11 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
> =C2=A0	}
> =C2=A0
> =C2=A0	r =3D i2c_dw_probe(dev);
> -	if (r && !dev->pm_runtime_disabled)
> -		pm_runtime_disable(&pdev->dev);
> +	if (r) {
> +		if (!dev->pm_runtime_disabled)
> +			pm_runtime_disable(&pdev->dev);
> +		i2c_dw_plat_prepare_clk(dev, false);
> +	}
> =C2=A0
> =C2=A0	return r;
> =C2=A0}
> @@ -264,15 +267,16 @@ static int dw_i2c_plat_remove(struct
> platform_device *pdev)
> =C2=A0	struct dw_i2c_dev *dev =3D platform_get_drvdata(pdev);
> =C2=A0
> =C2=A0	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +	if (!dev->pm_runtime_disabled)
> +		pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> =C2=A0
> =C2=A0	i2c_del_adapter(&dev->adapter);
> =C2=A0
> =C2=A0	i2c_dw_disable(dev);
> =C2=A0
> -	pm_runtime_dont_use_autosuspend(&pdev->dev);
> -	pm_runtime_put_sync(&pdev->dev);
> -	if (!dev->pm_runtime_disabled)
> -		pm_runtime_disable(&pdev->dev);
> +	i2c_dw_plat_prepare_clk(dev, false);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
