From: Darius <augulis.darius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V4] I2C bus driver for IMX
Date: Thu, 15 May 2008 10:55:30 +0300
Message-ID: <g0gqiq$21q$1@ger.gmane.org>
References: <g0c44d$2ji$1@ger.gmane.org> <20080514213214.GB16881@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080514213214.GB16881-elnMNo+KYs3pIgCt6eIbzw@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Cc: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> do you really need to invent a new debugging type here? why not use
> dev_dbg() to do the work, and ensure that your debug output is also
> tagged with the device-id of the device it is being done for.
> 

ok, there was some problems using dev_dbg(), but I'll change it.


> this is wrapping, how about not indenting. I do not belive yoy need to
> use __init in the forward decleration of these functions.

ok, changed.


>> +	for (i=0; i<I2C_IMX_TIME_BUSY; i++) {
> 
> spacing in here: for (i = 0; i < I2C_IMX_TIME_BUSY; i++)
> 

what is there wrong with spacing?

> spacing in here, (temp & I2CR_IEN) ? 1 : 0

I really should add dummy spaces...?

> 
> given the amount of times these get used, an inline function would
> have made it easier to write this.

yes, now I removed it form most places, because it was not very useful 
debug info. Only in ISR is leaved.


>> +
>> +	print_dbg("I2C: <i2c_imx_set_clk>\n");
>> +	sysclk = imx_get_system_clk ();
>> +	hclk = imx_get_hclk();
>> +	desired_div = hclk / rate;
> 
> really, is there not a decent clk_xxx() API support to get the
> system and HCLK values?
> 

there are two API functions to get SYSCLK and HCLK: imx_get_system_clk 
(); and imx_get_hclk();
And they are used there. Where is a problem?


>> +	if (desired_div & 0x01)
>> +		desired_div++;
>> +	if (desired_div < 22)
>> +		desired_div = 22;
>> +	if (desired_div > 3840)
>> +		desired_div = 3840;
>> +	for (i=0; i<50; i++) {
> 
> ARRAY_SIZE() is applicable here.
> 

ok, changed.

>> +
>> +	/* setup bus to read data */
>> +	temp = readb(i2c_imx->base + IMX_I2C_I2CR);
>> +	temp &= ~I2CR_MTX;
>> +	if (msgs->len-1)
>> +	temp &= ~I2CR_TXAK;
> 
> indentation here.. completely unreadable.

strange, because only one 'tab' symbol used. For me and others all seems 
  ok.

>> +		if (i==(msgs->len-1)) {
>> +			print_dbg("I2C: <i2c_imx_read> clear MSTA\n");
>> +	    		temp = readb(i2c_imx->base + IMX_I2C_I2CR);
>> +	    		temp &= ~I2CR_MSTA;
>> +	    		writeb(temp, i2c_imx->base + IMX_I2C_I2CR);
>> +		}
> 
> no line break needed

where do you see line break?

> keeping a pointer to the current message would have been more
> efficient here, ie:
> 
> 	ptr = msgs;
> 	for (i = 0; i < num; i++, ptr++) {
> 		....
> 	}

what is meaning of this pointer? there I need only count messages, 
nothing else...

> 
> use dev_err() here, and some line spacing wouldn't go amiss either.

ok. I'll change all debug prints.

>> +	res_size = (res->end) - (res->start) + 1;
> 
> are the brackets necessary?

maybe it is strange, but, for example, if I remove brakets from there 
(first parameter):
writeb(((msgs->addr<<1)|0x01), i2c_imx->base + IMX_I2C_I2DR);
address is sent without LSB bit cleared. Therefore I've added brakets. I 
think it does not make damage:)


> you've miseed the MODULE_ALIAS() for the platform device.
> 

ok, added.

> 
> yeurk, put these in a seperate header file, or place them near
> the driver. The "One Big Register File" is horrible, and hopefully
> is going the same way as the Dodo.
> 

please, read this:
news://news.gmane.org:119/c166aa9f0803140300n75f6790enee3f28bdebeba945-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org
(03/14/2008 12:00 PM post from Andrew Dyer)

seems, everybody has her own opinion. Is there somebody one, who can say 
how that should be? Because I have already two times changed that... I'm 
only beginner, so ambiguous comments are very unwanted...  As I know, 
Jean Delvare is responsible for I2C drivers. So, his word is welcome:)


_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
