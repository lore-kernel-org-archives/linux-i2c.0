From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] i2c: i2c-imx: Fix format warning for dev_dbg
Date: Wed, 06 Aug 2014 13:23:45 +0900
Message-ID: <002801cfb12e$36620840$a32618c0$%han@samsung.com>
References: <1407296708-12563-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1407296708-12563-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Content-language: ko
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Xiubo Li' <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday, August 06, 2014 12:45 PM, Xiubo Li wrote:

The subject of the commit looks too general.
How about the following?

i2c: i2c-imx: Use printf extension %pR for struct resource

Best regards,
Jingoo Han

> 
> drivers/i2c/busses/i2c-imx.c: In function i2c_imx_probe()
> drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
> of type unsigned int, but argument 4 has type resource_size_t [-Wformat=]
>   dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
>   ^
> drivers/i2c/busses/i2c-imx.c:689:2: warning: format 0x%x expects argument
> of type unsigned int, but argument 5 has type resource_size_t [-Wformat=]
> 
> drivers/i2c/busses/i2c-imx.c:691:2: warning: format %d expects argument
> of type int, but argument 4 has type resource_size_t [-Wformat=]
>   dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x\n",
>   ^
> drivers/i2c/busses/i2c-imx.c:691:2: warning: format 0x%x expects argument
> of type unsigned int, but argument 5 has type resource_size_t [-Wformat=]
> 
> Signed-off-by: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
> 
> Change in v2:
> - Follow Joe Perches's advice.
> 
> 
> 
> 
> 
>  drivers/i2c/busses/i2c-imx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 1d7efa3..b8a9543 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -686,10 +686,7 @@ static int i2c_imx_probe(struct platform_device *pdev)
>  	clk_disable_unprepare(i2c_imx->clk);
> 
>  	dev_dbg(&i2c_imx->adapter.dev, "claimed irq %d\n", irq);
> -	dev_dbg(&i2c_imx->adapter.dev, "device resources from 0x%x to 0x%x\n",
> -		res->start, res->end);
> -	dev_dbg(&i2c_imx->adapter.dev, "allocated %d bytes at 0x%x\n",
> -		resource_size(res), res->start);
> +	dev_dbg(&i2c_imx->adapter.dev, "device resources: %pR\n", res);
>  	dev_dbg(&i2c_imx->adapter.dev, "adapter name: \"%s\"\n",
>  		i2c_imx->adapter.name);
>  	dev_info(&i2c_imx->adapter.dev, "IMX I2C adapter registered\n");
> --
> 1.8.5
