From: "David.Wu" <david.wu@rock-chips.com>
Subject: Re: [PATCH v7 7/9] dt-bindings: i2c: rk3x: add support for rk3399
Date: Fri, 6 May 2016 14:09:48 +0800
Message-ID: <572C352C.50303@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372523-6444-1-git-send-email-david.wu@rock-chips.com>
 <20160505221212.GA26820@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:36487 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbcEFGJm (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Fri, 6 May 2016 02:09:42 -0400
In-Reply-To: <20160505221212.GA26820@rob-hp-laptop>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: heiko@sntech.de, wsa@the-dreams.de, dianders@chromium.org, andy.shevchenko@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, briannorris@google.com, davidriley@google.com, huangtao@rock-chips.com, hl@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com, cf@rock-chips.com, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rob,

=E5=9C=A8 2016/5/6 6:12, Rob Herring =E5=86=99=E9=81=93:
> On Wed, May 04, 2016 at 10:35:23PM +0800, David Wu wrote:
>> The bus clock and function clock are separated at rk3399,
>> and others use one clock as the bus clock and function clock.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 ++++++++++=
+++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Do=
cumentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> index 0b4a85f..82b6f6b 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> @@ -6,10 +6,20 @@ RK3xxx SoCs.
>>   Required properties :
>>
>>    - reg : Offset and length of the register set for the device
>> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i=
2c",
>> -		"rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
>> + - compatible: should be one of the followings
>
> s/followings/following:/
>
>> +   - "rockchip,rk3066-i2c": for rk3066
>> +   - "rockchip,rk3188-i2c": for rk3188
>> +   - "rockchip,rk3228-i2c": for rk3228
>> +   - "rockchip,rk3288-i2c": for rk3288
>> +   - "rockchip,rk3399-i2c": for rk3399
>>    - interrupts : interrupt number
>> - - clocks : parent clock
>> + - clocks: See ../clock/clock-bindings.txt
>> +   - For older hardware (rk3066, rk3188, rk3228, rk3288):
>> +     - There is one clock that's used both to derive the functional=
 clock
>> +       for the device and as the bus clock.  REQUIRED.
>
> This is the required section, so REQUIRED is redundant.


>
>> +   - For newer hardware (rk3399): specify by name
>> +     - "i2c": REQUIRED. This is used to derive the functional clock=
=2E
>> +     - "pclk": REQUIRED. This is the bus clock.equired on RK3066, R=
K3188 :
>
> This doesn't make sense. The first line says this applies to rk3399, =
but
> then here it is talking about other parts.
>
> And there's a typo.
>

Okay, I will remove the "equired on RK3066, RK3188 :".

>>
>>   Required on RK3066, RK3188 :
>>
>> --
>> 1.9.1
>>
>>
>
>
>
