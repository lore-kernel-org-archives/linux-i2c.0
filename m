From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c-gpio: Add support for deferred probing
Date: Fri, 22 Mar 2013 12:56:21 +0100
Message-ID: <20130322115621.GB24508@the-dreams.de>
References: <20130228120140.127ebb91@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130228120140.127ebb91-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Karol Lewandowski <k.lewandowsk-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

On Thu, Feb 28, 2013 at 12:01:40PM +0100, Jean Delvare wrote:
> GPIOs may not be available immediately when i2c-gpio looks for them.
> Implement support for deferred probing so that probing can be
> attempted again later when GPIO pins are finally available.
> 
> Signed-off-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
> Cc: Haavard Skinnemoen <hskinnemoen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> A little more changes were needed than I initially thought, because we
> want to check the pins before we allocate memory. Otherwise we would
> have a possibly large number of memory allocation and freeing cycles
> until GPIO pins are finally available.
> 
> I wrote this quite some time ago already, but I do not have any system
> to test it. I would appreciate if one or more users of the i2c-gpio
> driver could give it a try and confirm it works as intended, or at
> least doesn't introduce any regression. Thanks.
> 
>  drivers/i2c/busses/i2c-gpio.c |   75 ++++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
> 
> --- linux-3.8-rc2.orig/drivers/i2c/busses/i2c-gpio.c	2013-01-09 22:26:30.031060312 +0100
> +++ linux-3.8-rc2/drivers/i2c/busses/i2c-gpio.c	2013-01-09 22:32:59.950308645 +0100
> @@ -85,23 +85,29 @@ static int i2c_gpio_getscl(void *data)
>  	return gpio_get_value(pdata->scl_pin);
>  }
>  
> -static int of_i2c_gpio_probe(struct device_node *np,
> -			     struct i2c_gpio_platform_data *pdata)
> +static int of_i2c_gpio_get_pins(struct device_node *np,
> +				unsigned int *sda_pin, unsigned int *scl_pin)

GPIOs are expressed via int.

> +	ret = gpio_request(sda_pin, "sda");
> +	if (ret) {
> +		if (ret == -EINVAL)
> +			ret = -EPROBE_DEFER;	/* Try again later */

Would gpio_request_array() make the code simpler?

Thanks,

   Wolfram
