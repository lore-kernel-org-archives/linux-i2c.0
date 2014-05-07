From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 10/16] i2c: sh_mobile: remove unnecessary OOM messages
Date: Wed, 07 May 2014 09:22:27 +0200
Message-ID: <1543145.hITqNnqynP@avalon>
References: <018301cf69aa$cb7987d0$626c9770$%han@samsung.com> <018e01cf69ac$a4479600$ecd6c200$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <018e01cf69ac$a4479600$ecd6c200$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Guennadi Liakhovetski' <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: 'Wolfram Sang' <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Jingoo,

Thank you for the patch.

On Wednesday 07 May 2014 13:27:22 Jingoo Han wrote:
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message.
> 
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/i2c/busses/i2c-sh_mobile.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c
> b/drivers/i2c/busses/i2c-sh_mobile.c index 1d79585..fbc13e9 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -665,10 +665,8 @@ static int sh_mobile_i2c_probe(struct platform_device
> *dev) int ret;
> 
>  	pd = kzalloc(sizeof(struct sh_mobile_i2c_data), GFP_KERNEL);
> -	if (pd == NULL) {
> -		dev_err(&dev->dev, "cannot allocate private data\n");
> +	if (pd == NULL)
>  		return -ENOMEM;
> -	}
> 
>  	pd->clk = clk_get(&dev->dev, NULL);
>  	if (IS_ERR(pd->clk)) {

-- 
Regards,

Laurent Pinchart
