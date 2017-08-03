From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: i2c: Add Spreadtrum I2C
 controller documentation
Date: Thu, 3 Aug 2017 15:29:46 +0800
Message-ID: <CAMz4kuKhJBoQjrzdy0mO+2WUUw+Hnw9dSWv4VEdR1uPBvHuKYQ@mail.gmail.com>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <20170724065146.GA22330@spreadtrum.com> <CAMz4kuLcGDxcNwymHDNTEf6Zs3ci11Q=1idsXcD=DJLe1rz0PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36231 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbdHCH3r (ORCPT
        <rfc822;linux-i2c@vger.kernel.org>); Thu, 3 Aug 2017 03:29:47 -0400
Received: by mail-oi0-f53.google.com with SMTP id g131so5149848oic.3
        for <linux-i2c@vger.kernel.org>; Thu, 03 Aug 2017 00:29:47 -0700 (PDT)
In-Reply-To: <CAMz4kuLcGDxcNwymHDNTEf6Zs3ci11Q=1idsXcD=DJLe1rz0PQ@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: wsa@the-dreams.de, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, andriy.shevchenko@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, wsa+renesas@sang-engineering.com

Hi Wolfram,

On 27 July 2017 at 17:29, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Wolfram,
>
> On 24 July 2017 at 14:51, Baolin Wang <baolin.wang@spreadtrum.com> wrote:
>> Hi Wolfram,
>>
>> On =E4=BA=94,  7=E6=9C=88 14, 2017 at 05:01:10=E4=B8=8B=E5=8D=88 +0800, =
Baolin Wang wrote:
>>> This patch adds the binding documentation for Spreadtrum I2C
>>> controller device.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@spreadtrum.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>> Changes since v3:
>>>  - Add Ack from RobH.
>>>
>>> Changes since v2:
>>>  - Change compatible strings to be SoC specific.
>>>
>>> Changes since v1:
>>>  - No updates.
>>> ---
>>
>> Could you apply this patchset if there are no other comments?
>> It is a long time since the v4 was send out. Thanks.
>
> Ping?

Since this patchset has waited for a long time, could you pick up this
patchset into your branch? Thanks.

>
>>
>>>  Documentation/devicetree/bindings/i2c/i2c-sprd.txt |   31 ++++++++++++=
++++++++
>>>  1 file changed, 31 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sprd.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sprd.txt b/Docum=
entation/devicetree/bindings/i2c/i2c-sprd.txt
>>> new file mode 100644
>>> index 0000000..60b7cda
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/i2c/i2c-sprd.txt
>>> @@ -0,0 +1,31 @@
>>> +I2C for Spreadtrum platforms
>>> +
>>> +Required properties:
>>> +- compatible: Should be "sprd,sc9860-i2c".
>>> +- reg: Specify the physical base address of the controller and length
>>> +  of memory mapped region.
>>> +- interrupts: Should contain I2C interrupt.
>>> +- clock-names: Should contain following entries:
>>> +  "i2c" for I2C clock,
>>> +  "source" for I2C source (parent) clock,
>>> +  "enable" for I2C module enable clock.
>>> +- clocks: Should contain a clock specifier for each entry in clock-nam=
es.
>>> +- clock-frequency: Constains desired I2C bus clock frequency in Hz.
>>> +- #address-cells: Should be 1 to describe address cells for I2C device=
 address.
>>> +- #size-cells: Should be 0 means no size cell for I2C device address.
>>> +
>>> +Optional properties:
>>> +- Child nodes conforming to I2C bus binding
>>> +
>>> +Examples:
>>> +i2c0: i2c@70500000 {
>>> +     compatible =3D "sprd,sc9860-i2c";
>>> +     reg =3D <0 0x70500000 0 0x1000>;
>>> +     interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>>> +     clock-names =3D "i2c", "source", "enable";
>>> +     clocks =3D <&clk_i2c3>, <&ext_26m>, <&clk_ap_apb_gates 11>;
>>> +     clock-frequency =3D <400000>;
>>> +     #address-cells =3D <1>;
>>> +     #size-cells =3D <0>;
>>> +};
>>> +
>>> --
>>> 1.7.9.5
>>>
>
>
>
> --
> Baolin.wang
> Best Regards



--=20
Baolin.wang
Best Regards
