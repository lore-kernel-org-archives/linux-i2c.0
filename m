From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Wed, 27 Sep 2017 09:33:00 +0200
Message-ID: <87efqsiok3.fsf@free-electrons.com>
References: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>
        <87377fmbpw.fsf@free-electrons.com>
        <1506289460890.34765@alliedtelesis.co.nz>
        <87lgl1ishv.fsf@free-electrons.com>
        <5376f24bf4c540088ce6432097b5cb51@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:52161 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdI0HdL (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 27 Sep 2017 03:33:11 -0400
In-Reply-To: <5376f24bf4c540088ce6432097b5cb51@svr-chch-ex1.atlnz.lc> (Chris
        Packham's message of "Wed, 27 Sep 2017 01:15:12 +0000")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Kalyan Kinthada <Kalyan.Kinthada@alliedtelesis.co.nz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Chris,
 
 On mer., sept. 27 2017, Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

> Hi Gregory,
>
> On 27/09/17 00:56, Gregory CLEMENT wrote:
>> Hi Kalyan,
>> 
>> Please try avoid top-posting.
>> 
>>   On dim., sept. 24 2017, Kalyan Kinthada <Kalyan.Kinthada@alliedtelesis.co.nz> wrote:
>> 
>>> Hi Gregory,
>>>
>>> I got this information from Armada-38x functional errata document.
>> 
>> OK but in any case just adding a new compatible was not enough you have
>> to update the driver in the same time, however for this case we won't
>> need it, see below.
>> 
>>>
>>> I can add the "marvell,mv78230-i2c" compatible string to the appropriate  device tree files
>>> but the i2c-mv64xxx driver enables an additional  feature (offload i2c transactions)
>>> based on the compatible string "marvell,mv78230-i2c".
>>>
>>> I am not sure if this feature (offload i2c transactions) should be enabled for Armada-38x devices.
>>> That is the reason I felt for the need of a new compatible string
>>> specifically for Armada-38x SoCs.
>> 
>> Indeed the Armada-38x SoCs does not support hardware offloading (at
>> least according the datasheet). But it happens that in the earlier
>> version of the Armada XP the hardware offloading was buggy, so we
>> introduced a compatible for this case: marvell,mv78230-a0-i2c. This
>> compatible enable the errata fix but not the offloading feature. That
>> means that it is exactly the compatible you need for Armada 38x (and
>> Armada 39x and 375 I think).
>
> The "mv78230-a0-i2c" dt-binding has the following note
>
>    Note: Only use "marvell,mv78230-a0-i2c" for a
>    very rare, initial version of the SoC which
>    had broken offload support.  Linux
>    auto-detects this and sets it appropriately.
>
> If we are going to re-use this binding for armada-38x we should probably 
> remove this note. Personally my preference would be an armada-38x

Updating the documentation is the right thing to do yes.


> compatible string (or 370 if that's the common base of these SoCs). But 
> of course we'll go with whatever your preference is as maintainer.

If the IP is compatible then there is no reason to add a new one, else
we will end with a compatible for each SoC and the compatible property
will just loose its meaning.

But an other reason to reuse "marvell,mv78230-a0-i2c" is that thanks to
this you will benefit to this even with the old kernel by just updating
the device tree, else you will have to update both the kernel and the
dtb.


Gregory

>
>> 
>> Gregory
>> 
>>>
>>> Thanks,
>>> Kalyan
>>> ________________________________________
>>> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>> Sent: Friday, 22 September 2017 7:30 p.m.
>>> To: Kalyan Kinthada
>>> Cc: devicetree@vger.kernel.org; wsa@the-dreams.de; robh+dt@kernel.org;
>>> pawel.moll@arm.com; mark.rutland@arm.com;
>>> ijc+devicetree@hellion.org.uk; galak@codeaurora.org;
>>> linux-i2c@vger.kernel.org; linux-kernel@vger.kernel.org; Chris Packham
>>> Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
>>>
>>> Hi Kalyan,
>>>
>>>   On ven., sept. 22 2017, Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz> wrote:
>>>
>>>> All armada-38x variants(380, 385, 388) SoCs have an issue
>>>> in i2c controller which violates the i2c repeated start timing.
>>>
>>>
>>> Did you had an issue with one of the SoC ?
>>> If yes what was your setting ?
>>> On my side I never managed to have this sort of issue on Armada 38x.
>>>
>>>>
>>>> This errata is fixed in the i2c-mv64xxx driver but enabled
>>>> only for devices with compatible string "marvell,mv78230-i2c".
>>>
>>> In this case why not just adding the "marvell,mv78230-i2c" as compatible
>>> string in the appropriate device tree files ?
>>>
>>> Gregory
>>>
>>>>
>>>> This patch introduces a new compatible string
>>>> "marvell,armada-38x-i2c" for the i2c controller on armada-38x SoCs
>>>> so that the workaound is enabled.
>>>
>>>
>>>>
>>>> Signed-off-by: Kalyan Kinthada <kalyan.kinthada@alliedtelesis.co.nz>
>>>> ---
>>>>   Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>>>> index 5c30026921..fc100b6bdb 100644
>>>> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
>>>> @@ -14,6 +14,7 @@ Required properties :
>>>>                            very rare, initial version of the SoC which
>>>>                            had broken offload support.  Linux
>>>>                            auto-detects this and sets it appropriately.
>>>> +                     - "marvell,armada-38x-i2c"
>>>>    - interrupts      : The interrupt number
>>>>
>>>>   Optional properties :
>>>> --
>>>> 2.14.1
>>>>
>>>
>>> --
>>> Gregory Clement, Free Electrons
>>> Kernel, drivers, real-time and embedded Linux
>>> development, consulting, training and support.
>>> http://free-electrons.com
>> 
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
