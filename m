From: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-mux-gpio: eliminate i2c channel order assumptions
Date: Fri, 11 Oct 2013 10:46:00 +0200
Message-ID: <5257BAC8.7060505@nsn.com>
References: <525667CA.3030504@nsn.com> <525682B5.20102@nsn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <525682B5.20102-OYasijW0DpE@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
Cc: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi,

On 10.10.2013 12:34, Alexander Sverdlin wrote:
> Hi!
> 
> On 10/10/2013 10:39 AM, Ionut Nicu wrote:
>> The i2c-mux driver uses the chan_id parameter provided
>> in i2c_add_mux_adapter as a parameter to the select
>> and deselect callbacks while the i2c-mux-gpio driver
>> uses the chan_id as an index in the mux->data.values
>> array.
>>
>> A simple example of where this doesn't work is when we
>> have a device tree like this:
>>
>> i2cmux {
>> 	i2c@1 {
>> 		reg = <1>;
>> 		...
>> 	};
>>
>> 	i2c@0 {
>> 		reg = <0>;
>> 		...
>> 	};
>> };
>>
>> The mux->data.values array will be { 1, 0 }, but when
>> the i2-mux driver will try to select channel 0, the
>> i2c-mux-gpio driver will actually use values[0], hence 1
>> as the gpio selection value.
> 
> The patch itself is correct, but the description is not precise,
> I suppose... i2c-mux-gpio is consistent inside itself, it will
> receive for every child adapter the value it has configured.
> The problem happens inside i2c-mux.c, i2c_add_mux_adapter():
> 
>                	for_each_child_of_node(mux_dev->of_node, child) {
>                        	ret = of_property_read_u32(child, "reg", &reg);
>                        	if (ret)
>                                	continue;
>                        	if (chan_id == reg) {
>                                	priv->adap.dev.of_node = child;
> 
> Which means, i2c-mux-gpio MUST pass reg, not its logical index inside
> array. Otherwise node will not be correctly assigned and i2c-mux will
> have problems selecting right adapter for the multiplexed devices.
> 
>> Signed-off-by: Ionut Nicu <ioan.nicu.ext-OYasijW0DpE@public.gmane.org>
> 
> So, for the code itself
> 
> Acked-by: Alexander Sverdlin <alexander.sverdlin-OYasijW0DpE@public.gmane.org>
> 

You are right, the patch description is not so good. I will try to change
it so it's clearer for everyone what I'm trying to fix here and after that
I will re-submit the series.

>> ---
>>  drivers/i2c/muxes/i2c-mux-gpio.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
>> index b5f17ef..3505d0e 100644
>> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
>> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
>> @@ -43,7 +43,7 @@ static int i2c_mux_gpio_select(struct i2c_adapter *adap, void *data, u32 chan)
>>  {
>>  	struct gpiomux *mux = data;
>>  
>> -	i2c_mux_gpio_set(mux, mux->data.values[chan]);
>> +	i2c_mux_gpio_set(mux, chan);
>>  
>>  	return 0;
>>  }
>> @@ -233,7 +233,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
>>  		unsigned int class = mux->data.classes ? mux->data.classes[i] : 0;
>>  
>>  		mux->adap[i] = i2c_add_mux_adapter(parent, &pdev->dev, mux, nr,
>> -						   i, class,
>> +						   mux->data.values[i], class,
>>  						   i2c_mux_gpio_select, deselect);
>>  		if (!mux->adap[i]) {
>>  			ret = -ENODEV;
>>
> 
