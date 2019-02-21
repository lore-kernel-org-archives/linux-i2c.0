From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Thu, 21 Feb 2019 15:22:09 +0100
Message-ID: <5fec5fcb-95c5-e7f0-9cf3-d2a6d35b3dfd@gmail.com>
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
 <1550666030-30211-3-git-send-email-qii.wang@mediatek.com>
 <e9d544c8-576d-f52c-d805-90d695b7ed46@gmail.com>
 <1550755929.30363.26.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550755929.30363.26.camel@mhfsdcap03>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Qii Wang <qii.wang@mediatek.com>
Cc: wsa@the-dreams.de, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org



On 21/02/2019 14:32, Qii Wang wrote:
> On Wed, 2019-02-20 at 16:25 +0100, Matthias Brugger wrote:
>>
>> On 20/02/2019 13:33, Qii Wang wrote:
>>> Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
>>> controller, MT8183 has different registers, offsets, and clock.
>>>
>>> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
>>> index ee4c324..da2fa60 100644
>>> --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
>>> @@ -12,14 +12,15 @@ Required properties:
>>>        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
>>>        "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
>>>        "mediatek,mt8173-i2c": for MediaTek MT8173
>>> +      "mediatek,mt8183-i2c": for MediaTek MT8183
>>>    - reg: physical base address of the controller and dma base, length of memory
>>>      mapped region.
>>>    - interrupts: interrupt number to the cpu.
>>>    - clock-div: the fixed value for frequency divider of clock source in i2c
>>>      module. Each IC may be different.
>>>    - clocks: clock name from clock manager
>>> -  - clock-names: Must include "main" and "dma", if enable have-pmic need include
>>> -    "pmic" extra.
>>> +  - clock-names: Must include "main" and "dma", "arb" is optional, if enable
>>> +    have-pmic need include "pmic" extra.
>>
>> You have to mention that the arb clock is only necessary for mt8183.
>>
> 
> Arb clock is not only necessary for mt8183. When two i2c controllers are
> internally connected to the same GPIO pins, the arb clock is needed to
> ensure that the waveforms do not interfere with each other.
> Maybe ""arb" is for multi-master" is better. Not all i2c controller have
> multi-master.
> 

Ok, that's value information. I propose to put that into the commit message
where you add arb clock to the driver.

In any case, the binding description should have this information. As you said,
not all i2c controller have multi-master mode, so we don't need arb clock for
all controllers.

Regards,
Matthias

>>>  
>>>  Optional properties:
>>>    - clock-frequency: Frequency in Hz of the bus when transfer, the default value
>>>
> 
> 
