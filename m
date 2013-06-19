From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
Date: Wed, 19 Jun 2013 16:51:30 +0800
Message-ID: <20130619085127.GB3405@S2101-09.ap.freescale.net>
References: <1371545327-12481-1-git-send-email-b35083@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1371545327-12481-1-git-send-email-b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jason Jin <Jason.jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Xiaochun Li <b41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jun 18, 2013 at 04:48:47PM +0800, Jingchang Lu wrote:
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

Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
