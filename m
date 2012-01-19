From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH] i2c-davinci: dev->irq is used instead of IRQ_I2C by
	free_irq
Date: Thu, 19 Jan 2012 11:26:36 +0000
Message-ID: <20120119112636.GC8441@trinity.fluff.org>
References: <1326956370-23469-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326956370-23469-1-git-send-email-nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Jan 19, 2012 at 03:59:30PM +0900, Nobuhiro Iwamatsu wrote:
> dev->irq is used in request_irq function, we should use
> dev->irq in free_irq function too.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

Looks sane, will apply.

> ---
>  drivers/i2c/busses/i2c-davinci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
> index a76d85f..79b4bcb 100644
> --- a/drivers/i2c/busses/i2c-davinci.c
> +++ b/drivers/i2c/busses/i2c-davinci.c
> @@ -755,7 +755,7 @@ static int davinci_i2c_remove(struct platform_device *pdev)
>  	dev->clk = NULL;
>  
>  	davinci_i2c_write_reg(dev, DAVINCI_I2C_MDR_REG, 0);
> -	free_irq(IRQ_I2C, dev);
> +	free_irq(dev->irq, dev);
>  	iounmap(dev->base);
>  	kfree(dev);
>  
> -- 
> 1.7.7.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Ben Dooks, ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
