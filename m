From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Thu, 24 Sep 2015 19:32:34 +0200
Message-ID: <560433B2.6040508@osg.samsung.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
 <55FAE058.7080504@osg.samsung.com> <20150920041528.GA3039@x1>
 <5603A881.2010300@osg.samsung.com> <20150924165807.GA27197@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:39063 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755653AbbIXRck (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Sep 2015 13:32:40 -0400
In-Reply-To: <20150924165807.GA27197@x1>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Kieran Bingham <kieranbingham@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org

Hello Lee,

On 09/24/2015 06:58 PM, Lee Jones wrote:

[snip]

>>
>>> Drivers will know if they either only supply an I2C or OF table, so
>>> they will know which call to use in order to obtain their
>>
>> Yes but that is not true for drivers that support both OF and legacy board
>> files. For those drivers, there will be a lot of boiler plate code duplicated
>> that would look something like:
>>
>>      unsigned long data;
>>      struct of_device_id *match;
>>      struct i2c_devicd_id *id;
>>
>>      if (i2c->dev.of_node) {
>>             match = i2c_of_match_device(of_match_table, i2c);
>> 	    if (!match)
>> 	           return -EINVAL;
>>
>>             data = (unsigned long)match->data;
>>      } else {
>>             id = i2c_match_id(id_table, i2c);
>> 	    if (!id)
>> 	           return -EINVAL;
>>
>>             data = id->driver_data;
>>      }
>>
>> While it would be nice to have something like:
>>
>>     data = i2c_get_data(i2c);
>>
>> and let the core handle which table should be looked up depending on
>> which mechanism was used to register the i2c device (legacy or OF).
> 
> I'm fine with a new API for this stuff.  I'm even happy to go ahead
> and code it up, but it's important to note that this is work which
> should be based on this set and not a blocker for this set to be
> accepted.
>

I didn't mean this should be a blocker and yes can be done as a follow up.
 
>>> .driver_data|.data. attributes.  We can generify the call if you think
>>> that makes things easier, but I don't see a need for it ATM.
>>>
>>
>> As I explained above, it will make easier for drivers but I raised the
>> point to discuss if the table data should be looked up by the driver
>> or if the core should get it and pass to the probe() function as it is
>> made right now for the I2C device ID table. i.e:
>>
>> static int foo_i2c_probe(struct i2c_client *i2c, const void *data)
>>
>> If the correct approach is the former, then this series is the right
>> direction and as you said a generic match function can be added later.
>>
>> But if the correct approach is the latter, then this series is not
>> the right direction and a different approach is needed. I don't have
>> a strong opinion but wanted to mention that we have two options here.
> 
> The correct approach is the former.  One of the aims of this set was
> to bring the I2C .probe() call-back more into line with the majority
> of the other .probe() calls in the kernel i.e. with only a single
> parameter.  I'm really not a fan of passing some random void pointer
> in.  Using a look-up call to fetch ACPI/OF/I2C/etc data is the current
> norm and is a very viable option.
>

Ok, as I said I don't have a strong opinion and you are right that this
set will make I2C to be more aligned with other subsystems (i.e: SPI that
the I2C implementation is very similar to).

> Wolfram, please (finally :D) take this set.
>

Indeed :)

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
