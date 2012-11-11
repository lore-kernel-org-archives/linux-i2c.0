From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] i2c/mux: (pinctrl) Fix probe error path
Date: Sun, 11 Nov 2012 10:28:58 +0100
Message-ID: <20121111102858.5688a460@endymion.delvare>
References: <1352604142-7271-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352604142-7271-1-git-send-email-linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Sat, 10 Nov 2012 19:22:22 -0800, Guenter Roeck wrote:
> When allocating the memory for i2c busses, the code checked the wrong
> variable and thus never detected if there was a memory error.
> 
> Signed-off-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
> ---
>  drivers/i2c/muxes/i2c-mux-pinctrl.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pinctrl.c b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> index 5f097f3..7fa5b24 100644
> --- a/drivers/i2c/muxes/i2c-mux-pinctrl.c
> +++ b/drivers/i2c/muxes/i2c-mux-pinctrl.c
> @@ -169,7 +169,7 @@ static int __devinit i2c_mux_pinctrl_probe(struct platform_device *pdev)
>  	mux->busses = devm_kzalloc(&pdev->dev,
>  				   sizeof(mux->busses) * mux->pdata->bus_count,
>  				   GFP_KERNEL);
> -	if (!mux->states) {
> +	if (!mux->busses) {
>  		dev_err(&pdev->dev, "Cannot allocate busses\n");
>  		ret = -ENOMEM;
>  		goto err;

Good catch. Applied, thanks. Will send to stable too.

-- 
Jean Delvare
