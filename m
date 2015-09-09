From: Gao Pandy <gaopan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [Patch V7] i2c: imx: add runtime pm support to improve the
 performance
Date: Wed, 9 Sep 2015 02:04:21 +0000
Message-ID: <DM2PR0301MB0863BC897E580DD128DEA821CF520@DM2PR0301MB0863.namprd03.prod.outlook.com>
References: <1441006353-874-1-git-send-email-b54642@freescale.com>
 <20150907211814.GI14598@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150907211814.GI14598-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Li Frank <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Duan Andy <fugang.duan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

=46rom: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <mailto:linux-i2c-owner-fy+rA21nqHI@public.gmane.org=
rnel.org> On Behalf Of Uwe Kleine-K?nig Sent: Tuesday, September 08, 20=
15 5:18 AM
> To: Gao Pan-B54642
> Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Li Frank-B20596; Du=
an
> Fugang-B38611; kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org; hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Subject: Re: [Patch V7] i2c: imx: add runtime pm support to improve t=
he
> performance
>=20
> Hello,
>=20
> On Mon, Aug 31, 2015 at 03:32:33PM +0800, Gao Pan wrote:
> > In our former i2c driver, i2c clk is enabled and disabled in xfer
> > function, which contributes to power saving. However, the clk enabl=
e
> > process brings a busy wait delay until the core is stable. As a
> > result, the performance is sacrificed.
> >
> > To weigh the power consumption and i2c bus performance, runtime pm =
is
> > the good solution for it. The clk is enabled when a i2c transfer
> > starts, and disabled after a specifically defined delay.
> >
> > Without the patch the test case (many eeprom reads) executes with
> approx:
> > real 1m7.735s
> > user 0m0.488s
> > sys 0m20.040s
> >
> > With the patch the same test case (many eeprom reads) executes with
> approx:
> > real 0m54.241s
> > user 0m0.440s
> > sys 0m5.920s
> >
> > Signed-off-by: Fugang Duan <B38611-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > Signed-off-by: Gao Pan <b54642-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > [wsa: fixed some indentation]
> > Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Hmm, why does this already have a S-o-b from Wolfram?
>=20
> Other than that I don't have any caveats to enter any more, but given
> that I don't have much clue about runtime pm this doesn't mean much.
=20
Thank you, I unintentionally added Wolfram to the S-o-b. This patch was=
 accepted after Wolfram fixed some indentation by V3.
Afterwards, Heiner Kallweit found some problems. So the following versi=
ons mainly resolve the problems found by Heiner Kallweit.

I will resend the this patch with S-o-b from Wolfram deleted.=20

> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 | http://www.pengutronix.d=
e/
> |
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo inf=
o at
> http://vger.kernel.org/majordomo-info.html
