From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] sh: i2c-sh7760: Replase from ctrl_* to __raw_*
Date: Mon, 25 Oct 2010 02:30:29 +0100
Message-ID: <20101025013029.GE21564@trinity.fluff.org>
References: <1287909466-16898-1-git-send-email-iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287909466-16898-1-git-send-email-iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 24, 2010 at 05:37:46PM +0900, Nobuhiro Iwamatsu wrote:
> ctrl_* is deprecated. We should to use __raw_*.

Given iobase is ioremap() returned, there should be an explicit reason
for using __raw_xxx() instead of read/writel().
 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu-+mkmVskJBflAfugRpC6u6w@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-sh7760.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sh7760.c b/drivers/i2c/busses/i2c-sh7760.c
> index 4f93da3..3cad8fe 100644
> --- a/drivers/i2c/busses/i2c-sh7760.c
> +++ b/drivers/i2c/busses/i2c-sh7760.c
> @@ -101,12 +101,12 @@ struct cami2c {
>  
>  static inline void OUT32(struct cami2c *cam, int reg, unsigned long val)
>  {
> -	ctrl_outl(val, (unsigned long)cam->iobase + reg);
> +	__raw_writel(val, (unsigned long)cam->iobase + reg);
>  }
>  
>  static inline unsigned long IN32(struct cami2c *cam, int reg)
>  {
> -	return ctrl_inl((unsigned long)cam->iobase + reg);
> +	return __raw_readl((unsigned long)cam->iobase + reg);
>  }
>  
>  static irqreturn_t sh7760_i2c_irq(int irq, void *ptr)
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
