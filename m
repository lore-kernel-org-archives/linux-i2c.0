From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v9 1/3] dt-bindings: i2c: npcm7xx: add NPCM I2C controller
Date: Mon, 23 Mar 2020 17:03:45 +0200
Message-ID: <20200323150345.GP1922688@smile.fi.intel.com>
References: <20200323134437.259210-1-tali.perry1@gmail.com>
 <20200323134437.259210-2-tali.perry1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200323134437.259210-2-tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tali Perry <tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: brendanhiggins-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, avifishman70-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tmaimon77-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kfting-KrzQf0k3Iz9BDgjK7y7TUQ@public.gmane.org, venture-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, yuenn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benjaminfair-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, openbmc-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Mar 23, 2020 at 03:44:35PM +0200, Tali Perry wrote:
> Added device tree binding documentation for Nuvoton BMC
> NPCM I2C controller.
> 
> Signed-off-by: Tali Perry <tali.perry1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  .../devicetree/bindings/i2c/i2c-npcm7xx.txt   | 29 +++++++++++++++++++

Wouldn't be better to have it in YAML from the day 1?

-- 
With Best Regards,
Andy Shevchenko
