From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch v1] i2c: imx: add runtime pm support to improve the
 performance
Date: Thu, 18 Jun 2015 06:15:08 +0000
Message-ID: <CY1PR0301MB0858015F5009D9A3CA480C04CFA50@CY1PR0301MB0858.namprd03.prod.outlook.com>
References: <1433987404-28957-1-git-send-email-b54642@freescale.com>
 <20150617214839.GG20984@pengutronix.de>
 <CY1PR0301MB0858E745717A1A7317909A2FCFA50@CY1PR0301MB0858.namprd03.prod.outlook.com>
 <20150618042427.GA1611@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150618042427.GA1611@katana>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: Wolfram Sang <mailto:wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org> sent: Thursday, June 18=
, 2015 12:24 PM
> To: Gao Pan-B54642
> Cc: Uwe Kleine-K=F6nig; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; D=
uan
> Fugang-B38611
> Subject: Re: [Patch v1] i2c: imx: add runtime pm support to improve t=
he
> performance
>=20
> > > > +	if (pm_runtime_suspended(i2c_imx->adapter.dev.parent))
> > > > +		return IRQ_NONE;
> > > > +
> > > I don't claim to understand the runtime pm stuff, but I agree to =
the
> > > previous reviewer that this smells fishy. If this is required it
> > > needs a comment why.
> > >
> > In fact, I agree you two reviewers' consideration. As I said, this =
is
> just to avoid system hang in worse case.
> > Of course, I still don't catch the worse case. So I will remove thi=
s pm
> stuff.
>=20
> So, there is a worst case where the system can hang now which is not
> present in the current version of this driver (i.e. before your patch=
)?

Hi, Wolfram,

Before the patch, I don't catch the issue on Fsl engineer platforms.
But I remembered I supported one automotive customer that in their user=
 case the issue can be reproduced in long term stress test.

Anyway, I prefer to remove the pm staff in here.

Thanks for your review. I will send the V2 patch.
