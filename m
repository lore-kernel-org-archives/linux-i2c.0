From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] [MISC] Add HTC PLD driver
Date: Mon, 7 Dec 2009 14:13:29 +0100
Message-ID: <20091207141329.3dd3411c@hyperion.delvare>
References: <1260083683-13095-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1260083683-13095-1-git-send-email-darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Cory Maccarrone <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Sat,  5 Dec 2009 23:14:43 -0800, Cory Maccarrone wrote:
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index df1f86b..be6109e 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -246,6 +246,17 @@ config EP93XX_PWM
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called ep93xx_pwm.
>  
> +config HTCPLD
> +	tristate "HTC Wizard/Herald CPLD"
> +	depends on I2C=y

I'm curious why your driver wouldn't work when I2C support is modular.

> +	help
> +	  If you say yes here you get support for the supposed CPLD
> +	  found on omap850 HTC devices like the HTC Wizard and HTC Herald.
> +	  This device controls backlight, leds, rumble and also the dpad.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called htcpld.

> (...)
> diff --git a/drivers/misc/htcpld.c b/drivers/misc/htcpld.c
> new file mode 100644
> index 0000000..97a0260
> --- /dev/null
> +++ b/drivers/misc/htcpld.c
> @@ -0,0 +1,204 @@
> (...)
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/timer.h>
> +#include <linux/platform_device.h>

I fail to see why you need to include that one.

> +#include <linux/i2c.h>
> +
> +#include <linux/htcpld.h>
> +
> +#define HTCPLD_ADDR_MAX 16

This define is the sure sign that your driver is badly designed. You
shouldn't have to set any such arbitrary limit...

> (...)
> +static struct i2c_client *htcpld_chip[HTCPLD_ADDR_MAX];

... because you shouldn't have to rely on a global like that in the
first place.

-- 
Jean Delvare
