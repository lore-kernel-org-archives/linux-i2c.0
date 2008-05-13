From: "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] [I2C] add PCA9543 chip driver
Date: Tue, 13 May 2008 12:54:21 +0100
Message-ID: <8A42379416420646B9BFAC9682273B6D015F5379@limkexm3.ad.analog.com>
References: <1210586847-8955-1-git-send-email-cooloney@kernel.org>
	<1210586847-8955-3-git-send-email-cooloney@kernel.org>
	<48283873.5090709@movial.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <48283873.5090709-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Riku Voipio <riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org>, Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org



>-----Original Message-----
>From: Riku Voipio [mailto:riku.voipio-WgUW+8SLYMv1KXRcyAk9cg@public.gmane.org]
>Sent: Montag, 12. Mai 2008 14:31
>To: Bryan Wu
>Cc: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org; khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org; Michael Hennerich
>Subject: Re: [i2c] [PATCH 2/2] [I2C] add PCA9543 chip driver
>
>Bryan Wu wrote:
>> From: Michael Hennerich
>> --- /dev/null
>> +++ b/drivers/i2c/chips/pca9543.c
>> @@ -0,0 +1,212 @@
>> +/*
>> +    pca9543.c - Part of lm_sensors, Linux kernel modules for
hardware
>> +             monitoring
>>
>Not a sensor chip..
>> +/* A few notes about the PCA9543:
>> +
>> +*   The PCA9543 is a bi-directional translating switch, controlled
by
>the
>> +    I2C bus. The SCL/SDA upstream pair fans out to two downstream
>> +    pairs, or channels. Any individual SCx/SDx channels or
combination
>> +    of channels can be selected, determined by the contents of the
>> +    programmable control register. Two interrupt inputs, INT0 to
INT3,
>> +    one for each of the downstream pairs, are provided. One
interrupt
>> +    output INT, which acts as an AND of the two interrupt inputs, is
>> +    provided.
>> +
>> +*/
>>
>You might want to add a url to the datasheet, rather than
>a copypaste from it. Any description in the driver sould
>> +
>> +/* This is the driver that will be inserted */
>> +static struct i2c_driver pca9543_driver = {
>> +	.driver = {
>> +		.name	= "pca9543",
>> +	},
>> +	.id		= I2C_DRIVERID_PCF8574,
>> +	.attach_adapter	= pca9543_attach_adapter,
>> +	.detach_client	= pca9543_detach_client,
>> +};
>>
>Since the chip is undetectable, and used on embedded platform, I think
you
>should consider a "new-style" driver with .probe/remove instead.
>See i2c/writing-clients
>> +	struct i2c_client *new_client;
>>
>> +	new_client = &data->client;
>> +	i2c_set_clientdata(new_client, data);
>> +	new_client->addr = address;
>> +	new_client->adapter = adapter;
>> +	new_client->driver = &pca9543_driver;
>> +	new_client->flags = 0;
>>
>>
>s/new_client/client/ please.
>> +	/* Now, we would do the remaining detection. But the PCF8574 is
>plainly
>> +	   impossible to detect! Stupid chip. */
>> +
>>
>copypaste from PCF8574 driver? :) Again, consider if the new style
drivers
>would me more useful for your platform.

Yes copypaste from PCF8574 driver. There is not much value in here, we
either send a new patch including your feedback or drop this. 

Best regards,
Michael

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
