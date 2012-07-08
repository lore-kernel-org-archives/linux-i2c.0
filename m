From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 14/15] i2c: iop3xx: use standard gpiolib functions
Date: Sun, 08 Jul 2012 09:29:28 -0500
Message-ID: <4FF99948.9040008@gmail.com>
References: <1341600040-30993-1-git-send-email-robherring2@gmail.com> <1341600040-30993-15-git-send-email-robherring2@gmail.com> <20120708112903.GB18362@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120708112903.GB18362-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 07/08/2012 06:29 AM, Wolfram Sang wrote:
> On Fri, Jul 06, 2012 at 01:40:39PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>>
>> Instead of using the custom iop3xx gpio functions, use the gpiolib
>> variants. This should be functionally the same since the gpiolib
>> just calls the iop3xx gpio functions. This is needed in preparation
>> of removing iop3xx mach/io.h headers.
>>
>> Signed-off-by: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
>> Cc: "Jean Delvare (PC drivers, core)" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
>> Cc: "Ben Dooks (embedded platforms)" <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
>> Cc: "Wolfram Sang (embedded platforms)" <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> 
> Is this dependent on another patch from this series? Or can this go
> via the I2C tree? I am fine with just acking this one, but the
> whitespace removal should better go via I2C I think.

They can go in via i2c tree. The rest probably won't make 3.6.

Rob

> 
> Thanks,
> 
>    Wolfram
> 
>> ---
>>  drivers/i2c/busses/i2c-iop3xx.c |    9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-iop3xx.c b/drivers/i2c/busses/i2c-iop3xx.c
>> index 567d873..2f99613 100644
>> --- a/drivers/i2c/busses/i2c-iop3xx.c
>> +++ b/drivers/i2c/busses/i2c-iop3xx.c
>> @@ -39,6 +39,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/i2c.h>
>>  #include <linux/io.h>
>> +#include <linux/gpio.h>
>>  
>>  #include "i2c-iop3xx.h"
>>  
>> @@ -78,11 +79,11 @@ iop3xx_i2c_enable(struct i2c_algo_iop3xx_data *iop3xx_adap)
>>  	 */
>>  #if defined(CONFIG_ARCH_IOP32X) || defined(CONFIG_ARCH_IOP33X)
>>  	if (iop3xx_adap->id == 0) {
>> -		gpio_line_set(IOP3XX_GPIO_LINE(7), GPIO_LOW);
>> -		gpio_line_set(IOP3XX_GPIO_LINE(6), GPIO_LOW);
>> +		gpio_set_value(7, 0);
>> +		gpio_set_value(6, 0);
>>  	} else {
>> -		gpio_line_set(IOP3XX_GPIO_LINE(5), GPIO_LOW);
>> -		gpio_line_set(IOP3XX_GPIO_LINE(4), GPIO_LOW);
>> +		gpio_set_value(5, 0);
>> +		gpio_set_value(4, 0);
>>  	}
>>  #endif
>>  	/* NB SR bits not same position as CR IE bits :-( */
>> -- 
>> 1.7.9.5
>>
> 
