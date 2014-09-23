From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Tue, 23 Sep 2014 13:05:59 +0300
Message-ID: <20140923100559.GJ1786@lahna.fi.intel.com>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140920093633.GG1612@katana>
 <20140922091207.GJ1786@lahna.fi.intel.com>
 <20140922122905.GA13321@ab42.lan>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA425@IN01WEMBXA.internal.synopsys.com>
 <20140922140020.GB1786@lahna.fi.intel.com>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA47D@IN01WEMBXA.internal.synopsys.com>
 <20140922172251.GA30685@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140922172251.GA30685-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Viresh Kumar <viresh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Tang <tangrs-wZPxy8ob7RQXC2x5gXVKYQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 22, 2014 at 07:22:52PM +0200, Christian Ruppert wrote:
> On Mon, Sep 22, 2014 at 02:16:25PM +0000, Vineet Gupta wrote:
> > On Monday 22 September 2014 07:30 PM, Mika Westerberg wrote:
> > >>> COMMON_CLK is not selected by the ARC architecture in general. However,
> > >>> > > we do select COMMON_CLK in the TB10x platform which uses the designware
> > >>> > > I2C driver so this new dependency is no problem for us.
> > >>> > >
> > >>> > > Vineet,
> > >>> > >
> > >>> > > Do you see any issues with this on other existing ARC platforms, e.g.
> > >>> > > arcfpga?
> > >> > 
> > >> > So what needs to be done, COMMON_CLK needs to be defined in arch/arc/Kconfig ? And
> > >> > if so why ?
> > > Without COMMON_CLK, you are not able to select I2C_DESIGNWARE_PLATFORM
> > > anymore. So if something on ARC depends on this driver then we either
> > > need the COMMON_CLK there or figure out alternative way to fix Carl's
> > > problem.
> > 
> > I have not seen the orig patch, but it seems COMMON_CLK is already being selected
> > by TB10x, do we still need it in arch/arcKconfig, for all ARC platforms ?
> 
> Sorry for the confusion, I should have given you some context. Mika
> has checked that designware i2c is used by some ARC platforms but he
> didn't say which ones. The orig patch makes COMMON_CLK a requirement for
> designware i2c.

Yeah, sorry about not mentioning the affected platforms. I've included
them now in this email.

> I checked that we're fine for TB10x (we need COMMON_CLK anyway) but
> since you weren't in copy I just wanted to make sure that none of the
> other ARC platforms (which don't seem to select COMMON_CLK) use
> designware i2c and thus run into trouble.
> 
> If there is no designware i2c in any of your platforms, simply ignore
> my message. From my point of view there is no need to move "select
> COMMON_CLK" up to the ARC architecture level.

I grepped for snps,i2c-designware from the kernel source tree and this
is what I found:

Only ARC that is using the driver:

 arch/arc/boot/dts/abilis_tb10x.dtsi -> OK

Two ARMs that pass clock to the driver:

 arch/arm/boot/dts/berlin2q.dtsi -> OK
 arch/arm/boot/dts/socfpga.dts -> OK

Following files have the designware driver listed but it seems to be
disabled and does not get any clocks:

 arch/arm/boot/dts/nspire-cx.dts

 arch/arm/boot/dts/spear1310.dtsi
 arch/arm/boot/dts/spear320.dtsi
 arch/arm/boot/dts/spear3xx.dtsi
 arch/arm/boot/dts/spear600.dtsi

I think we are good to go with the first three but not sure about the
last five. Adding Viresh Kumar and Daniel Tang to the thread.

Viresh, Daniel,

The thread is here http://patchwork.ozlabs.org/patch/390695/.

In summary, we are adding COMMON_CLK dependency to the
i2c-designware-platdrv.c in order to get clocks to one AMD DW based host
controller and wanted to check that we don't break the existing users
(nspire and SPEAR).
