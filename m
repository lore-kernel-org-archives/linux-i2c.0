From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: GPIO: Fix probe() error return in gpio driver probes
Date: Sun, 14 Dec 2008 21:33:49 +0000
Message-ID: <20081214213349.GA19483@fluff.org.uk>
References: <20081212152426.745254309@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20081212152426.745254309-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 12, 2008 at 03:24:27PM +0000, Ben Dooks wrote:
> A number of drivers in drivers/gpio return -ENODEV when confronted
> with missing setup parameters such as the platform data. However,
> returning -ENODEV causes the driver layer to silently ignore the
> driver as it assumes the probe did not find anything and was only
> speculative.
> 
> To make life easier to discern why a driver is not being attached,
> change to returning -EINVAL, which is a better description of the
> fact that the driver data was not valid.
> 
> Signed-off-by: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>

Has anyone reveiwed this patch? Are there any comments, or can this
be commited at somepoint (even if it is during the next merge window)?

> Index: linux.git7/drivers/gpio/max7301.c
> ===================================================================
> --- linux.git7.orig/drivers/gpio/max7301.c	2008-12-12 13:35:42.000000000 +0000
> +++ linux.git7/drivers/gpio/max7301.c	2008-12-12 13:36:12.000000000 +0000
> @@ -218,7 +218,7 @@ static int __devinit max7301_probe(struc
>  
>  	pdata = spi->dev.platform_data;
>  	if (!pdata || !pdata->base)
> -		return -ENODEV;
> +		return -EINVAL;
>  
>  	/*
>  	 * bits_per_word cannot be configured in platform data
> Index: linux.git7/drivers/gpio/max732x.c
> ===================================================================
> --- linux.git7.orig/drivers/gpio/max732x.c	2008-12-12 13:36:22.000000000 +0000
> +++ linux.git7/drivers/gpio/max732x.c	2008-12-12 13:36:28.000000000 +0000
> @@ -268,7 +268,7 @@ static int __devinit max732x_probe(struc
>  
>  	pdata = client->dev.platform_data;
>  	if (pdata == NULL)
> -		return -ENODEV;
> +		return -EINVAL;
>  
>  	chip = kzalloc(sizeof(struct max732x_chip), GFP_KERNEL);
>  	if (chip == NULL)
> Index: linux.git7/drivers/gpio/mcp23s08.c
> ===================================================================
> --- linux.git7.orig/drivers/gpio/mcp23s08.c	2008-12-12 14:10:01.000000000 +0000
> +++ linux.git7/drivers/gpio/mcp23s08.c	2008-12-12 14:11:19.000000000 +0000
> @@ -311,7 +311,7 @@ static int mcp23s08_probe(struct spi_dev
>  
>  	pdata = spi->dev.platform_data;
>  	if (!pdata || !gpio_is_valid(pdata->base))
> -		return -ENODEV;
> +		return -EINVAL;
>  
>  	for (addr = 0; addr < 4; addr++) {
>  		if (!pdata->chip[addr].is_present)
> Index: linux.git7/drivers/gpio/pca953x.c
> ===================================================================
> --- linux.git7.orig/drivers/gpio/pca953x.c	2008-12-12 13:33:47.000000000 +0000
> +++ linux.git7/drivers/gpio/pca953x.c	2008-12-12 13:33:55.000000000 +0000
> @@ -201,7 +201,7 @@ static int __devinit pca953x_probe(struc
>  
>  	pdata = client->dev.platform_data;
>  	if (pdata == NULL)
> -		return -ENODEV;
> +		return -EINVAL;
>  
>  	chip = kzalloc(sizeof(struct pca953x_chip), GFP_KERNEL);
>  	if (chip == NULL)
> Index: linux.git7/drivers/gpio/pcf857x.c
> ===================================================================
> --- linux.git7.orig/drivers/gpio/pcf857x.c	2008-12-12 13:34:33.000000000 +0000
> +++ linux.git7/drivers/gpio/pcf857x.c	2008-12-12 13:34:54.000000000 +0000
> @@ -189,7 +189,7 @@ static int pcf857x_probe(struct i2c_clie
>  
>  	pdata = client->dev.platform_data;
>  	if (!pdata)
> -		return -ENODEV;
> +		return -EINVAL;
>  
>  	/* Allocate, initialize, and register this gpio_chip. */
>  	gpio = kzalloc(sizeof *gpio, GFP_KERNEL);
> @@ -249,7 +249,7 @@ static int pcf857x_probe(struct i2c_clie
>  			status = i2c_read_le16(client);
>  
>  	} else
> -		status = -ENODEV;
> +		status = -EINVAL;
>  
>  	if (status < 0)
>  		goto fail;
> 
> -- 
> Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)
> 
>   'a smiley only costs 4 bytes'
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Ben (ben-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
