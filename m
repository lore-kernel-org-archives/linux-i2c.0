From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: i2c: Add Spreadtrum I2C
 controller documentation
Date: Thu, 27 Jul 2017 17:29:41 +0800
Message-ID: <CAMz4kuLcGDxcNwymHDNTEf6Zs3ci11Q=1idsXcD=DJLe1rz0PQ@mail.gmail.com>
References: <eda1f25512db9c6946b303dd43f518ae2f0f3b26.1500021045.git.baolin.wang@spreadtrum.com>
 <20170724065146.GA22330@spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170724065146.GA22330-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram,

On 24 July 2017 at 14:51, Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org> wrote:
> Hi Wolfram,
>
> On =E4=BA=94,  7=E6=9C=88 14, 2017 at 05:01:10=E4=B8=8B=E5=8D=88 +0800, B=
aolin Wang wrote:
>> This patch adds the binding documentation for Spreadtrum I2C
>> controller device.
>>
>> Signed-off-by: Baolin Wang <baolin.wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
>> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> ---
>> Changes since v3:
>>  - Add Ack from RobH.
>>
>> Changes since v2:
>>  - Change compatible strings to be SoC specific.
>>
>> Changes since v1:
>>  - No updates.
>> ---
>
> Could you apply this patchset if there are no other comments?
> It is a long time since the v4 was send out. Thanks.

Ping?

>
>>  Documentation/devicetree/bindings/i2c/i2c-sprd.txt |   31 +++++++++++++=
+++++++
>>  1 file changed, 31 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sprd.txt
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sprd.txt b/Docume=
ntation/devicetree/bindings/i2c/i2c-sprd.txt
>> new file mode 100644
>> index 0000000..60b7cda
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-sprd.txt
>> @@ -0,0 +1,31 @@
>> +I2C for Spreadtrum platforms
>> +
>> +Required properties:
>> +- compatible: Should be "sprd,sc9860-i2c".
>> +- reg: Specify the physical base address of the controller and length
>> +  of memory mapped region.
>> +- interrupts: Should contain I2C interrupt.
>> +- clock-names: Should contain following entries:
>> +  "i2c" for I2C clock,
>> +  "source" for I2C source (parent) clock,
>> +  "enable" for I2C module enable clock.
>> +- clocks: Should contain a clock specifier for each entry in clock-name=
s.
>> +- clock-frequency: Constains desired I2C bus clock frequency in Hz.
>> +- #address-cells: Should be 1 to describe address cells for I2C device =
address.
>> +- #size-cells: Should be 0 means no size cell for I2C device address.
>> +
>> +Optional properties:
>> +- Child nodes conforming to I2C bus binding
>> +
>> +Examples:
>> +i2c0: i2c@70500000 {
>> +     compatible =3D "sprd,sc9860-i2c";
>> +     reg =3D <0 0x70500000 0 0x1000>;
>> +     interrupts =3D <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +     clock-names =3D "i2c", "source", "enable";
>> +     clocks =3D <&clk_i2c3>, <&ext_26m>, <&clk_ap_apb_gates 11>;
>> +     clock-frequency =3D <400000>;
>> +     #address-cells =3D <1>;
>> +     #size-cells =3D <0>;
>> +};
>> +
>> --
>> 1.7.9.5
>>



--=20
Baolin.wang
Best Regards
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
