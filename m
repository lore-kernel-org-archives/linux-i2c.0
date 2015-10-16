From: Hu Vincent <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH V4 4/6] arm64/ls1043a: add DTS for Freescale LS1043A SoC
Date: Fri, 16 Oct 2015 03:04:53 +0000
Message-ID: <BN3PR0301MB124963B6511767567A4409BD843D0@BN3PR0301MB1249.namprd03.prod.outlook.com>
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
 <1444911181-21696-4-git-send-email-B48286@freescale.com>
 <1444941949.5185.270.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444941949.5185.270.camel@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Scott Wood <scottwood@freescale.com>, Hou Zhiqiang <B48286@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "corbet@lwn.net" <corbet@lwn.net>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "wsa@the-dreams.de" <wsa@the-dreams.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "will.deacon@arm.com" <will.deacon@arm.com>, Sharma Bhupesh <bhupesh.sharma@freescale.com>, "wim@iguana.be" <wim@iguana.be>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wenbin Song <Wenbin.Song@freescale.com>, Li Leo <LeoLi@freescale.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: linux-i2c@vger.kernel.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, October 16, 2015 4:46 AM
> To: Hou Zhiqiang-B48286
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> will.deacon@arm.com; linux-i2c@vger.kernel.org; linux-
> watchdog@vger.kernel.org; linux-doc@vger.kernel.org; linux-
> clk@vger.kernel.org; mark.rutland@arm.com; linux@roeck-us.net; wsa@the-
> dreams.de; wim@iguana.be; corbet@lwn.net; mturquette@baylibre.com;
> sboyd@codeaurora.org; Hu Mingkai-B21284; Xie Shaohui-B21989; Sharma
> Bhupesh-B45370; Song Wenbin-B53747; Li Yang-Leo-R58472; Sharma Bhupesh-
> B45370
> Subject: Re: [PATCH V4 4/6] arm64/ls1043a: add DTS for Freescale LS1043A
> SoC
> 
> On Thu, 2015-10-15 at 20:12 +0800, Zhiqiang Hou wrote:
> > From: Mingkai Hu <Mingkai.Hu@freescale.com>
> >
> > LS1043a is an SoC with 4 ARMv8 A53 cores and most other IP blocks
> > similar to LS1021a which complies to Chassis 2.1 spec.
> >
> > Following levels of DTSI/DTS files have been created for the LS1043A
> > SoC family:
> >
> > - fsl-ls1043a.dtsi:
> >   DTS-Include file for FSL LS1043A SoC.
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> > Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
> > Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> > ---
> > V4:
> >  - Add soc node with simple-bus compatible.
> >  - Add property interrupt-affinity for armv8 pmuv3 node.
> >
> > V3:
> >  - Add device tree node for SATA.
> >  - Remove properity enable-method for all cpu node.
> >    Remove reserved memory region for spin-table.
> >
> > V2:
> >  - Add secondary core boot method.
> >  - Move out the sysclk node from the clockgen node.
> >  - Correct the reg size of GICC.
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 525
> > +++++++++++++++++++++++++
> >  1 file changed, 525 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > new file mode 100644
> > index 0000000..1a5bf79
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> > @@ -0,0 +1,525 @@
> > +/*
> > + * Device Tree Include file for Freescale Layerscape-1043A family SoC.
> > + *
> > + * Copyright 2014-2015, Freescale Semiconductor
> > + *
> > + * Mingkai Hu <Mingkai.hu@freescale.com>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPLv2 or the X11 license, at your option. Note that this
> > +dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This library is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of
> the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This library is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +/ {
> > +     compatible = "fsl,ls1043a";
> > +     interrupt-parent = <&gic>;
> > +     #address-cells = <2>;
> > +     #size-cells = <2>;
> > +
> > +     cpus {
> > +             #address-cells = <2>;
> > +             #size-cells = <0>;
> > +
> > +             /*
> > +              * We expect the enable-method for cpu's to be "psci",
> but this
> > +              * is dependent on the SoC FW, which will fill this in.
> > +              *
> > +              * Currently supported enable-method is psci v0.2
> > +              */
> > +             cpu0:  cpu@0{
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x0>;
> > +                     clocks = <&clockgen 1 0>;
> > +             };
> > +
> > +             cpu1:  cpu@1{
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x1>;
> > +                     clocks = <&clockgen 1 0>;
> > +             };
> > +
> > +             cpu2:  cpu@2{
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x2>;
> > +                     clocks = <&clockgen 1 0>;
> > +             };
> > +
> > +             cpu3:  cpu@3{
> > +                     device_type = "cpu";
> > +                     compatible = "arm,cortex-a53";
> > +                     reg = <0x0 0x3>;
> > +                     clocks = <&clockgen 1 0>;
> > +             };
> > +     };
> > +
> > +      memory@80000000{
> > +             device_type = "memory";
> > +             reg = <0x0 0x80000000 0 0x80000000>;
> > +                   /* DRAM space 1, size: 2GiB DRAM */
> > +     };
> > +
> > +     sysclk: sysclk {
> > +             compatible = "fixed-clock";
> > +             #clock-cells = <0>;
> > +             clock-frequency = <100000000>;
> > +             clock-output-names = "sysclk";
> > +     };
> > +
> > +     soc {
> > +             compatible = "simple-bus";
> > +             #address-cells = <2>;
> > +             #size-cells = <2>;
> > +             ranges;
> > +
> > +             clockgen:  clocking@1ee1000{
> > +                     compatible = "fsl,ls1043a-clockgen";
> > +                     reg = <0x0 0x1ee1000 0x0 0x1000>;
> > +                     #clock-cells = <2>;
> > +                     clocks = <&sysclk>;
> > +             };
> > +
> > +             timer {
> > +                     compatible = "arm,armv8-timer";
> > +                     interrupts = <1 13 0x1>, /* Physical Secure PPI
> */
> > +                                  <1 14 0x1>, /* Physical Non-Secure
> PPI */
> > +                                  <1 11 0x1>, /* Virtual PPI */
> > +                                  <1 10 0x1>; /* Hypervisor PPI */
> > +             };
> > +
> > +             pmu {
> > +                     compatible = "arm,armv8-pmuv3";
> > +                     interrupts = <0 106 0x4>,
> > +                                  <0 107 0x4>,
> > +                                  <0 95 0x4>,
> > +                                  <0 97 0x4>;
> > +                     interrupt-affinity = <&cpu0>,
> > +                                          <&cpu1>,
> > +                                          <&cpu2>,
> > +                                          <&cpu3>;
> > +             };
> > +
> > +             gic:  interrupt-controller@1400000{
> > +                     compatible = "arm,gic-400";
> > +                     #interrupt-cells = <3>;
> > +                     interrupt-controller;
> > +                     reg = <0x0 0x1401000 0 0x1000>, /* GICD */
> > +                           <0x0 0x1402000 0 0x2000>, /* GICC */
> > +                           <0x0 0x1404000 0 0x2000>, /* GICH */
> > +                           <0x0 0x1406000 0 0x2000>; /* GICV */
> > +                     interrupts = <1 9 0xf08>;
> > +             };
> 
> The recently posted ls2080 device tree patch puts pmu, gic, etc. under
> the root node rather than the soc node.  Where should they go?  At least
> it should be consistent...
> 

There is also discussion between Ron and Stuart about this, but no conclusion about where to put pmu, gic node.
Is there any specific reason to put them out of the SoC?

Thanks,
Mingkai
