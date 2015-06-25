From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
Date: Thu, 25 Jun 2015 16:18:00 +0100
Message-ID: <20150625151800.GC6844@leverpostej>
References: <1434644382-11905-1-git-send-email-anuragku@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434644382-11905-1-git-send-email-anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anurag Kumar Vulisha <anurag.kumar.vulisha-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <svemula-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Anurag Kumar Vulisha <anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Jun 18, 2015 at 05:19:42PM +0100, Anurag Kumar Vulisha wrote:
> Removed the workarounds present in the cadence i2c driver for
> Zynq Ultrascale+ MPSoC

I guess this means that cdns,i2c-r1p10 had quirks fixed in
cdns,i2c-r1p14? It would be helpful to be a bit more explicit in the
commit message.

> 
> Signed-off-by: Anurag Kumar Vulisha <anuragku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-cadence.txt        |    2 +-
>  drivers/i2c/busses/i2c-cadence.c                   |   67 ++++++++++++++++---
>  2 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> index 7cb0b56..11ef7f2 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> @@ -2,7 +2,7 @@ Binding for the Cadence I2C controller
>  
>  Required properties:
>    - reg: Physical base address and size of the controller's register area.
> -  - compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
> +  - compatible: Compatibility string.Use 'cdns,i2c-r1p10' or 'cdns,i2c-r1p14'

Please format this as a list. It aids legibility and expansion. e.g:

- compatible: should contain one of:
  * "cdns,i2c-r1p10"
  * "cdns,i2c-r1p14"

Perhaps with notes as to the differences.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
