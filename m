From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH 3/6] arm64: renesas: r8a77995: add I2C support
Date: Fri, 19 Jan 2018 10:32:19 +0000
Message-ID: <787354f2-4b76-37fd-4570-e73657b2854c@ideasonboard.com>
References: <1510759526-30346-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1510759526-30346-4-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdV4pBYPTrnCCU8BU1Lr8t2ejcKwWpXWzp-PuBgT2DfVSg@mail.gmail.com>
 <20171117142850.iht5qonmfscl47sp@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:44503 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeASKcX (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Fri, 19 Jan 2018 05:32:23 -0500
In-Reply-To: <20171117142850.iht5qonmfscl47sp@verge.net.au>
Content-Language: en-GB
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Linux I2C <linux-i2c@vger.kernel.org>

Hi Ulrich,

On 17/11/17 14:28, Simon Horman wrote:
> On Thu, Nov 16, 2017 at 10:10:27AM +0100, Geert Uytterhoeven wrote:
>> Hi Ulrich,
>>
>> On Wed, Nov 15, 2017 at 4:25 PM, Ulrich Hecht
>> <ulrich.hecht+renesas@gmail.com> wrote:
>>> Defines R-Car D3 I2C controllers 0-3.
>>>
>>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>>
>> Thanks for your patch!
>>
>>> --- a/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>>> +++ b/arch/arm64/boot/dts/renesas/r8a77995.dtsi
>>> @@ -400,6 +400,70 @@
>>>                         status = "disabled";
>>>                 };
>>>
>>> +               i2c0: i2c@e6500000 {
>>> +                       #address-cells = <1>;
>>> +                       #size-cells = <0>;
>>> +                       compatible = "renesas,i2c-r8a77995",
>>> +                                    "renesas,rcar-gen3-i2c";
>>> +                       reg = <0 0xe6500000 0 0x40>;
>>> +                       interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
>>> +                       clocks = <&cpg CPG_MOD 931>;
>>> +                       power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
>>> +                       resets = <&cpg 931>;
>>> +                       dmas = <&dmac1 0x91>, <&dmac1 0x90>;
>>> +                       dma-names = "tx", "rx";
>>
>> Missing set for dmac2? (for all four interfaces)
>>
>>> +                       i2c-scl-internal-delay-ns = <110>;
>>
>> According to Table 57.1, all i2c interfaces on R-Car D3 have LVTTL
>> output buffers,
>> so this should be <6> for all four interfaces.
>>
>> With the above fixed:
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Hi Ulrich,
> 
> I would like Geert's review addressed before I consider applying this patch.

I am dependant upon this patch for my Draak-D3 work.

Would you be able to consider the comments mentioned to progress this patch please?
