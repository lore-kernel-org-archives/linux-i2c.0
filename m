From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH v5 5/5] i2c: mux: pca954x: Add irq-mask-enable to delay
 enabling irqs
Date: Thu, 26 Jan 2017 09:56:17 +0800
Message-ID: <1786e8c3-76b9-9b60-2623-f6b66f59b6eb@electromag.com.au>
References: <1484640029-22870-1-git-send-email-preid@electromag.com.au>
 <1484640029-22870-6-git-send-email-preid@electromag.com.au>
 <312e32e9-a828-d692-895b-4042729e5417@axentia.se>
 <61c38233-abf2-df31-6f7c-c4214f4103aa@electromag.com.au>
 <71f756e1-4677-8b59-81a2-2b12fbf12621@axentia.se>
 <35c35708-3bbc-88d1-1d60-4faf68ca5af9@electromag.com.au>
 <CAAVjN7eGNsQOPiy0HuDq26MPNrD0xk7uxiN2+UO=hyuCSBa5nw@mail.gmail.com>
 <f203f28f-51c8-a7a0-6e82-16d587310be9@axentia.se>
 <d9e92666-0c92-891d-7481-1800f5b4efac@gmail.com>
 <035315e2-fefa-4332-ee49-32d2dc7cdba7@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:39292 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752249AbdAZB4a (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 25 Jan 2017 20:56:30 -0500
In-Reply-To: <035315e2-fefa-4332-ee49-32d2dc7cdba7@axentia.se>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Danielle Costantino <danielle.costantino@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c <linux-i2c@vger.kernel.org>, Linux device trees <devicetree@vger.kernel.org>

On 25/01/2017 19:30, Peter Rosin wrote:
> On 2017-01-25 10:17, Danielle Costantino wrote:
>>
>>
>> On 01/25/2017 12:15 AM, Peter Rosin wrote:
>>> On 2017-01-25 04:50, Danielle Costantino wrote:
>>>> On Mon, Jan 23, 2017 at 1:02 AM, Phil Reid <preid@electromag.com.au> wrote:
>>>>> On 20/01/2017 06:56, Peter Rosin wrote:
>>>>>> On 2017-01-19 08:48, Phil Reid wrote:
>>>>>>> On 18/01/2017 20:19, Peter Rosin wrote:
>>>>>>>> On 2017-01-17 09:00, Phil Reid wrote:
>>>>>
>>>>> [snip]
>>>>>
>>>>>
>>>>>>>> Hmm, this whole thing is fiddly and while it solves your problem it doesn't
>>>>>>>> allow for solving the more general problem when there are "problematic"
>>>>>>>> devices mixed with other devices. At least, I don't see it. And the
>>>>>>>> limitations we are walking into with tracking number of enables etc suggests
>>>>>>>> that we are attacking this at the wrong level. Maybe you should try to work
>>>>>>>> around the hw limitations not in the pca954x driver, but in the irq core?
>>>>>>>
>>>>>>> I'm looking at the option of getting the hardware changed to not route
>>>>>>> the irq for my chips thru the i2c mux. Fortunately the hardware is going thru a
>>>>>>> revision for some other changes. Messing with the irq core sounds dangerous
>>>>>>> with my level of knowledge.
>>>>>>
>>>>>> Yeah, but I bet you'd get some attention from people with more irq
>>>>>> experience. That can't be bad :-)
>>>>>>
>>>>>>> The other way I think I can tackle it after reading the datasheet for the ltc1760 is that
>>>>>>> it'll deassert it's irq (smbalert) line when the host sends a ARA request on the bus segment.
>>>>>>> There's a driver in the kernel for this already, but it's not DT enable and doesn't
>>>>>>> handle multiple bus segments. I'll have a look at that as well.
>>>>>>> Pretty sure it would need the mux to become an irq parent as per patch 1-3 of this series.
>>>>>>> This would be so the system can figure out which segment to do the poll on.
>>>>>>
>>>>>> Yeah sounds neater. It has the slight drawback that it may not work
>>>>>> for pure i2c buses since it an SMB thing??
>>>> If you need to send SMBus commands like ARA, you should be using an
>>>> SMBus 2.0+ compatible bus multiplexer. muxes like the pca954x do not
>>>> automatically select the bus segment that the ARA is destined for. It
>>>> usually is more efficient to only request the data you need from each
>>>> device, rather than checking every segment on each interrupt for the
>>> We are not talking about checking every segment on every interrupt, we
>>> are talking about checking the segments indicated by the INTx bits in
>>> the control register.
>>>
>>>> cause, one could implement a delayed worker to schedule
>>>> checking+clearing the interrupt at a time when the bus is selected for
>>>> use by another slave device on that segment when possible. This will
>>>> reduce the number of bus setup operations per transfer to slaves on
>>>> deeper busses, reducing your i2c latency.
>>> i2c traffic scheduling does not exist in linux to the best of my knowledge,
>>> it's all handled with a simple mutex AFAIK. So, while traffic scheduling
>>> is an interesting problem, I think it is out of scope at this time.
>>>
>>> If you happen to have a pca954x mux (with irq support) and happen to
>>> have devices behind it that needs ARA support, I just don't see how any
>>> of the above is relevant. Yes, it could be more efficient to have the
>>> hardware done differently, but that is in many cases not a possibility.
>>> You have to make do with what you have, and if that costs latency, then
>>> there is little to do about that. You only have to make the new stuff
>>> optional so that old working setups don't suffer.
>> Yes traffic scheduling of I2C transactions is out of the scope of the
>> current problem but I thought that it may be useful to bring it up.
>>>>>> BTW, why do you need special treatment for multiple segments? Will it not
>>>>>> simply have an ARA appear on whatever i2c bus the device sits on? And if
>>>>>> something requests to send an ARA message on a bus that happens to be a
>>>>>> muxed segment, my mental picture is that the mux will be operated as usual
>>>>>> so that the ARA appears on the muxed segment. Maybe I'm missing something?
>>>>>
>>>>> My think was the following.
>>>>> When the SMBALERT is asserted a ARA needs to be sent by the master.
>>>>> If the device sending the SMBALERT is behind a mux when need to know which segment of the bus to enable.
>>>>> Using shared interrupts should work I think, but you have to iterate thru each bus segment.
>>>>> If the alert device is nested behind a couple of muxes this could get expensive.
>>>>> But yeah otherwise I think the correct mux segment will get enabled automatically.
>>>>> The current SMBALERT driver only seems to attached to the root i2c adapter.
>>>> Using ARA in a multi mux environment is very expensive, setting up
>>>> each mux segment and then sending ARA will consume more time than it
>>>> would take if the mux structure was optimized to service devices on
>>>> similar busses, reducing the setup operation count. ARA was only
>>>> implemented on the root bus due to the design of the arbiter and mux
>>>> cannot guarantee that you are the only owner of the bus when you are
>>>> disconnected.
>>> ARA handling should take the irq register of the pca95x into account and
>>> only send ARAs to indicated mux segments. If more than one segment needs
>>> servicing, then of course one ARA for each segment needs to be sent. If
>>> someone builds hardware like this and then expect no latency, that someone
>>> will hopefully at least learn something.
>>>
>>> I do not know how this fits with the existing ARA handling (it probably
>>> doesn't), but what needs to happen is fairly easy to picture.
>>>
>>>>    You would also need to handle the cases where segments
>>>> lock up and must be released using the bus reset mechanism, this
>>>> resets the IRQs as well. The added cost of a I2C read to coincide the
>>>> write operation to the mux when the irq pin is asserted is
>>>> unacceptable for low latency applications.
>>> I bet there are a lot of corner cases, and yes, this added cost has to be
>>> optional. Perhaps with each mux child segment opting in for ARA support?

Yes my plan was to opt in.
I was things an optional dt entry on the bus segment.
something like this

i2c-switch@74 {
	compatible = "nxp,pca9548";
	#address-cells = <1>;
	#size-cells = <0>;
	reg = <0x74>;

	interrupt-parent = <&ipic>;
	interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
	interrupt-controller;
	#interrupt-cells = <2>;

	i2c@2 {
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <2>;
		smb-alert = <&i2c-switch 1 IRQ_TYPE_LEVEL_HIGH>;
		eeprom@54 {...};
	};
	i2c@4 {
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <2>;
		eeprom@54 {...};
	};
};


>>> If a mux then has a way to determine that an ARA isn't needed for some of
>>> its child segments (by reading some status register), then linux is free
>>> to not send ARAs there. And more importantly, if no mux child segment opts
>>> in for ARA support, it should be possible to preserve current behavior...
>> I agree with making ARA handling for child bus segments optional based
>> on the need of ARA or other SMBus features. We have needed IRQ support
>> for muxes for a while now, I was always concerned about dead locks
>> between setting up the bus and servicing the IRQ. The current patch v6
>> 0/3 appears to handle child IRQs without selecting the bus associated
>> with it. Is the plan to have the irq handling of the child require an
>> i2c transaction on its registered bus, which will in turn select that
>> bus?
>
> You are correct in that the current proposed patches do not support
> having a device being master on a mux child segment and expect that
> any traffic hits the root adapter. A device has no way to lock the
> mux in the correct position short of having its driver issue an
> ordinary transaction (i.e. ->i2c_transfer or ->smbus_xfer) on the
> adapter it sits on. And after the transaction, there is no guarantee
> that the mux will stay in the desired position.

There are SMBus mechanisms for alert the host.
SMBAlert and "Host Notify Protocol".
I just want to make sure where talking about the same thing.

SMBAlert, device asserts ALERT line and then the host polls the i2c bus using an ARA request.
With this method the host can ensure the correct segment is selected before sending the ARA.
The device is always a slave.

"Host Notify Protocol": the devices becomes an i2c master and sends data unsolicited.
No irq are necessary from what I can see, I don't have any devices using this method.
Muxes will get in the way of this one unless they are aware of the protocol.

My work only address SMBAlert and ARA.

>
>>      I also thought i2c transactions were not allowed inside an IRQ
>> handler?
>
> They are allowed in a threaded handler, which is very similar to a
> delayed work. If it is not in fact exactly that?
>
I think that's how they work. There are other devices doing basically the same thing
in an threaded IRQ handler. i2c gpio's with irq support for example, eg: mcp23s08

>>          Could a delayed work struct could be used to fire off the read
>> transaction that would then trigger the nested IRQs (based on the set
>> bits)? Also the PCA954x has an internal OR of the INT signals coming
>> into it, not an AND like the patch says.
>
> All INT signals on the pca954x are active-low. The only sensible way for
> the mux to combine its active-low inputs into an active-low output is
> with an AND gate. If any of the inputs fire, you want the output to
> also fire. So, I'd say that commit message is fine.
Yes.

>
>>                                          Before allowing IRQs to be
>> handled by the assertion of the active low INT out signal from the
>> PCA954x all child interrupts must be de-asserted else the IRQ will
>> always be set. You could read the value of the interrupt register to see
>> if all bits are clear before allowing unmasking of the devices interrupts.
>
> This is not possible with the pca954x. There is no way to prevent them
> from asserting their output if one of their inputs is asserted. Which
> means that if the irq is shared, and if something else have activated
> it, there will be an irq flood. This is exactly the kind of trouble
> Phil is trying to work around since his chargers continuously fire
> interrupts when there is no driver to quiet them down.
>
> I don't know if going with ARAs can help him, but I think it should be
> possible. I also don't know how difficult it is going to be to make
> this work and also be compatible with whatever ARA support there is
> already. I'm not familiar with how the current ARA support works...
>

Hopefully I'll get to looking at this next week to see how feasible it is.



-- 
Regards
Phil Reid
