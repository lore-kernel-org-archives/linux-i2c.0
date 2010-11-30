From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCHv4] i2c: add generic I2C multiplexer using gpio api
Date: Tue, 30 Nov 2010 17:15:39 +0100
Message-ID: <20101130171539.73e8e799@endymion.delvare>
References: <1291125788-9433-1-git-send-email-peter.korsgaard@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1291125788-9433-1-git-send-email-peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ml.lawnick-Mmb7MZpHnFY@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Peter,

On Tue, 30 Nov 2010 15:03:08 +0100, Peter Korsgaard wrote:
> Add an i2c mux driver providing access to i2c bus segments using a
> hardware MUX sitting on a master bus and controlled through gpio pins.
> 
> E.G. something like:
> 
>   ----------              ----------  Bus segment 1   - - - - -
>  |          | SCL/SDA    |          |-------------- |           |
>  |          |------------|          |
>  |          |            |          | Bus segment 2 |           |
>  |  Linux   | GPIO 1..N  |   MUX    |---------------   Devices
>  |          |------------|          |               |           |
>  |          |            |          | Bus segment M
>  |          |            |          |---------------|           |
>   ----------              ----------                  - - - - -
> 
> SCL/SDA of the master I2C bus is multiplexed to bus segment 1..M
> according to the settings of the GPIO pins 1..N.

I've fixed two remaining minor things myself, and your patch is ready
to be applied now, except for one issue I just noticed. See below.

> (..)
> --- /dev/null
> +++ b/Documentation/i2c/muxes/gpio-i2cmux
> (...)
> +Usage
> +-----
> +
> +gpio-i2cmux uses the platform bus, so you need to provide a struct
> +platform_device with the platform_data pointing to a struct
> +gpio_i2cmux_platform_data with the I2C adapter number of the master
> +bus, the number bus segments to create and the GPIO pins used

"of" got lost in the battle, I've added it back.

> +to control it. See include/linux/gpio-i2cmux.h for details.

> (...)
> --- /dev/null
> +++ b/drivers/i2c/muxes/gpio-i2cmux.c
> (...)
> +	for (i = 0; i < pdata->n_gpios; i++) {
> +		ret = gpio_request(pdata->gpios[i], "gpio-i2cmux");
> +		if (ret)
> +			goto err_request_gpio;
> +		gpio_direction_output(pdata->gpios[i], pdata->idle & (1 << i));

This looks wrong if pdata->idle == GPIO_I2CMUX_NO_IDLE. I think we want
something along the lines of:

	unsigned initial_state;

	initial_state = pdata->idle == GPIO_I2CMUX_NO_IDLE ?
			pdata->values[0] : pdata->idle;

		(...)
		gpio_direction_output(pdata->gpios[i], initial_state & (1 << i));

What do you think? An alternative is to leave the direction
uninitialized and hope it's already OK, but I'm not sure how realistic
this is.

> +	}
> +
> +

Double blank line, I've removed one.

> +	if (pdata->idle != GPIO_I2CMUX_NO_IDLE)
> +		deselect = gpiomux_deselect;

-- 
Jean Delvare
