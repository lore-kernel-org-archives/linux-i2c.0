From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller
 support
Date: Sat, 10 Aug 2013 15:08:27 +0100
Message-ID: <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1375418648-22760-2-git-send-email-b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Xiaochun Li <b41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Jin <Jason.jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
>   Add Freescale Vybrid VF610 I2C controller support to
> imx I2C driver framework.
>   Some operation is different from imx I2C controller.
> The register offset, the i2c clock divider value table,
> the module enabling(I2CR_IEN) which is just invert with imx,
> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
> but w0c on imx.
> 
> Signed-off-by: Jason Jin <Jason.jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Xiaochun Li <b41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> changes in v3:
>   Using struct naming the i2c clock {div, regval} pair.
>   Using address shift handling registers address difference.
> 
> changes in v2:
>   Fix building section mismatch(es) warning.
> 
>  drivers/i2c/busses/i2c-imx.c | 146 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 122 insertions(+), 24 deletions(-)

[...]

> @@ -145,6 +233,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype);
>  static const struct of_device_id i2c_imx_dt_ids[] = {
>         { .compatible = "fsl,imx1-i2c", .data = &imx_i2c_devtype[IMX1_I2C], },
>         { .compatible = "fsl,imx21-i2c", .data = &imx_i2c_devtype[IMX21_I2C], },
> +       { .compatible = "fsl,vf610-i2c", .data = &imx_i2c_devtype[VF610_I2C], },
>         { /* sentinel */ }
>  };


That string doesn't seem to be documented anywhere (from a quick grep of
Documentation/devicetree), and there's no binding update included
here. It would be nice for that to be fixed :)

Thanks,
Mark.
