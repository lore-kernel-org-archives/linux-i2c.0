From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Wed, 04 Oct 2017 10:33:18 +0200
Message-ID: <87lgkrl3ch.fsf@free-electrons.com>
References: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>
        <87377fmbpw.fsf@free-electrons.com>
        <1506289460890.34765@alliedtelesis.co.nz>
        <87lgl1ishv.fsf@free-electrons.com>
        <5376f24bf4c540088ce6432097b5cb51@svr-chch-ex1.atlnz.lc>
        <87efqsiok3.fsf@free-electrons.com>
        <20171003214925.353u7l35jvnergsr@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54795 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751702AbdJDIda (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Wed, 4 Oct 2017 04:33:30 -0400
In-Reply-To: <20171003214925.353u7l35jvnergsr@rob-hp-laptop> (Rob Herring's
        message of "Tue, 3 Oct 2017 16:49:25 -0500")
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, Kalyan Kinthada <Kalyan.Kinthada@alliedtelesis.co.nz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Rob,
 
 On mar., oct. 03 2017, Rob Herring <robh@kernel.org> wrote:

> On Wed, Sep 27, 2017 at 09:33:00AM +0200, Gregory CLEMENT wrote:
>> Hi Chris,
>>  
>>  On mer., sept. 27 2017, Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:
>> 
>> > Hi Gregory,
>> >
>> > On 27/09/17 00:56, Gregory CLEMENT wrote:
>> >> Hi Kalyan,
>> >> 
>> >> Please try avoid top-posting.
>> >> 
>> >>   On dim., sept. 24 2017, Kalyan Kinthada <Kalyan.Kinthada@alliedtelesis.co.nz> wrote:
>> >> 
>> >>> Hi Gregory,
>> >>>
>> >>> I got this information from Armada-38x functional errata document.
>> >> 
>> >> OK but in any case just adding a new compatible was not enough you have
>> >> to update the driver in the same time, however for this case we won't
>> >> need it, see below.
>> >> 
>> >>>
>> >>> I can add the "marvell,mv78230-i2c" compatible string to the appropriate  device tree files
>> >>> but the i2c-mv64xxx driver enables an additional  feature (offload i2c transactions)
>> >>> based on the compatible string "marvell,mv78230-i2c".
>> >>>
>> >>> I am not sure if this feature (offload i2c transactions) should be enabled for Armada-38x devices.
>> >>> That is the reason I felt for the need of a new compatible string
>> >>> specifically for Armada-38x SoCs.
>> >> 
>> >> Indeed the Armada-38x SoCs does not support hardware offloading (at
>> >> least according the datasheet). But it happens that in the earlier
>> >> version of the Armada XP the hardware offloading was buggy, so we
>> >> introduced a compatible for this case: marvell,mv78230-a0-i2c. This
>> >> compatible enable the errata fix but not the offloading feature. That
>> >> means that it is exactly the compatible you need for Armada 38x (and
>> >> Armada 39x and 375 I think).
>> >
>> > The "mv78230-a0-i2c" dt-binding has the following note
>> >
>> >    Note: Only use "marvell,mv78230-a0-i2c" for a
>> >    very rare, initial version of the SoC which
>> >    had broken offload support.  Linux
>> >    auto-detects this and sets it appropriately.
>> >
>> > If we are going to re-use this binding for armada-38x we should probably 
>> > remove this note. Personally my preference would be an armada-38x
>> 
>> Updating the documentation is the right thing to do yes.
>> 
>> 
>> > compatible string (or 370 if that's the common base of these SoCs). But 
>> > of course we'll go with whatever your preference is as maintainer.
>> 
>> If the IP is compatible then there is no reason to add a new one, else
>> we will end with a compatible for each SoC and the compatible property
>> will just loose its meaning.
>
> If you all had added compatibles for each SoC in the first place, then 
> we wouldn't be having this dicussion.

Really??

For Armada 38x we have already 6 flavor 381, 382, 383, 385, 388.  Then
we have 9 SoC families on mvebu: orion5x, kirkwood, dove, Armada 370,
Armada XP, Armada 375, Armada 39x, Armada 7K, Armada 8K. Of course in
each family we have several flavors.

But then Allwiner also use this driver in 8 SoC families: sun4i, sun5i,
sun6i, sun7i, sun8i, sun9i, sunxi, sun50i. Here again each family have
their own flavor.

So you are just suggesting to blot the i2c driver with more than 50
compatible string!

That also mean updating the i2c driver each time a new SoC flavor
appear, so more or less for each release.

Really this just don't scale.

Gregory



>
> Rob

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
