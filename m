From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RESEND PATCH v4 0/8] i2c: Relax mandatory I2C ID table passing
Date: Thu, 24 Sep 2015 09:38:41 +0200
Message-ID: <5603A881.2010300@osg.samsung.com>
References: <1441972564-9621-1-git-send-email-kieranbingham@gmail.com>
 <55FAE058.7080504@osg.samsung.com> <20150920041528.GA3039@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:39020 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813AbbIXHir (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
	Thu, 24 Sep 2015 03:38:47 -0400
In-Reply-To: <20150920041528.GA3039@x1>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Kieran Bingham <kieranbingham@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Samuel Ortiz <sameo@linux.intel.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, grant.likely@linaro.org

Hello Lee,

On 09/20/2015 06:15 AM, Lee Jones wrote:
> On Thu, 17 Sep 2015, Javier Martinez Canillas wrote:
> 
>> Hello,
>>
>> On 09/11/2015 01:55 PM, Kieran Bingham wrote:
>>> Hi Wolfram,
>>>
>>> I have picked this patchset [0] up from Lee to rebase it, with an aim to
>>> get this series moving again.
>>>
>>> This resend fixes up my SoB's as highlighted by Lee
>>>
>>> A couple of minor issues were resolved in the rebase. As it stood, Javier
>>> proposed [1] to merge this series, and use a follow up series to make sure
>>> that all I2C drivers are using a MODLE_DEVICE_TABLE(of,...)
>>>
>>> I have prepared a Coccinelle patch to work through the bulk of the changes
>>> required for the conversion, which will assist the transition process.
>>>
>>> Once this patch set is accepted, I will commence converting the other
>>> drivers, and submitting with a per subsystem breakdown or simliar to
>>> reduce traffic.
>>>
>>> [0] https://lkml.org/lkml/2014/8/28/283
>>> [1] https://lkml.org/lkml/2014/9/12/496
>>>
>>> Lee's most recent cover-letter (from 12 months ago) follows:
>>>
>>> Hi Wolfram,
>>>
>>> Placing this firmly back on your plate.  I truly hope we don't miss
>>> another merge-window.  This patch-set has the support of some pretty
>>> senior kernel maintainers, so I hope acceptance shouldn't be too
>>> difficult.
>>>
>>> As previously discussed I believe it should be okay for an I2C device
>>> driver _not_ supply an I2C ID table to match to.  The I2C subsystem
>>> should be able to match via other means, such as via OF tables.  The
>>> blocking factor during our previous conversation was to keep
>>> registering via sysfs up and running.  This set does that.
>>>
>>> After thinking more deeply about the problem, it occurred to me that
>>> any I2C device driver which uses the sysfs method and issues an
>>> of_match_device() would also fail their probe().  Bolted on to this
>>> set is a new, more generic way for these devices to match against
>>> either of the I2C/OF tables.
>>>
>>
>> I reviewed this series but wonder if we shouldn't take another approach.
>>
>> There are two reasons why a I2C device ID table is needed even when devices
>> are registered via OF:
>>
>> 1) Export the module aliases from the I2C device ID table so userspace
>>    can auto-load the correct module. This is because i2c_device_uevent
>>    always reports a MODALIAS of the form i2c:<client->name>.
>>
>> 2) Match the I2C client with a I2C device ID so a struct i2c_device_id
>>    is passed to the I2C driver probe() function.
>>
>> As Kieran mentioned I proposed a transition path to fix 1) and posted
>> these patches: https://lkml.org/lkml/2015/7/30/519
>>
>> While this series are fixing 2) by changing the matching logic and adding
>> a second probe callback for drivers that don't need to get a i2c_device_id.
>>
>> Now, the problem I see with this approach is that drivers will likely want
>> to get the struct of_device_id .data field since that is the reason why
>> the I2C core pass a pointer to the struct i2c_device_id in the first place.
>> So drivers could get the .driver_data field and take decisions depending on
>> which device was registered / matched.
>>
>> If the parameter is removed from probe, it means that drivers will have to
>> to open code to get it. This is the same issue that exist with OF today, if
>> a driver needs the .data field from the of_device_id table, is has to do:
>>
>> struct of_device_id *match of_match_node(of_match_table, i2c->dev.of_node);
>>
>> to get the match->data. And a similar helper will be needed to get the
>> struct i2c_device_id since the core won't do it anymore.
>>
>> So what I propose is to change the probe callback signature instead to have
>> a const void *data as the second parameter and the core can either lookup
>> from the I2C device ID table or the OF device ID table depending on which
>> mechanism was used to register the I2C device.
>>
>> That way legacy drivers will only need a I2C device ID table and DT drivers
>> will only need a OF device ID table and drivers won't need to open code the
>> matching logic to get the data stored in the tables.
>>
>> Drivers that support both legacy platform and OF based registration, will
>> have both tables and the I2C core will lookup the data from the right table.
>>
>> An alternative is to keep this series but have a generic function that gets
>> a pointer to a struct i2c_client as parameter and returns the data from the
>> correct table so drivers that don't need that information won't get it at
>> probe time but drivers that need it, can get it easily assisted by the core.
> 
> You mean like i2c_match_id()? ;)
> 

Well, I meant a more generic function that returns const void * or unsigned long
instead of a struct i2c_device_id *

> This patch already takes care of this issue.  Please see:
> 
>   i2c: Export i2c_match_id() for direct use by device drivers
>

I know but as I said that is only used to get a struct i2c_device_id *, a
driver has to call i2c_of_match_device() to get a struct of_device_id *

> Drivers will know if they either only supply an I2C or OF table, so
> they will know which call to use in order to obtain their

Yes but that is not true for drivers that support both OF and legacy board
files. For those drivers, there will be a lot of boiler plate code duplicated
that would look something like:

     unsigned long data;
     struct of_device_id *match;
     struct i2c_devicd_id *id;

     if (i2c->dev.of_node) {
            match = i2c_of_match_device(of_match_table, i2c);
	    if (!match)
	           return -EINVAL;

            data = (unsigned long)match->data;
     } else {
            id = i2c_match_id(id_table, i2c);
	    if (!id)
	           return -EINVAL;

            data = id->driver_data;
     }

While it would be nice to have something like:

    data = i2c_get_data(i2c);

and let the core handle which table should be looked up depending on
which mechanism was used to register the i2c device (legacy or OF).

> .driver_data|.data. attributes.  We can generify the call if you think
> that makes things easier, but I don't see a need for it ATM.
>

As I explained above, it will make easier for drivers but I raised the
point to discuss if the table data should be looked up by the driver
or if the core should get it and pass to the probe() function as it is
made right now for the I2C device ID table. i.e:

static int foo_i2c_probe(struct i2c_client *i2c, const void *data)

If the correct approach is the former, then this series is the right
direction and as you said a generic match function can be added later.

But if the correct approach is the latter, then this series is not
the right direction and a different approach is needed. I don't have
a strong opinion but wanted to mention that we have two options here.

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
