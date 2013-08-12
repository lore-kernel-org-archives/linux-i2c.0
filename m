From: Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller support
Date: Mon, 12 Aug 2013 12:04:46 -0500
Message-ID: <5D9E26D4-6273-45CD-B79E-62865F6C5991@codeaurora.org>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com> <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net> <20130812164354.GF27165@e106331-lin.cambridge.arm.com> <1672769.GMC6E5TsBH@flatron>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1672769.GMC6E5TsBH@flatron>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Li Xiaochun-B41219 <B41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Jin Zhengxiong-R64188 <R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lu Jingchang-B35083 <B35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


On Aug 12, 2013, at 11:59 AM, Tomasz Figa wrote:

> On Monday 12 of August 2013 17:43:54 Mark Rutland wrote:
>> [Adding other devicetree maintainers to Cc]
>>=20
>> On Mon, Aug 12, 2013 at 01:56:07PM +0100, Lu Jingchang-B35083 wrote:
>>> ________________________________________
>>>=20
>>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Mark Rutland [mark.rutland-5wv7dgnIgG8@public.gmane.org]
>>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2013=E5=B9=B48=E6=9C=8810=E6=
=97=A5 22:08
>>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Lu Jingchang-B35083
>>>> =E6=8A=84=E9=80=81: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; Estevam Fabio-R49496; Li Xi=
aochun-B41219;
>>>> s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Jin
>>>> Zhengxiong-R64188; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
>>>> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org =E4=B8=BB=E9=A2=98: Re: [PATC=
H v3 2/2] i2c:
>>>> imx: Add Vybrid VF610 I2C controller support> >
>>>> On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
>>>>>  Add Freescale Vybrid VF610 I2C controller support to
>>>>>=20
>>>>> imx I2C driver framework.
>>>>>=20
>>>>>  Some operation is different from imx I2C controller.
>>>>>=20
>>>>> The register offset, the i2c clock divider value table,
>>>>> the module enabling(I2CR_IEN) which is just invert with imx,
>>>>> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
>>>>> but w0c on imx.
>>>>>=20
>>>>> Signed-off-by: Jason Jin <Jason.jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>>> Signed-off-by: Xiaochun Li <b41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>>> Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
>>>>> ---
>>>>>=20
>>>>> changes in v3:
>>>>>  Using struct naming the i2c clock {div, regval} pair.
>>>>>=20
>>>>> Using address shift handling registers address difference.
>>>>>=20
>>>>> changes in v2:
>>>>>  Fix building section mismatch(es) warning.
>>>>>=20
>>>>> drivers/i2c/busses/i2c-imx.c | 146
>>>>> ++++++++++++++++++++++++++++++++++++------- 1 file changed, 122
>>>>> insertions(+), 24 deletions(-)
>>>>=20
>>>> [...]
>>>>=20
>>>>> @@ -145,6 +233,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype=
);
>>>>>=20
>>>>> static const struct of_device_id i2c_imx_dt_ids[] =3D {
>>>>>=20
>>>>>        { .compatible =3D "fsl,imx1-i2c", .data =3D
>>>>>        &imx_i2c_devtype[IMX1_I2C], },
>>>>>        { .compatible =3D "fsl,imx21-i2c", .data =3D
>>>>>        &imx_i2c_devtype[IMX21_I2C], },> >>=20
>>>>> +       { .compatible =3D "fsl,vf610-i2c", .data =3D
>>>>> &imx_i2c_devtype[VF610_I2C], },> >>=20
>>>>>        { /* sentinel */ }
>>>>>=20
>>>>> };
>>>>=20
>>>> That string doesn't seem to be documented anywhere (from a quick g=
rep
>>>> of Documentation/devicetree), and there's no binding update includ=
ed
>>>> here. It would be nice for that to be fixed :)
>>>=20
>>> [Lu Jingchang]
>>> The binding string for i2c-imx driver in
>>> Documentation/devicetree/bindings/i2c/i2c-imx.txt use a wildcard
>>> format of "- compatible : Should be "fsl,<chip>-i2c" " for device
>>> using this driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c is
>>> described in the binding document. So I just leave the vf610 i2c
>>> compatible with this.
>> I'm not a big fan on wildcards in bindings, as it leaves people free=
 to
>> put anything in and claim it's a documented binding, and makes it fa=
r
>> harder for an os to actually implement drivers for said binding, as
>> there's no canonical reference for the set of valid variations.
>>=20
>> Obviously there is some precedent, but I'm not sure it's something w=
e
>> want to stick with, and we can prevent it my updating the documentat=
ion
>> now.
>>=20
>> Does anyone else have an opinion?
>=20
> In case of Samsung platforms we decided to always use the name of fir=
st=20
> SoC in which given IP appeared and list all compatible SoCs in bindin=
g=20
> documentation. This is IMHO the most consistent way, as there is no=20
> confusion about IP versions (not always listed in documentation, not =
even=20
> saying about unavailable documentation) or potential problems with ne=
w=20
> SoCs matching the wildcard, but having different IP.
>=20
> In this particular case, the <chip> wildcard can be easily transforme=
d=20
> into a non-wildcard binding, by listing all supported <chip> values, =
i.e.=20
> adding following text to binding documentation:
>=20
> 8<--
> The <chip> can be one of:
> - imx1 - for i.MX1 and compatible SoCs,
> - imx21 - for i.MX21 and compatible SoCs,
> - vf610 - for Vybrid VF610 and compatible SoCs.
> -->8
>=20
> Best regards,
> Tomasz


One way to handle this is to introduce a SoC Family <chip> name doc wit=
h the possible list of names and than reference that doc in the binding=
=2E  Kinda like how we have vendor-prefixes.txt.

And maybe instead of doing <chip> its <imx-chip> or some reference that=
 isn't too generic such that in the future a .dts could be validated.

- k

--
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
