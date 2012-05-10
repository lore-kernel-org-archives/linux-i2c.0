From: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH V2 03/11] ASoC: imx-audmux: add pinctrl support
Date: Thu, 10 May 2012 11:28:05 +0800
Message-ID: <20120510032804.GA6622@shlinux2.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-4-git-send-email-richard.zhao@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1336563190-19974-4-git-send-email-richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, May 09, 2012 at 07:33:02PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  sound/soc/fsl/imx-audmux.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
Acked-by: Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I guess you may want it to go through arm-soc tree which already has
a patch asking pinctrl to provide dummies or it may break the drivers.

Regards
Dong Aisheng

> diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
> index f237003..0803274 100644
> --- a/sound/soc/fsl/imx-audmux.c
> +++ b/sound/soc/fsl/imx-audmux.c
> @@ -26,6 +26,7 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #include "imx-audmux.h"
>  
> @@ -249,6 +250,7 @@ EXPORT_SYMBOL_GPL(imx_audmux_v2_configure_port);
>  static int __devinit imx_audmux_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> +	struct pinctrl *pinctrl;
>  	const struct of_device_id *of_id =
>  			of_match_device(imx_audmux_dt_ids, &pdev->dev);
>  
> @@ -257,6 +259,12 @@ static int __devinit imx_audmux_probe(struct platform_device *pdev)
>  	if (!audmux_base)
>  		return -EADDRNOTAVAIL;
>  
> +	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
> +	if (IS_ERR(pinctrl)) {
> +		dev_err(&pdev->dev, "setup pinctrl failed!");
> +		return PTR_ERR(pinctrl);
> +	}
> +
>  	audmux_clk = clk_get(&pdev->dev, "audmux");
>  	if (IS_ERR(audmux_clk)) {
>  		dev_dbg(&pdev->dev, "cannot get clock: %ld\n",
> -- 
> 1.7.5.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
