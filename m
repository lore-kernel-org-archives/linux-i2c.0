From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQw==?=
	=?utf-8?Q?H?= v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller
 support
Date: Mon, 12 Aug 2013 17:43:54 +0100
Message-ID: <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B56CDBE15CE27145A4B77D2D24263E851FE7AC-TcFNo7jSaXM0vywKSws3iq4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lu Jingchang-B35083 <B35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Estevam Fabio-R49496 <r49496-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Xiaochun-B41219 <B41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jin Zhengxiong-R64188 <R64188-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, pawel.moll-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[Adding other devicetree maintainers to Cc]

On Mon, Aug 12, 2013 at 01:56:07PM +0100, Lu Jingchang-B35083 wrote:
>=20
> ________________________________________
> >=E5=8F=91=E4=BB=B6=E4=BA=BA: Mark Rutland [mark.rutland-5wv7dgnIgG8@public.gmane.org]
> >=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2013=E5=B9=B48=E6=9C=8810=E6=97=
=A5 22:08
> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Lu Jingchang-B35083
> >=E6=8A=84=E9=80=81: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; Estevam Fabio-R49496; Li Xiao=
chun-B41219; s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Jin Zhe=
ngxiong-R64188; shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XQ@public.gmane.org=
org
> >=E4=B8=BB=E9=A2=98: Re: [PATCH v3 2/2] i2c: imx: Add Vybrid VF610 I2=
C controller support
>=20
> >On Fri, Aug 02, 2013 at 05:44:08AM +0100, Jingchang Lu wrote:
> >>   Add Freescale Vybrid VF610 I2C controller support to
> >> imx I2C driver framework.
> >>   Some operation is different from imx I2C controller.
> >> The register offset, the i2c clock divider value table,
> >> the module enabling(I2CR_IEN) which is just invert with imx,
> >> and the interrupt flag(I2SR) clearing opcode is w1c on VF610
> >> but w0c on imx.
> >>
> >> Signed-off-by: Jason Jin <Jason.jin-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >> Signed-off-by: Xiaochun Li <b41219-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >> Signed-off-by: Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> >> ---
> >> changes in v3:
> >>   Using struct naming the i2c clock {div, regval} pair.
> >>  Using address shift handling registers address difference.
> >>
> >> changes in v2:
> >>   Fix building section mismatch(es) warning.
> >>
> >>  drivers/i2c/busses/i2c-imx.c | 146 ++++++++++++++++++++++++++++++=
++++++-------
> >>  1 file changed, 122 insertions(+), 24 deletions(-)
>=20
> >[...]
>=20
> >> @@ -145,6 +233,7 @@ MODULE_DEVICE_TABLE(platform, imx_i2c_devtype)=
;
> >>  static const struct of_device_id i2c_imx_dt_ids[] =3D {
> >>         { .compatible =3D "fsl,imx1-i2c", .data =3D &imx_i2c_devty=
pe[IMX1_I2C], },
> >>         { .compatible =3D "fsl,imx21-i2c", .data =3D &imx_i2c_devt=
ype[IMX21_I2C], },
> >> +       { .compatible =3D "fsl,vf610-i2c", .data =3D &imx_i2c_devt=
ype[VF610_I2C], },
> >>         { /* sentinel */ }
> >>  };
>=20
>=20
> >That string doesn't seem to be documented anywhere (from a quick gre=
p of
> >Documentation/devicetree), and there's no binding update included
> >here. It would be nice for that to be fixed :)
> [Lu Jingchang]
> The binding string for i2c-imx driver in Documentation/devicetree/bin=
dings/i2c/i2c-imx.txt use a wildcard format
> of "- compatible : Should be "fsl,<chip>-i2c" " for device using this=
 driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c
> is described in the binding document. So I just leave the vf610 i2c c=
ompatible with this.=20

I'm not a big fan on wildcards in bindings, as it leaves people free to
put anything in and claim it's a documented binding, and makes it far
harder for an os to actually implement drivers for said binding, as
there's no canonical reference for the set of valid variations.

Obviously there is some precedent, but I'm not sure it's something we
want to stick with, and we can prevent it my updating the documentation
now.

Does anyone else have an opinion?

Mark.
