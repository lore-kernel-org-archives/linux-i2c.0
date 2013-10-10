From: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-mux-gpio: test if the gpio can sleep
Date: Thu, 10 Oct 2013 10:57:17 +0200
Message-ID: <52566BED.9010105@nsn.com>
References: <525667C4.3080309@nsn.com> <52566971.5020700@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52566971.5020700-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 10.10.2013 10:46, ext Lars-Peter Clausen wrote:
> On 10/10/2013 10:39 AM, Ionut Nicu wrote:
>> Some gpio chips may have get/set operations that
>> can sleep. For this type of chips we must use the
>> _cansleep() version of gpio_set_value.
>>
>> Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
>> ---
>>  drivers/i2c/muxes/i2c-mux-gpio.c |   11 ++++++++---
>>  1 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
>> index a764da7..b5f17ef 100644
>> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
>> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
>> @@ -27,11 +27,16 @@ struct gpiomux {
>>  
>>  static void i2c_mux_gpio_set(const struct gpiomux *mux, unsigned val)
>>  {
>> +	unsigned gpio;
>>  	int i;
>>  
>> -	for (i = 0; i < mux->data.n_gpios; i++)
>> -		gpio_set_value(mux->gpio_base + mux->data.gpios[i],
>> -			       val & (1 << i));
>> +	for (i = 0; i < mux->data.n_gpios; i++) {
>> +		gpio = mux->gpio_base + mux->data.gpios[i];
>> +		if (gpio_cansleep(gpio))
>> +			gpio_set_value_cansleep(gpio, val & (1 << i));
>> +		else
>> +			gpio_set_value(gpio, val & (1 << i));
> 
> The proper way to do this is just always use the _cansleep() version.
> gpio_set_value() only works for chips which do not sleep,
> gpio_set_value_cansleep() works for both those who do sleep and those who do
> not.
> 

Ok, then I will re-work the patch to do just that. Thanks!
