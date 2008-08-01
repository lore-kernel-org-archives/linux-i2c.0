From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] i2c-pxa: fastmode support
Date: Fri, 01 Aug 2008 11:06:12 +0100
Message-ID: <4892E014.3040208@cam.ac.uk>
References: <4891E0C5.7020009@cam.ac.uk>
	<20080801094257.GK26938@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080801094257.GK26938-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Ben Dooks wrote:
> On Thu, Jul 31, 2008 at 04:56:53PM +0100, Jonathan Cameron wrote:
>> From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
>>
>> Add fast_mode option to i2c_pxa_platform_data and use it to set the ICR_FM bit
>> appropriately when i2c_pxa_reset is called. Parameter called fast_mode rather
>> than frequency as this driver is also used for the i2c_pxa_pwr bus which has
>> different normal and fast frequencies.
>>
>> Signed-off-by: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
>> --
>> This is basically a repost of the original patch with use_pio and fast_mode converted
>> to bit fields as suggested / agreed by Eric Miao and Ben Dooks.
> 
> please ensure your descriptions are wrapped to less than 77 characters
> per line.
Will do, sorry about that bit of carelessness.
  
>>  extern void pxa_set_i2c_info(struct i2c_pxa_platform_data *info);
>> diff -uprN -X a/Documentation/dontdiff a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
>> --- a/drivers/i2c/busses/i2c-pxa.c	2008-07-31 12:02:42.000000000 +0100
>> +++ b/drivers/i2c/busses/i2c-pxa.c	2008-07-31 16:10:43.000000000 +0100
>> @@ -65,7 +65,8 @@ struct pxa_i2c {
>>  	unsigned long		iosize;
>>  
>>  	int			irq;
>> -	int			use_pio;
>> +	int			use_pio:1;
>> +	int			fast_mode:1;
>>  };
> 
> Please use unsigned int for bitfields, and a space between the
> name and the :1 would be nice.
On this point, which is the standard way of doing this?
I'd normally go for a space before the colon, but it appears to be an
open issue from point of view of coding standards(and checkpatch throws a wobbly)

Not something I care about that much either way and I'm guessing by the would be
nice that you don't either. I'll repost the patch without.

Thanks for the comments,
