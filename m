From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 04/17] i2c: i2c-at91: deprecate class based instantiation
Date: Tue, 11 Feb 2014 14:33:39 +0100
Message-ID: <20140211133338.GB1114@ldesroches-Latitude-E6320>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
 <1392026654-5343-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392026654-5343-5-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Feb 10, 2014 at 11:03:58AM +0100, Wolfram Sang wrote:
> Warn users that class based instantiation is going away soon in favour
> of more robust probing and faster bootup times.
> 
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Acked-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Thanks

> ---
> 
>  drivers/i2c/busses/i2c-at91.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index 8edba9d..4babcdb 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -759,7 +759,7 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
>  	i2c_set_adapdata(&dev->adapter, dev);
>  	dev->adapter.owner = THIS_MODULE;
> -	dev->adapter.class = I2C_CLASS_HWMON;
> +	dev->adapter.class = I2C_CLASS_HWMON | I2C_CLASS_DEPRECATED;
>  	dev->adapter.algo = &at91_twi_algorithm;
>  	dev->adapter.dev.parent = dev->dev;
>  	dev->adapter.nr = pdev->id;
> -- 
> 1.8.5.1
> 
