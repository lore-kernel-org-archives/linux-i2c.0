From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Mon, 22 Sep 2014 17:23:13 +0300
Message-ID: <20140922142313.GD1786@lahna.fi.intel.com>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140920093633.GG1612@katana>
 <20140922091207.GJ1786@lahna.fi.intel.com>
 <20140922122905.GA13321@ab42.lan>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA425@IN01WEMBXA.internal.synopsys.com>
 <20140922140020.GB1786@lahna.fi.intel.com>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA47D@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230753C5DA47D-uUKrqVzojAgF5QVroWrzJvufCSb+aD3WLzEdoUbNIic@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, Sep 22, 2014 at 02:16:25PM +0000, Vineet Gupta wrote:
> On Monday 22 September 2014 07:30 PM, Mika Westerberg wrote:
> >>> COMMON_CLK is not selected by the ARC architecture in general. However,
> >>> > > we do select COMMON_CLK in the TB10x platform which uses the designware
> >>> > > I2C driver so this new dependency is no problem for us.
> >>> > >
> >>> > > Vineet,
> >>> > >
> >>> > > Do you see any issues with this on other existing ARC platforms, e.g.
> >>> > > arcfpga?
> >> > 
> >> > So what needs to be done, COMMON_CLK needs to be defined in arch/arc/Kconfig ? And
> >> > if so why ?
> > Without COMMON_CLK, you are not able to select I2C_DESIGNWARE_PLATFORM
> > anymore. So if something on ARC depends on this driver then we either
> > need the COMMON_CLK there or figure out alternative way to fix Carl's
> > problem.
> 
> I have not seen the orig patch, but it seems COMMON_CLK is already being selected
> by TB10x, do we still need it in arch/arcKconfig, for all ARC platforms ?

Only if the driver is being used by something else than TB10x on ARC. So
that we don't cause regressions to existing users.
