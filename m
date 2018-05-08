From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] i2c-mux-pca954x: Force reset on probe if available
Date: Tue, 8 May 2018 10:06:21 +0200
Message-ID: <350e9638-1127-c0e5-290b-9d04725c1b8e@topic.nl>
References: <1525174932-8865-1-git-send-email-mike.looijmans@topic.nl>
 <bc56d669-b02f-a017-844d-e095bbbcb7cd@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bc56d669-b02f-a017-844d-e095bbbcb7cd@axentia.se>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

﻿On 08-05-18 08:36, Peter Rosin wrote:
> On 2018-05-01 13:42, Mike Looijmans wrote:
>> Instead of just hogging the reset GPIO into deactivated state, activate and
>> then de-activate the reset. This allows for better recovery if the CPU was
>> reset halfway through an I2C transaction for example.
> 
> I can't see any problems with this, and a reset at load time can certainly
> be a benefit. Some questions below though...
> 
> Cheers,
> Peter
> 
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   drivers/i2c/muxes/i2c-mux-pca954x.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> index 09bafd3..13e10d0 100644
>> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
>> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
>> @@ -36,6 +36,7 @@
>>    */
>>   
>>   #include <linux/device.h>
>> +#include <linux/delay.h>
>>   #include <linux/gpio/consumer.h>
>>   #include <linux/i2c.h>
>>   #include <linux/i2c-mux.h>
>> @@ -389,10 +390,17 @@ static int pca954x_probe(struct i2c_client *client,
>>   	i2c_set_clientdata(client, muxc);
>>   	data->client = client;
>>   
>> -	/* Get the mux out of reset if a reset GPIO is specified. */
>> -	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
>> +	/* Reset the mux if a reset GPIO is specified. */
>> +	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
>>   	if (IS_ERR(gpio))
>>   		return PTR_ERR(gpio);
>> +	if (gpio) {
>> +		/* Datasheet specifies a 4 ns reset-low time */
>> +		udelay(1);
> 
> ndelay(4) ?
> 

I have several reasons for making it much much longer:
- A true 4ns pulse might not make it through the GPIO controller (on some 
chips, the GPIO controller runs at 1/10th of the CPU speed or even less)
- Board designers tend to treat RESET signals as "DC", so a 250MHz pulse might 
not make it through. There may be level converters and open-drain drives in 
the signal path as well.
- I've only looked it op on a few chips, others may have different values

I think best is to just remove the comment line, it doesn't really help.

>> +		gpiod_set_value_cansleep(gpio, 0);
>> +		/* Datasheet specifies a 500 ns reset recovery time */
>> +		udelay(1);
> 
> ndelay(500) ?

Similar reasons as above.

> 
>> +	}
>>   
>>   	match = of_match_device(of_match_ptr(pca954x_of_match), &client->dev);
>>   	if (match)
>>
> 



Kind regards,

Mike Looijmans
System Expert

TOPIC Products
Materiaalweg 4, NL-5681 RJ Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail
