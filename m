From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 0/2] Add device tree probe for i2c-imx driver
Date: Fri, 22 Jul 2011 10:15:25 +0800
Message-ID: <20110722021524.GG26837@S2100-06.ap.freescale.net>
References: <1310659425-17499-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1310659425-17499-1-git-send-email-shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Ben,

Any comments, or it's been good for you to queue them for v3.1 window?

Regards,
Shawn

On Fri, Jul 15, 2011 at 12:03:43AM +0800, Shawn Guo wrote:
> The first patch removes unused init/exit hooks from platform data,
> and the second one actually adds the actual device tree probe support.
> 
> Shawn Guo (2):
>       i2c/imx: remove init/exit hooks from platform data
>       i2c/imx: add device tree probe support
> 
>  .../devicetree/bindings/i2c/fsl-imx-i2c.txt        |   25 +++++++++++
>  arch/arm/plat-mxc/include/mach/i2c.h               |    4 --
>  drivers/i2c/busses/i2c-imx.c                       |   46 +++++++++----------
>  3 files changed, 47 insertions(+), 28 deletions(-)
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
