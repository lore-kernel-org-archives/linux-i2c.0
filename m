From: Sharma Bhupesh <bhupesh.sharma@freescale.com>
Subject: RE: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Tue, 22 Sep 2015 19:04:56 +0000
Message-ID: <BY1PR0301MB1303F9A6F3B00F91C7B18C0682450@BY1PR0301MB1303.namprd03.prod.outlook.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-5-git-send-email-B48286@freescale.com>
 <20150922012403.GA1535@svinekod>
 <CY1PR0301MB078008B10188504C951076498B450@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <DM2PR0301MB07342356008C1A50AB26FEFFBA450@DM2PR0301MB0734.namprd03.prod.outlook.com>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Li Leo <LeoLi@freescale.com>, Hou Zhiqiang <B48286@freescale.com>, Mark Rutland <mark.rutland@arm.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Shaohui Xie <Shaohui.Xie@freescale.com>, "corbet@lwn.net" <corbet@lwn.net>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "wim@iguana.be" <wim@iguana.be>, Wenbin Song <Wenbin.Song@freescale.com>, Scott Wood <scottwood@freescale.com>, Hu Vincent <Mingkai.Hu@freescale.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Li Yang-Leo-R58472
> Sent: Tuesday, September 22, 2015 10:53 PM
> To: Hou Zhiqiang-B48286; Mark Rutland; marc.zyngier@arm.com
> Cc: linux-arm-kernel@lists.infradead.org; Catalin Marinas; Will Deacon;
> linux-i2c@vger.kernel.org; linux-watchdog@vger.kernel.org; linux-
> doc@vger.kernel.org; linux-clk@vger.kernel.org; Xie Shaohui-B21989;
> corbet@lwn.net; Sharma Bhupesh-B45370; mturquette@baylibre.com; wsa@the-
> dreams.de; sboyd@codeaurora.org; wim@iguana.be; Song Wenbin-B53747; Wood
> Scott-B07421; Hu Mingkai-B21284
> Subject: RE: [PATCH 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
> 
> > >
> > > Hi,
> > >
> > > > +/memreserve/ 0x80000000 0x00010000;
> > >
> > > Why is this necessary?
> >
> > This memory region is pre-reserved for the spin-table/psci, although
> > didn't add Enable method of secondary cores.
> 
> Can this be reserved by bootloader?

No need to reserve this for PSCI based secondary bootup.

> >
> > > If this is necessary, please add a comment stating what this is for.
> > >
> > > > +               cpu@3 {
> > > > +                       device_type = "cpu";
> > > > +                       compatible = "arm,cortex-a53";
> > > > +                       reg = <0x0 0x3>;
> > > > +                       clocks = <&clockgen 1 0>;
> > > > +               };
> > >
> > > Missing enable-method properties on all the secondary CPUs.
> > >
> >
> > There are two methods (spin-table and psci) to bring up secondary
> > cores, which one do you think is better?
> 
> Do we have the PSCI support ready in both UEFI and u-boot?  If not, we
> should use spin-table for now.

UEFI has been using PSCI with Arm Trusted Firmware (ATF) since some time. U-boot can also work with ATF seamlessly.

Spin-table method is deprecated and newer patches should support PSCI. If not, all intelligence should be left to the
Bootloader and the Linux DTS should not mention the 'enable-method' and the 'memreserve' regions. 

For details please see the LS2085A Freescale DTS already present in mainline kernel.

Regards,
Bhupesh
