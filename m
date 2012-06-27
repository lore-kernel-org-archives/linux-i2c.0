From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/2 V3] MXS: Set I2C timing registers for mxs-i2c
Date: Wed, 27 Jun 2012 04:34:20 +0200
Message-ID: <201206270434.20558.marex@denx.de>
References: <1339242351-8797-1-git-send-email-marex@denx.de> <201206270330.31669.marex@denx.de> <20120627021336.GA9787@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120627021336.GA9787-rvtDTF3kK1ictlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Detlev Zundel <dzu-ynQEQJNshbs@public.gmane.org>, Dong Aisheng <b29396-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux ARM kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>, Uwe =?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfgang Denk <wd-ynQEQJNshbs@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Dear Shawn Guo,

> On Wed, Jun 27, 2012 at 03:30:31AM +0200, Marek Vasut wrote:
> > Ok, I managed to replicate it just now. Scrap my previous email.
> > 
> > Still, any idea what can cause this?
> 
> I just spent some time on it.  It looks like a document issue (dammit).
> 
> The HW_I2C_TIMING2 EXAMPLE tells the value is 0x0015000d which is the
> one you looked at and used.  But the register field figure tells it's
> 0x00300030, which seems the real case.
> 
> The mxs_i2c_reset at probe changes the value to 0x0015000d which causes
> the first time playback nonfunctional, but the mxs_i2c_reset call in
> mxs_i2c_xfer_msg happens to reset the value back to 0x00300030, and
> then second time playback starts working.
> 
> The changes below get everything work fine, both 100k and 400k.  So
> with the changes in, you can add:

Ok, can you push the FSL guys to roll out updated document?

Do you consider it reasonable to add some calculations of these timing values or 
were they somehow fine-tuned with a scope/deep HW knowledge as the best working 
values and we should stick to those?

> Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Regards,
> Shawn
> 
> --8<---
> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index e38be56..c2467e9 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -112,13 +112,13 @@ struct mxs_i2c_speed_config {
>  const struct mxs_i2c_speed_config mxs_i2c_95kHz_config = {
>         .timing0        = 0x00780030,
>         .timing1        = 0x00800030,
> -       .timing2        = 0x0015000d,
> +       .timing2        = 0x00300030,
>  };
> 
>  const struct mxs_i2c_speed_config mxs_i2c_400kHz_config = {
>         .timing0        = 0x000f0007,
>         .timing1        = 0x001f000f,
> -       .timing2        = 0x0015000d,
> +       .timing2        = 0x00300030,
>  };

Best regards,
Marek Vasut
