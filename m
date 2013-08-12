From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: =?UTF-8?B?562U5aSNOiBbUEFUQ0ggdjMgMi8yXSBpMmM6IGlteDogQWRkIFY=?=
 =?UTF-8?B?eWJyaWQgVkY2MTAgSTJDIGNvbnRyb2xsZXIgc3VwcG9ydA==?=
Date: Mon, 12 Aug 2013 17:23:35 -0600
Message-ID: <52096E77.4040003@wwwdotorg.org>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com> <1375418648-22760-2-git-send-email-b35083@freescale.com> <20130810140827.GC18085@e106331-lin.cambridge.arm.com> <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net> <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130812164354.GF27165-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Lu Jingchang-B35083 <B35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Xiaochun-B41219 <B41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jin Zhengxiong-R64188 <R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On 08/12/2013 10:43 AM, Mark Rutland wrote:
> [Adding other devicetree maintainers to Cc]
>=20
> On Mon, Aug 12, 2013 at 01:56:07PM +0100, Lu Jingchang-B35083 wrote:
>>
>> ________________________________________
>>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Mark Rutland [mark.rutland-5wv7dgnIgG8@public.gmane.org]
>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2013=E5=B9=B48=E6=9C=8810=E6=97=
=A5 22:08
>>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Lu Jingchang-B35083
>>> =E6=8A=84=E9=80=81: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; Estevam Fabio-R49496; Li Xia=
ochun-B41219; s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Jin Zh=
engxiong-R64188; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-arm-kernel-IAPFreCvJWM1dQTEkxZZdg@public.gmane.org=
=2Eorg
>>> =E4=B8=BB=E9=A2=98: Re: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I=
2C controller support
>>
>>> On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
>>>>   Add Freescale Vybrid VF610 I2C controller support to
>>>> imx I2C driver framework.
>>>>   Some operation is different from imx I2C controller.
>>>> The register offset, the i2c clock divider value table,
>>>> the module enabling(I2CR_IEN) which is just invert with imx,
>>>> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
>>>> but w0c on imx.

>>>>  static const struct of_device_id i2c_imx_dt_ids[] =3D {
>>>>         { .compatible =3D "fsl,imx1-i2c", .data =3D &imx_i2c_devty=
pe[IMX1_I2C], },
>>>>         { .compatible =3D "fsl,imx21-i2c", .data =3D &imx_i2c_devt=
ype[IMX21_I2C], },
>>>> +       { .compatible =3D "fsl,vf610-i2c", .data =3D &imx_i2c_devt=
ype[VF610_I2C], },
>>>
>>> That string doesn't seem to be documented anywhere (from a quick gr=
ep of
>>> Documentation/devicetree), and there's no binding update included
>>> here. It would be nice for that to be fixed :)
>>
>> [Lu Jingchang]
>> The binding string for i2c-imx driver in Documentation/devicetree/bi=
ndings/i2c/i2c-imx.txt use a wildcard format
>> of "- compatible : Should be "fsl,<chip>-i2c" " for device using thi=
s driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c
>> is described in the binding document. So I just leave the vf610 i2c =
compatible with this.=20
>=20
> I'm not a big fan on wildcards in bindings, as it leaves people free =
to
> put anything in and claim it's a documented binding, and makes it far
> harder for an os to actually implement drivers for said binding, as
> there's no canonical reference for the set of valid variations.
>=20
> Obviously there is some precedent, but I'm not sure it's something we
> want to stick with, and we can prevent it my updating the documentati=
on
> now.
>=20
> Does anyone else have an opinion?

I suppose technically we should list out every exact string in the
binding, but it's a little annoying to have to update the binding doc
every time a new chip comes out (and I expect that'll happen more and
more!) just to add a new compatible value since all the differences are
known internally to the driver and don't impact the binding...

Kumar's idea could be a reasonable compromise, although I guess it
doesn't technically cover the case of there being 10 chips, each of
which has *some* new/different IP block, yet some IP blocks not changin=
g
in every chip, and hence drivers might only directly binding to 5 of th=
e
10 possible compatible values in some cases...
