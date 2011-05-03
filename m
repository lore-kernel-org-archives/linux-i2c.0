From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [REPOST PATCH] i2c: pxa2xx: remove ifdef CONFIG_OF
Date: Tue, 3 May 2011 07:58:26 -0600
Message-ID: <20110503135826.GA4966@ponder.secretlab.ca>
References: <20110411083447.GB4018@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110411083447.GB4018-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Apr 11, 2011 at 10:34:47AM +0200, Sebastian Andrzej Siewior wrote:
> Since commit c9e358d ("driver-core: remove conditionals around
> devicetree pointers") there is no need for CONFIG_OF around of_node and
> of_match_table. Grant removed this ifdefs from all driver which were in
> tree at the time, this one was merged later.
> 
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Hey Ben,

Can you pick up this patch?

Thanks,
g.

> ---
>  drivers/i2c/busses/i2c-pxa.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index f59224a..91c4c15 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1138,9 +1138,7 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  
>  	i2c->adap.algo_data = i2c;
>  	i2c->adap.dev.parent = &dev->dev;
> -#ifdef CONFIG_OF
>  	i2c->adap.dev.of_node = dev->dev.of_node;
> -#endif
>  
>  	if (i2c_type == REGS_CE4100)
>  		ret = i2c_add_adapter(&i2c->adap);
> -- 
> 1.7.4
> 
