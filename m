From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c: mxs: set controller to pio queue mode after reset
Date: Mon, 7 Mar 2011 00:47:36 +0000
Message-ID: <20110307004736.GC15795@trinity.fluff.org>
References: <1298656491-30686-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1298656491-30686-1-git-send-email-w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, Feb 25, 2011 at 06:54:51PM +0100, Wolfram Sang wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> 
> mxs_reset_block() clears the PIO_QUEUE_MODE bit. So we have
> to set it again after a controller reset.

-rc candidate?
 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Cc: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-mxs.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 8022e23..caf96dc 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -118,6 +118,8 @@ static void mxs_i2c_reset(struct mxs_i2c_dev *i2c)
>  {
>  	mxs_reset_block(i2c->regs);
>  	writel(MXS_I2C_IRQ_MASK << 8, i2c->regs + MXS_I2C_CTRL1_SET);
> +	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
> +			i2c->regs + MXS_I2C_QUEUECTRL_SET);
>  }
>  
>  static void mxs_i2c_pioq_setup_read(struct mxs_i2c_dev *i2c, u8 addr, int len,
> @@ -347,8 +349,6 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
>  
>  	/* Do reset to enforce correct startup after pinmuxing */
>  	mxs_i2c_reset(i2c);
> -	writel(MXS_I2C_QUEUECTRL_PIO_QUEUE_MODE,
> -			i2c->regs + MXS_I2C_QUEUECTRL_SET);
>  
>  	adap = &i2c->adapter;
>  	strlcpy(adap->name, "MXS I2C adapter", sizeof(adap->name));
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
