From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH RFC 1/4] i2c: at91: segregate master mode specific code
 from probe and init func
Date: Tue, 31 Oct 2017 16:03:04 +0100
Message-ID: <20171031150304.nxizgpxhpn3mg4iw@rfolt0960.corp.atmel.com>
References: <cover.1509112910.git.me@jue.yt>
 <faf55447a1c9b72edb482bcb4fea1b1de3d50180.1509112910.git.me@jue.yt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <faf55447a1c9b72edb482bcb4fea1b1de3d50180.1509112910.git.me@jue.yt>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Fitschen <me@jue.yt>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Oct 27, 2017 at 05:11:20PM +0200, Juergen Fitschen wrote:
> In order to implement slave mode support for the at91 hardware we have to
> segregate all master mode specific function parts from the general parts.
> The upcoming slave mode patch will call its sepcific probe resp. init
> function instead of the master mode functions after the shared general
> code has been executed.
> 
> This concept has been influenced by the i2c-designware driver.
> 
> Signed-off-by: Juergen Fitschen <me@jue.yt>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/i2c/busses/i2c-at91.c | 90 ++++++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index bfd1fdf..73b6582 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -174,10 +174,8 @@ static void at91_twi_irq_restore(struct at91_twi_dev *dev)
>  	at91_twi_write(dev, AT91_TWI_IER, dev->imr);
>  }
>  
> -static void at91_init_twi_bus(struct at91_twi_dev *dev)
> +static void at91_init_twi_bus_master(struct at91_twi_dev *dev)
>  {
> -	at91_disable_twi_interrupts(dev);
> -	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
>  	/* FIFO should be enabled immediately after the software reset */
>  	if (dev->fifo_size)
>  		at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_FIFOEN);
> @@ -186,6 +184,14 @@ static void at91_init_twi_bus(struct at91_twi_dev *dev)
>  	at91_twi_write(dev, AT91_TWI_CWGR, dev->twi_cwgr_reg);
>  }
>  
> +static void at91_init_twi_bus(struct at91_twi_dev *dev)
> +{
> +	at91_disable_twi_interrupts(dev);
> +	at91_twi_write(dev, AT91_TWI_CR, AT91_TWI_SWRST);
> +
> +	at91_init_twi_bus_master(dev);
> +}
> +
>  /*
>   * Calculate symmetric clock as stated in datasheet:
>   * twi_clk = F_MAIN / (2 * (cdiv * (1 << ckdiv) + offset))
> @@ -1038,18 +1044,56 @@ static struct at91_twi_pdata *at91_twi_get_driver_data(
>  	return (struct at91_twi_pdata *) platform_get_device_id(pdev)->driver_data;
>  }
>  
> +static int at91_twi_probe_master(struct platform_device *pdev,
> +				 u32 phy_addr, struct at91_twi_dev *dev)
> +{
> +	int rc;
> +	u32 bus_clk_rate;
> +
> +	init_completion(&dev->cmd_complete);
> +
> +	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt, 0,
> +			      dev_name(dev->dev), dev);
> +	if (rc) {
> +		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
> +		return rc;
> +	}
> +
> +	if (dev->dev->of_node) {
> +		rc = at91_twi_configure_dma(dev, phy_addr);
> +		if (rc == -EPROBE_DEFER)
> +			return rc;
> +	}
> +
> +	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
> +				  &dev->fifo_size)) {
> +		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
> +	}
> +
> +	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
> +				  &bus_clk_rate);
> +	if (rc)
> +		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
> +
> +	at91_calc_twi_clock(dev, bus_clk_rate);
> +
> +	dev->adapter.algo = &at91_twi_algorithm;
> +	dev->adapter.quirks = &at91_twi_quirks;
> +
> +	return 0;
> +}
> +
>  static int at91_twi_probe(struct platform_device *pdev)
>  {
>  	struct at91_twi_dev *dev;
>  	struct resource *mem;
>  	int rc;
>  	u32 phy_addr;
> -	u32 bus_clk_rate;
>  
>  	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
>  		return -ENOMEM;
> -	init_completion(&dev->cmd_complete);
> +
>  	dev->dev = &pdev->dev;
>  
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1069,13 +1113,6 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	if (dev->irq < 0)
>  		return dev->irq;
>  
> -	rc = devm_request_irq(&pdev->dev, dev->irq, atmel_twi_interrupt, 0,
> -			 dev_name(dev->dev), dev);
> -	if (rc) {
> -		dev_err(dev->dev, "Cannot get irq %d: %d\n", dev->irq, rc);
> -		return rc;
> -	}
> -
>  	platform_set_drvdata(pdev, dev);
>  
>  	dev->clk = devm_clk_get(dev->dev, NULL);
> @@ -1087,38 +1124,21 @@ static int at91_twi_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> -	if (dev->dev->of_node) {
> -		rc = at91_twi_configure_dma(dev, phy_addr);
> -		if (rc == -EPROBE_DEFER) {
> -			clk_disable_unprepare(dev->clk);
> -			return rc;
> -		}
> -	}
> -
> -	if (!of_property_read_u32(pdev->dev.of_node, "atmel,fifo-size",
> -				  &dev->fifo_size)) {
> -		dev_info(dev->dev, "Using FIFO (%u data)\n", dev->fifo_size);
> -	}
> -
> -	rc = of_property_read_u32(dev->dev->of_node, "clock-frequency",
> -			&bus_clk_rate);
> -	if (rc)
> -		bus_clk_rate = DEFAULT_TWI_CLK_HZ;
> -
> -	at91_calc_twi_clock(dev, bus_clk_rate);
> -	at91_init_twi_bus(dev);
> -
>  	snprintf(dev->adapter.name, sizeof(dev->adapter.name), "AT91");
>  	i2c_set_adapdata(&dev->adapter, dev);
>  	dev->adapter.owner = THIS_MODULE;
>  	dev->adapter.class = I2C_CLASS_DEPRECATED;
> -	dev->adapter.algo = &at91_twi_algorithm;
> -	dev->adapter.quirks = &at91_twi_quirks;
>  	dev->adapter.dev.parent = dev->dev;
>  	dev->adapter.nr = pdev->id;
>  	dev->adapter.timeout = AT91_I2C_TIMEOUT;
>  	dev->adapter.dev.of_node = pdev->dev.of_node;
>  
> +	rc = at91_twi_probe_master(pdev, phy_addr, dev);
> +	if (rc)
> +		return rc;
> +
> +	at91_init_twi_bus(dev);
> +
>  	pm_runtime_set_autosuspend_delay(dev->dev, AUTOSUSPEND_TIMEOUT);
>  	pm_runtime_use_autosuspend(dev->dev);
>  	pm_runtime_set_active(dev->dev);
> -- 
> 2.7.4
> 
