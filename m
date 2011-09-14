From: Ben Dooks <ben-i2c-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v2] i2c: Add Device Tree support to versatile-i2c driver
Date: Wed, 14 Sep 2011 22:15:56 +0100
Message-ID: <20110914211556.GB2146@freya.fluff.org>
References: <1315475019-10088-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1315475019-10088-1-git-send-email-pawel.moll-5wv7dgnIgG8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Sep 08, 2011 at 10:43:39AM +0100, Pawel Moll wrote:
> This patch adds Device Tree binding ("arm,versatile-i2c") and
> basic support (bus population) to versatile-i2c driver.

what happens when !CONFIG_OF ?
 
> Cc: Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> Signed-off-by: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-versatile.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
> index 6055601..7bfdf40 100644
> --- a/drivers/i2c/busses/i2c-versatile.c
> +++ b/drivers/i2c/busses/i2c-versatile.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> +#include <linux/of_i2c.h>
>  
>  #define I2C_CONTROL	0x00
>  #define I2C_CONTROLS	0x00
> @@ -99,6 +100,7 @@ static int i2c_versatile_probe(struct platform_device *dev)
>  	strlcpy(i2c->adap.name, "Versatile I2C adapter", sizeof(i2c->adap.name));
>  	i2c->adap.algo_data = &i2c->algo;
>  	i2c->adap.dev.parent = &dev->dev;
> +	i2c->adap.dev.of_node = dev->dev.of_node;
>  	i2c->algo = i2c_versatile_algo;
>  	i2c->algo.data = i2c;
>  
> @@ -111,6 +113,7 @@ static int i2c_versatile_probe(struct platform_device *dev)
>  		ret = i2c_bit_add_bus(&i2c->adap);
>  	if (ret >= 0) {
>  		platform_set_drvdata(dev, i2c);
> +		of_i2c_register_devices(&i2c->adap);
>  		return 0;
>  	}
>  
> @@ -133,12 +136,19 @@ static int i2c_versatile_remove(struct platform_device *dev)
>  	return 0;
>  }
>  
> +static struct of_device_id i2c_versatile_match[] = {
> +	{ .compatible = "arm,versatile-i2c", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, i2c_versatile_match);
> +
>  static struct platform_driver i2c_versatile_driver = {
>  	.probe		= i2c_versatile_probe,
>  	.remove		= i2c_versatile_remove,
>  	.driver		= {
>  		.name	= "versatile-i2c",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = i2c_versatile_match,
>  	},
>  };
>  
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
