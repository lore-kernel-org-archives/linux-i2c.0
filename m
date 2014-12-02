From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] staging: imx-drm: document internal HDMI I2C master
 controller DT binding
Date: Tue, 2 Dec 2014 15:11:53 +0200
Message-ID: <547DBA99.1010703@mentor.com>
References: <1416073759-19939-1-git-send-email-vladimir_zapolskiy@mentor.com>		 <1416073759-19939-2-git-send-email-vladimir_zapolskiy@mentor.com>		 <547C8113.3050100@mentor.com> <1417446703.4624.18.camel@pengutronix.de>	 <547C8B9E.8050605@mentor.com> <1417450979.4624.23.camel@pengutronix.de> <547D5DE2.2040704@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <547D5DE2.2040704-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Andy,

thank you for joining the discussion.

On 02.12.2014 08:36, Andy Yan wrote:
> Hi Vladimir:
>=20
>   I am working on convert imx-hdmi to dw_hdmi now:
>   https://lkml.org/lkml/2014/12/1/190
>   I also have a plan to use  the internal HDMI I2C master under the I=
2c=20
> framework,
> and I also have a patch to do this work. So glad to see your work.
>   Please also Cc me<and.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org> and Zubair.Kakakhel@imgte=
c.com,
> maybe Zubair also have interests on your future patch.
> On 2014=E5=B9=B412=E6=9C=8802=E6=97=A5 00:22, Philipp Zabel wrote:
>> Hi Vladimir,
>>
>> [Added Andy Yan to Cc:, because imx-hdmi->dw-hdmi]
>>
>> Am Montag, den 01.12.2014, 17:39 +0200 schrieb Vladimir Zapolskiy:
>>> On 01.12.2014 17:11, Philipp Zabel wrote:
>>>> Am Montag, den 01.12.2014, 16:54 +0200 schrieb Vladimir Zapolskiy:
>>>>> Hi Philipp and Shawn,
>>>>>
>>>>> On 15.11.2014 19:49, Vladimir Zapolskiy wrote:
>>>>>> Provide information about how to bind internal iMX6Q/DL HDMI DDC=
 I2C
>>>>>> master controller. The property is set as optional one, because =
iMX6
>>>>>> HDMI DDC bus may be represented by one of general purpose I2C bu=
sses
>>>>>> found on SoC.
>>>>>>
>>>>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org=
>
>>>>>> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
>>>>>> Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>>>>>> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> Cc: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>>>>>> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> ---
>>>>>>   Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt |  =
 10 +++++++++-
>>>>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/staging/imx-drm/h=
dmi.txt b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
>>>>>> index 1b756cf..43c8924 100644
>>>>>> --- a/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
>>>>>> +++ b/Documentation/devicetree/bindings/staging/imx-drm/hdmi.txt
>>>>>> @@ -10,6 +10,8 @@ Required properties:
>>>>>>    - #address-cells : should be <1>
>>>>>>    - #size-cells : should be <0>
>>>>>>    - compatible : should be "fsl,imx6q-hdmi" or "fsl,imx6dl-hdmi=
".
>>>>>> +   If internal HDMI DDC I2C master controller is supposed to be=
 used,
>>>>>> +   then "simple-bus" should be added to compatible value.
>>>>>>    - gpr : should be <&gpr>.
>>>>>>      The phandle points to the iomuxc-gpr region containing the =
HDMI
>>>>>>      multiplexer control register.
>>>>>> @@ -22,6 +24,7 @@ Required properties:
>>>>>>  =20
>>>>>>   Optional properties:
>>>>>>    - ddc-i2c-bus: phandle of an I2C controller used for DDC EDID=
 probing
>>>>>> + - ddc: internal HDMI DDC I2C master controller
>>>>>>  =20
>>>>>>   example:
>>>>>>  =20
>>>>>> @@ -32,7 +35,7 @@ example:
>>>>>>           hdmi: hdmi@0120000 {
>>>>>>                   #address-cells =3D <1>;
>>>>>>                   #size-cells =3D <0>;
>>>>>> -                compatible =3D "fsl,imx6q-hdmi";
>>>>>> +                compatible =3D "fsl,imx6q-hdmi", "simple-bus";
>>>>>>                   reg =3D <0x00120000 0x9000>;
>>>>>>                   interrupts =3D <0 115 0x04>;
>>>>>>                   gpr =3D <&gpr>;
>>>>>> @@ -40,6 +43,11 @@ example:
>>>>>>                   clock-names =3D "iahb", "isfr";
>>>>>>                   ddc-i2c-bus =3D <&i2c2>;
>>>>>>  =20
>>>>>> +                hdmi_ddc: ddc {
>>>>>> +                        compatible =3D "fsl,imx6q-hdmi-ddc";
>>>>>> +                        status =3D "disabled";
>>>>>> +                };
>>>>>> +
>>>>>>                   port@0 {
>>>>>>                           reg =3D <0>;
>>>>>>  =20
>>>>>>
>>>>> knowing in advance that I2C framework lacks a graceful support of=
 non
>>>>> fully compliant I2C devices, do you have any objections to the pr=
oposed
>>>>> iMX HDMI DTS change?
>>>> I'm not sure about this. Have you seen "drm: Decouple EDID parsing=
 from
>>>> I2C adapter"? I feel like in the absence of a ddc-i2c-bus property=
 the
>>>> imx-hdmi/dw-hdmi driver should try to use the internal HDMI DDC I2=
C
>>>> master controller, bypassing the I2C framework altogether.
>>>>
>>> My idea is exactly not to bypass the I2C framework, briefly the
>>> rationale is that
>>> * it allows to reuse I2C UAPI/tools naturally applied to the intern=
al
>>> iMX HDMI DDC bus,
>>> * it allows to use iMX HDMI DDC bus as an additional feature-limite=
d I2C
>>> bus on SoC (who knows, I absolutely won't be surprised, if anyone n=
eeds
>>> it on practice),
>>> * if an HDMI controller supports an external I2C bus, the integrati=
on
>>> with HDMI DDC bus driver based on I2C framework is seamless.
>>>
>>> However I agree that the selected approach may look odd, the questi=
on is
>>> if the oddness comes from the technical side or from the fact that
>>> nobody has done it before this way.
>>>
>>> I'm open to any critique, if the proposal of creating an I2C bus fr=
om
>>> HDMI DDC bus is lame, then I suppose the shared iMX HDMI DDC bus dr=
iver
>>> should be converted to something formless and internally used by
>>> imx-hdmi. The negative side-effects of such a change from my point =
of
>>> view are
>>> * more or less natural modularity is lost,
>>> * a number of I2C framework API/functions should be copy-pasted to =
the
>>> updated HDMI DDC bus driver to support a subset of I2C read/write
>>> transactions.
>> If Wolfram is happy to accomodate such feature limited, 'I2C master'
>> devices in i2c/drivers/busses in principle, I won't disagree.
>>
>> But then it should be abstracted properly. The dw-hdmi-tx core on i.=
MX6
>> has the DDC I2C master register space at 0x7e00 - 0x7e12. What are t=
he
>> offsets on the Rockchip version? If the "simple-bus" compatible is t=
o be
>> set on the hdmi driver, the ddc driver should do its own register
>> access, and therefore needs a reg property. I suspect for the ddc-i2=
cm
>> we should get away with a common compatible like "snps,dw-hdmi-i2c".
>>
>> 	hdmi: hdmi@120000 {
>> 		/* ... */
>> 		compatible =3D "fsl,imx6q-hdmi", "snps,dw-hdmi";
>> 		ddc-i2c-bus =3D <&hdmi_ddc>;
>>
>> 		hdmi_ddc: i2c@127e00 {
>> 			compatible =3D "snps,dw-hdmi-i2c";
>> 			reg =3D <0x1207e00 0x13>
>> 		};
>>
>> 		/* could add phy-i2cm, cec, ... here */
>> 	};
>>
>> Also there's an i2c bus for communication with the phy at 0x3020 -
>> 0x3032, should that be handled in a similar way, then?
>=20
>     Rockchip RK3288 has the same DDC I2C master and phy i2c master
>     register offset as imx hdmi.

Good to know, I was not aware of it. Definitely it should be supported
as well.

>      what my suggestion is: make the ddc-i2c-bus property optional, i=
f=20
> the dw_hdmi driver
>     can't found the ddc-i2c-bus node, then use the internal i2cm:
>         ddc_node =3D of_parse_phandle(np, "ddc-i2c-bus", 0);
>          if (ddc_node) {
>                  hdmi->ddc =3D of_find_i2c_adapter_by_node(ddc_node);
>                  of_node_put(ddc_node);
>                  if (!hdmi->ddc) {
>                          dev_dbg(hdmi->dev, "failed to read ddc node\=
n");
>                          return -EPROBE_DEFER;
>                  }
>=20
>          } else {
>                  hdmi->ddc =3D dw_hdmi_ddc_adapter_register(hdmi).
>          }
>=20
>          and we can have a file put with dw_hdmi.c in a same dir, whi=
ch
>         implement  standard i2c adapter interface .
>        I found that other hdmi platform such as msm(/msm/hdmi/hdmi_i2=
c.c) ,
>        radeon(radeon_i2c.c) also do like this

Thank you for references.

I see that msm and a number of other DRM device drivers (radeon,
nouveau, i915, gma500) quite resemble the situation, now I'm convinced
that the same should be done for iMX6/RK3288 HDMI driver. In background
I'll try to review all out of i2c/busses/* registered i2c adapters, may
be there is something in common between all of them.

I'll prepare the change of the HDMI DDC support for review (will be abl=
e
to test it only on iMX6), Wolfram, please skip from your consideration
the published version of the i2c bus driver.

Wolfram, by the way is I2C_CLASS_DDC adapter class in operational use o=
r
deprecated?

>=20
>>
>> Do we need to make the hdmi driver a proper interrupt controller? At
>> least the two i2c masters have two interrupts each, "done" and "erro=
r".
>>
>> regards
>> Philipp
>>


--
With best wishes,
Vladimir
