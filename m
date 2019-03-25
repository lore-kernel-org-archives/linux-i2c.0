From: Leo Li <leoyang.li@nxp.com>
Subject: RE: [RESEND] i2c: imx: defer probing on dma channel request
Date: Mon, 25 Mar 2019 19:15:27 +0000
Message-ID: <AM6PR04MB58633D7FDB038AFADD5547218F5E0@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325153016.12626-1-laurentiu.tudor@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Ying Zhang <ying.zhang22455@nxp.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "upstream-release@linux.nxdi.nxp.com" <upstream-release@linux.nxdi.nxp.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: laurentiu.tudor@nxp.com <laurentiu.tudor@nxp.com>
> Sent: Monday, March 25, 2019 10:30 AM
> To: linux-i2c@vger.kernel.org; Ying Zhang <ying.zhang22455@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; upstream-
> release@linux.nxdi.nxp.com; Leo Li <leoyang.li@nxp.com>; Laurentiu Tudor
> <laurentiu.tudor@nxp.com>
> Subject: [RESEND] i2c: imx: defer probing on dma channel request
>=20
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> If the dma controller is not yet probed, defer i2c probe.
> The error path in probe was slightly modified (no functional change) to a=
void
> triggering this WARN_ON():
> "cg-pll0-div1 already disabled
> WARNING: CPU: 1 PID: 1 at drivers/clk/clk.c:828 clk_core_disable+0xa8/0xb=
0"

You are removing clk_disable_unprepare() from all error paths except the ir=
q error.  Not sure why this is needed.

>=20
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/i2c/busses/i2c-imx.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c =
index
> 42fed40198a0..4e34b1572756 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -1111,7 +1111,8 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  				pdev->name, i2c_imx);
>  	if (ret) {
>  		dev_err(&pdev->dev, "can't claim irq %d\n", irq);
> -		goto clk_disable;
> +		clk_disable_unprepare(i2c_imx->clk);
> +		return ret;
>  	}
>=20
>  	/* Init queue */
> @@ -1161,19 +1162,25 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
>=20
> +	/* Init DMA config if supported */
> +	ret =3D i2c_imx_dma_request(i2c_imx, phy_addr);
> +	if (ret) {
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_info(&pdev->dev, "can't use DMA, using PIO
> instead.\n");
> +		else
> +			goto del_adapter;
> +	}
> +
>  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
>  	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>  		i2c_imx->adapter.name);
>=20
> -	/* Init DMA config if supported */
> -	ret =3D i2c_imx_dma_request(i2c_imx, phy_addr);
> -	if (ret < 0)
> -		goto clk_notifier_unregister;
> -
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
>  	return 0;   /* Return OK */
>=20
> +del_adapter:
> +	i2c_del_adapter(&i2c_imx->adapter);
>  clk_notifier_unregister:
>  	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
>  rpm_disable:
> @@ -1182,8 +1189,6 @@ static int i2c_imx_probe(struct platform_device
> *pdev)
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_dont_use_autosuspend(&pdev->dev);
>=20
> -clk_disable:
> -	clk_disable_unprepare(i2c_imx->clk);
>  	return ret;
>  }
>=20
> --
> 2.17.1
