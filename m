From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCHv5 8/8] mfd: as3722: Rid driver of superfluous I2C device
 ID structure
Date: Tue, 10 May 2016 09:23:19 -0400
Message-ID: <8df98822-22d4-7d03-2b84-6e96e0b6f8af@osg.samsung.com>
References: <1462374888-22888-1-git-send-email-kieran@bingham.xyz>
 <1462374888-22888-9-git-send-email-kieran@bingham.xyz>
 <a34c73e5-afdb-5f2b-0775-4959cb09dbaa@osg.samsung.com>
 <20160510073346.GH19473@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:40376 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbcEJNXi (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Tue, 10 May 2016 09:23:38 -0400
In-Reply-To: <20160510073346.GH19473@dell>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Kieran Bingham <kieran@ksquared.org.uk>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org, sameo@linux.intel.com

Hello Lee,

On 05/10/2016 03:33 AM, Lee Jones wrote:
> On Tue, 10 May 2016, Javier Martinez Canillas wrote:

[snip]

>>>  
>>> -static const struct i2c_device_id as3722_i2c_id[] = {
>>> -	{ "as3722", 0 },
>>> -	{},
>>> -};
>>> -MODULE_DEVICE_TABLE(i2c, as3722_i2c_id);
>>> -
>>
>> Just a note that this can only be made because the driver's Kconfig symbol
>> is bool and not tristate. Since for drivers that can be built as a module,
>> the I2C core always reports a MODALIAS of the form "i2c:as3722" and so the
>> i2c_device_id array and the MODULE_DEVICE_TABLE() are needed even when not
>> used by the driver.
>>
>> As mentioned the change is correct for this driver but I just wanted to
>> point out in case other authors try to do the same change for drivers that
>> can be built as a module and so breaking module auto-loading.
> 
> Sounds like a subsequent patch might be required to fix that use-case
> too.  I'll add it to my TODO. :)
>

Well, the fix is really trivial and I've posted it as an RFC patch a [0] a
long time ago. That is what Kieran and my used to test module autoload with
this patch series.

The problem is that a lot of I2C drivers are relying on how the subsystem
behave (always match using i2c_device_id table and report i2c: modalias)
and so OF drivers don't have an of_device_id table since was not necessary.

So if the RFC patch lands [0], that will break a lot of drivers since after
that, the I2C devices registered via OF will report a of: modalias but will
not have a OF aliases in their modules.

We need a flag day to change the I2C subsystem behaviour and that can only
happen after all the in-tree I2C drivers have proper exported of_device_id.

I posted a patch series almost a year ago [1] trying to fix the I2C drivers
that I could find using a script but then found that removing the I2C table
was not possible also due how the subsystem did the matching. Fortunately
your patch series fixed this :)

So after your series land, I plan to do the same investigation again and
post patches to fix all the remaining I2C drivers so the modalias patch can
finally land and the I2C subsystem report modalias like other subsystems do.

[0]: https://patchwork.ozlabs.org/patch/502201/
[1]: https://lkml.org/lkml/2015/7/30/519

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
