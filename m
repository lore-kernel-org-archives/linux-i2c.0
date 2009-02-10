From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Add static bus numbering support to i2c-versatile
Date: Tue, 10 Feb 2009 14:27:01 +0100
Message-ID: <20090210142701.37bc4717@hyperion.delvare>
References: <20090209203045.0c7a32a4@hyperion.delvare>
	<1234268669.8798.10.camel@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1234268669.8798.10.camel-hhZApKj8DF/YkXV2EHHjLW3o5bpOHsLO@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

> Add static bus numbering support to i2c-versatile
> 
> From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> 
> If dev->id is not -1, the platform code may use static bus numbering
> rather than dynamic. The patch also changes the i2c_versatile_init to a
> subsys_initcall rather than module_init to make sure it is initialised
> before the I2C devices initialisation.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> Cc: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> ---
>  drivers/i2c/busses/i2c-versatile.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
> index 4678bab..fede619 100644
> --- a/drivers/i2c/busses/i2c-versatile.c
> +++ b/drivers/i2c/busses/i2c-versatile.c
> @@ -102,7 +102,13 @@ static int i2c_versatile_probe(struct platform_device *dev)
>  	i2c->algo = i2c_versatile_algo;
>  	i2c->algo.data = i2c;
>  
> -	ret = i2c_bit_add_bus(&i2c->adap);
> +	if (dev->id >= 0) {
> +		/* static bus numbering */
> +		i2c->adap.nr = dev->id;
> +		ret = i2c_bit_add_numbered_bus(&i2c->adap);
> +	} else
> +		/* dynamic bus numbering */
> +		ret = i2c_bit_add_bus(&i2c->adap);
>  	if (ret >= 0) {
>  		platform_set_drvdata(dev, i2c);
>  		return 0;
> @@ -146,7 +152,7 @@ static void __exit i2c_versatile_exit(void)
>  	platform_driver_unregister(&i2c_versatile_driver);
>  }
>  
> -module_init(i2c_versatile_init);
> +subsys_initcall(i2c_versatile_init);
>  module_exit(i2c_versatile_exit);
>  
>  MODULE_DESCRIPTION("ARM Versatile I2C bus driver");

Acked-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Note that i2c-versatile is not under my jurisdiction so you will have
to push this patch through either Ben Dooks or the arm tree.

-- 
Jean Delvare
