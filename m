From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Mon, 29 Sep 2014 03:24:12 -0700
Message-ID: <CAOh2x=mBPDLMaz109wTxWMdv4ajYOgkREmLsETM+Wm+gg5ScMQ@mail.gmail.com>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
	<1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
	<20140920093633.GG1612@katana>
	<20140922091207.GJ1786@lahna.fi.intel.com>
	<20140922122905.GA13321@ab42.lan>
	<C2D7FE5348E1B147BCA15975FBA230753C5DA425@IN01WEMBXA.internal.synopsys.com>
	<20140922140020.GB1786@lahna.fi.intel.com>
	<C2D7FE5348E1B147BCA15975FBA230753C5DA47D@IN01WEMBXA.internal.synopsys.com>
	<20140922172251.GA30685@ab42.lan>
	<20140923100559.GJ1786@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140923100559.GJ1786-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Tang <tangrs-wZPxy8ob7RQXC2x5gXVKYQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Sep 23, 2014 at 3:05 AM, Mika Westerberg
<mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
>  arch/arm/boot/dts/spear1310.dtsi
>  arch/arm/boot/dts/spear320.dtsi
>  arch/arm/boot/dts/spear3xx.dtsi
>  arch/arm/boot/dts/spear600.dtsi
>
> I think we are good to go with the first three but not sure about the
> last five. Adding Viresh Kumar and Daniel Tang to the thread.
>
> Viresh, Daniel,
>
> The thread is here http://patchwork.ozlabs.org/patch/390695/.
>
> In summary, we are adding COMMON_CLK dependency to the
> i2c-designware-platdrv.c in order to get clocks to one AMD DW based host
> controller and wanted to check that we don't break the existing users
> (nspire and SPEAR).

A dependency on COMMON_CLK is fine for SPEAr .
