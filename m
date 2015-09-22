From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Tue, 22 Sep 2015 23:15:04 +0100
Message-ID: <20150922221504.GA1497@svinekod>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CY1PR0301MB078008B10188504C951076498B450-YrwGdl+PljnwWZenWrSUgZwN6zqB+hSMnBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hou Zhiqiang <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shaohui Xie <Shaohui.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "corbet-T1hC0tSOHrs@public.gmane.org" <corbet-T1hC0tSOHrs@public.gmane.org>, Sharma Bhupesh <bhupesh.sharma-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org" <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org" <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org" <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>, Wenbin Song <Wenbin.Song-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Hu Vincent <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Li Leo <LeoLi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 22, 2015 at 10:50:21AM +0100, Hou Zhiqiang wrote:
> Hi Mark,
>=20
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland-5wv7dgnIgG8@public.gmane.org]
> > Sent: 2015=E5=B9=B49=E6=9C=8822=E6=97=A5 9:24
> > To: Hou Zhiqiang-B48286; marc.zyngier-5wv7dgnIgG8@public.gmane.org
> > Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Catalin Marinas; Will Dea=
con;
> > linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Xie Shaohui-B21989;
> > corbet-T1hC0tSOHrs@public.gmane.org; Sharma Bhupesh-B45370; mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org; wsa=
@the-
> > dreams.de; sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org; wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org; Song Wenbin-B53747;=
 Wood
> > Scott-B07421; Hu Mingkai-B21284; Li Yang-Leo-R58472
> > Subject: Re: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS104=
3A SoC
> >
> > Hi,
> >
> > > +/memreserve/ 0x80000000 0x00010000;
> >
> > Why is this necessary?
>=20
> This memory region is pre-reserved for the spin-table/psci, although =
didn't add
> Enable method of secondary cores.

Your PSCI implementation isn't in secure memory?

> > > +       ifc: ifc@1530000 {
> > > +               compatible =3D "fsl,ifc", "simple-bus";
> > > +               reg =3D <0x0 0x1530000 0x0 0x10000>;
> > > +               interrupts =3D <0 43 0x4>;
> > > +       };
> >
> > Why simple-bus?
>=20
> There are 3 child node located in dtsi file that should be created an=
d added
> to platform device list.

Are they usable even if the kernel knew nothing about the IFC node? If =
not, the
IFC driver should probe them, and simple-bus should go.

> > > +       memory@80000000 {
> > > +               device_type =3D "memory";
> > > +               reg =3D <0x0 0x80000000 0 0x80000000>;
> > > +                     /* DRAM space 1 - 2 GB DRAM */
> >
> > I don't understand the comment. This describes 2GB at 2GB.
> >
>=20
> Yes, there is a 2GB space for DRAM from address 2G.
> The DRAM address 0x0 will be remapped to SoC address 2G, this remap i=
s done by hardware.

I just realised my mistake -- I read this as "1 to 2 GB", when this is =
actually
"DRAM space 1". Sorry for the noise.

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
