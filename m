From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] i2c: imx: use exact SoC revision to document binding
Date: Wed, 21 Aug 2013 10:26:40 +0800
Message-ID: <20130821022637.GF30533@S2101-09.ap.freescale.net>
References: <1377051119-23004-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377051119-23004-1-git-send-email-b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Aug 21, 2013 at 10:11:59AM +0800, Jingchang Lu wrote:
> use exact SoC revision instead of wildcard describing
> the compatible property requirement in the binding
> document. This will make the binding more clearer.
> 
> Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

Acked-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-imx.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.txt b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> index 3614242..4a8513e 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-imx.txt
> @@ -1,7 +1,10 @@
>  * Freescale Inter IC (I2C) and High Speed Inter IC (HS-I2C) for i.MX
>  
>  Required properties:
> -- compatible : Should be "fsl,<chip>-i2c"
> +- compatible :
> +  - "fsl,imx1-i2c" for I2C compatible with the one integrated on i.MX1 SoC
> +  - "fsl,imx21-i2c" for I2C compatible with the one integrated on i.MX21 SoC
> +  - "fsl,vf610-i2c" for I2C compatible with the one integrated on Vybrid vf610 SoC
>  - reg : Should contain I2C/HS-I2C registers location and length
>  - interrupts : Should contain I2C/HS-I2C interrupt
>  
> -- 
> 1.8.0
> 
> 
