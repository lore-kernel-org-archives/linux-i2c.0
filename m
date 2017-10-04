From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: i2c: Add armada-38x i2c binding
Date: Wed, 4 Oct 2017 08:33:35 -0500
Message-ID: <CAL_JsqKq1Gb3wvWEY0xJYsz=f5_1Y7G_t6LSgP1BuAK5rmU8zw@mail.gmail.com>
References: <20170922020429.20941-1-kalyan.kinthada@alliedtelesis.co.nz>
 <87377fmbpw.fsf@free-electrons.com> <1506289460890.34765@alliedtelesis.co.nz>
 <87lgl1ishv.fsf@free-electrons.com> <5376f24bf4c540088ce6432097b5cb51@svr-chch-ex1.atlnz.lc>
 <87efqsiok3.fsf@free-electrons.com> <20171003214925.353u7l35jvnergsr@rob-hp-laptop>
 <87lgkrl3ch.fsf@free-electrons.com> <CAL_JsqLWq-Xcg2WusZVA0EwwL1uThkjq6rUY072LrK729yoAmQ@mail.gmail.com>
 <878tgrkrd0.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <878tgrkrd0.fsf@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>, Kalyan Kinthada <Kalyan.Kinthada@alliedtelesis.co.nz>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Oct 4, 2017 at 7:52 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:
> Hi Rob,
>
>  On mer., oct. 04 2017, Rob Herring <robh@kernel.org> wrote:
>
>> On Wed, Oct 4, 2017 at 3:33 AM, Gregory CLEMENT
>> <gregory.clement@free-electrons.com> wrote:
>>> Hi Rob,
>>>
>>>  On mar., oct. 03 2017, Rob Herring <robh@kernel.org> wrote:
>>>
>>>> On Wed, Sep 27, 2017 at 09:33:00AM +0200, Gregory CLEMENT wrote:
>>>>> Hi Chris,
>>>>>
>>>>>  On mer., sept. 27 2017, Chris Packham <Chris.Packham@alliedtelesis.co.nz> wrote:

[...]

>>>>> If the IP is compatible then there is no reason to add a new one, else
>>>>> we will end with a compatible for each SoC and the compatible property
>>>>> will just loose its meaning.
>>>>
>>>> If you all had added compatibles for each SoC in the first place, then
>>>> we wouldn't be having this dicussion.
>>>
>>> Really??
>>>
>>> For Armada 38x we have already 6 flavor 381, 382, 383, 385, 388.  Then
>>> we have 9 SoC families on mvebu: orion5x, kirkwood, dove, Armada 370,
>>> Armada XP, Armada 375, Armada 39x, Armada 7K, Armada 8K. Of course in
>>> each family we have several flavors.
>>>
>>> But then Allwiner also use this driver in 8 SoC families: sun4i, sun5i,
>>> sun6i, sun7i, sun8i, sun9i, sunxi, sun50i. Here again each family have
>>> their own flavor.
>>>
>>> So you are just suggesting to blot the i2c driver with more than 50
>>> compatible string!
>>
>> No.
>>
>>> That also mean updating the i2c driver each time a new SoC flavor
>>> appear, so more or less for each release.
>>
>> No. You can have one or several fallbacks. Use the fallback as long as
>> you think they are the same and then add the more specific one to the
>> driver when you find differences.
>
> So you mean adding all the possible variant of the SoC in the binding
> documentation, but only implement them in the driver when needed?

Yes, and in the dts files. If some are the same die, but just
different packaging or fusing then I would not distinguish those. But
I realize you probably don't have that information being outside of
Marvell.

For the older parts, I'd guess they've been around long enough you've
either found the differences by now or few people care anymore, so I'm
not saying go back and add possible string now.

Rob
