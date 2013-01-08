From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] drivers: i2c: muxes: fix sizeof(ptr)
Date: Tue, 8 Jan 2013 20:32:11 +0100
Message-ID: <20130108203211.6df938ff@endymion.delvare>
References: <1357652409-22907-1-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1357652409-22907-1-git-send-email-laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue,  8 Jan 2013 14:40:09 +0100, Laurent Navet wrote:
> sizeof when applied to a pointer typed expression gives the size of
> the pointer
> 
> The semantic patch that makes this output is available
> in scripts/coccinelle/misc/noderef.cocci.
> 
> More information about semantic patching is available at
> http://coccinelle.lip6.fr/
> 
> Signed-off-by: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-pinctrl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> index 7fa5b24..f958d0f 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -167,7 +167,7 @@ static int __devinit i2c_mux_pinctrl_probe(struct platform_device *pdev)
>  	}
>  
>  	mux->busses = devm_kzalloc(&pdev->dev,
> -				   sizeof(mux->busses) * mux->pdata->bus_count,
> +				   sizeof(*mux->busses) * mux->pdata->bus_count,
>  				   GFP_KERNEL);
>  	if (!mux->busses) {
>  		dev_err(&pdev->dev, "Cannot allocate busses\n");

Good catch.

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

-- 
Jean Delvare
