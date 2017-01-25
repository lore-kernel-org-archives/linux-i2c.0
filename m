From: Danielle Costantino <danielle.costantino@gmail.com>
Subject: Re: [PATCH v5 5/5] i2c: mux: pca954x: Add irq-mask-enable to delay
 enabling irqs
Date: Tue, 24 Jan 2017 19:50:33 -0800
Message-ID: <CAAVjN7eGNsQOPiy0HuDq26MPNrD0xk7uxiN2+UO=hyuCSBa5nw@mail.gmail.com>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
 <1484640029-22870-6-git-send-email-preid@electromag.com.au>
 <312e32e9-a828-d692-895b-4042729e5417@axentia.se> <61c38233-abf2-df31-6f7c-c4214f4103aa@electromag.com.au>
 <71f756e1-4677-8b59-81a2-2b12fbf12621@axentia.se> <35c35708-3bbc-88d1-1d60-4faf68ca5af9@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33819 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbdAYDuz (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Tue, 24 Jan 2017 22:50:55 -0500
In-Reply-To: <35c35708-3bbc-88d1-1d60-4faf68ca5af9@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux device trees <devicetree@vger.kernel.org>

On Mon, Jan 23, 2017 at 1:02 AM, Phil Reid <preid@electromag.com.au> wrote:
>
> On 20/01/2017 06:56, Peter Rosin wrote:
>>
>> On 2017-01-19 08:48, Phil Reid wrote:
>>>
>>> On 18/01/2017 20:19, Peter Rosin wrote:
>>>>
>>>> On 2017-01-17 09:00, Phil Reid wrote:
>
>
> [snip]
>
>
>>>> Hmm, this whole thing is fiddly and while it solves your problem it doesn't
>>>> allow for solving the more general problem when there are "problematic"
>>>> devices mixed with other devices. At least, I don't see it. And the
>>>> limitations we are walking into with tracking number of enables etc suggests
>>>> that we are attacking this at the wrong level. Maybe you should try to work
>>>> around the hw limitations not in the pca954x driver, but in the irq core?
>>>
>>>
>>> I'm looking at the option of getting the hardware changed to not route
>>> the irq for my chips thru the i2c mux. Fortunately the hardware is going thru a
>>> revision for some other changes. Messing with the irq core sounds dangerous
>>> with my level of knowledge.
>>
>>
>> Yeah, but I bet you'd get some attention from people with more irq
>> experience. That can't be bad :-)
>>
>>> The other way I think I can tackle it after reading the datasheet for the ltc1760 is that
>>> it'll deassert it's irq (smbalert) line when the host sends a ARA request on the bus segment.
>>> There's a driver in the kernel for this already, but it's not DT enable and doesn't
>>> handle multiple bus segments. I'll have a look at that as well.
>>> Pretty sure it would need the mux to become an irq parent as per patch 1-3 of this series.
>>> This would be so the system can figure out which segment to do the poll on.
>>
>>
>> Yeah sounds neater. It has the slight drawback that it may not work
>> for pure i2c buses since it an SMB thing??

If you need to send SMBus commands like ARA, you should be using an
SMBus 2.0+ compatible bus multiplexer. muxes like the pca954x do not
automatically select the bus segment that the ARA is destined for. It
usually is more efficient to only request the data you need from each
device, rather than checking every segment on each interrupt for the
cause, one could implement a delayed worker to schedule
checking+clearing the interrupt at a time when the bus is selected for
use by another slave device on that segment when possible. This will
reduce the number of bus setup operations per transfer to slaves on
deeper busses, reducing your i2c latency.

>>
>> BTW, why do you need special treatment for multiple segments? Will it not
>> simply have an ARA appear on whatever i2c bus the device sits on? And if
>> something requests to send an ARA message on a bus that happens to be a
>> muxed segment, my mental picture is that the mux will be operated as usual
>> so that the ARA appears on the muxed segment. Maybe I'm missing something?
>
>
> My think was the following.
> When the SMBALERT is asserted a ARA needs to be sent by the master.
> If the device sending the SMBALERT is behind a mux when need to know which segment of the bus to enable.
> Using shared interrupts should work I think, but you have to iterate thru each bus segment.
> If the alert device is nested behind a couple of muxes this could get expensive.
> But yeah otherwise I think the correct mux segment will get enabled automatically.
> The current SMBALERT driver only seems to attached to the root i2c adapter.

Using ARA in a multi mux environment is very expensive, setting up
each mux segment and then sending ARA will consume more time than it
would take if the mux structure was optimized to service devices on
similar busses, reducing the setup operation count. ARA was only
implemented on the root bus due to the design of the arbiter and mux
cannot guarantee that you are the only owner of the bus when you are
disconnected. You would also need to handle the cases where segments
lock up and must be released using the bus reset mechanism, this
resets the IRQs as well. The added cost of a I2C read to coincide the
write operation to the mux when the irq pin is asserted is
unacceptable for low latency applications.

>>
>>
>>> But p4-5 could be dropped which is where we're stuck I think.
>>
>>
>> Yes, I dislike to add a workaround for a specific case that might get
>> in the way for anybody wishing to fix a bigger, more generic, problem...
>>
>>> Looking at this approach it shouldn't matter if the ltc1760 driver has registered yet or not.
>>> This approach possibly has a lot more generic appeal I think.
>>>
>>> Thoughts on just submitting p1-3 for now while I figure out the SMB alert approach?
>>
>>
>> Yes, looks like a plan. Thanks in advance!
>
>
> Thanks, I'll do a new version with just p1-3.
>
>
>>>>>
>>>>> -       if (!data->irq_mask)
>>>>> -               enable_irq(data->client->irq);
>>>>>         data->irq_mask |= BIT(pos);
>>>>> +       if (!data->irq_enabled
>>>>> +           && (data->irq_mask & mask_enable) == mask_enable) {
>>>>
>>>>
>>>> I think the coding standard says that the && should be at the end of the
>>>> first line. Didn't checkpatch complain?
>>>
>>>
>>> No it didn't complain. and I wasn't sure which way to do this.
>>
>>
>> Ah, you need the --strict option for that to show up...
>>
> Haven't come across that option, I'll give it a try in future.
>
> --
> Regards
> Phil Reid
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




-- 
- Danielle Costantino
