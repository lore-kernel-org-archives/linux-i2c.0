From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c: designware: Add support for AMD I2C controller
Date: Tue, 7 Oct 2014 11:30:04 +0200
Message-ID: <20141007093004.GB30162@ab42.lan>
References: <1411032367-20274-1-git-send-email-mika.westerberg@linux.intel.com>
 <1411032367-20274-2-git-send-email-mika.westerberg@linux.intel.com>
 <20140920093633.GG1612@katana>
 <20140922091207.GJ1786@lahna.fi.intel.com>
 <20140922122905.GA13321@ab42.lan>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA425@IN01WEMBXA.internal.synopsys.com>
 <20140922140020.GB1786@lahna.fi.intel.com>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA47D@IN01WEMBXA.internal.synopsys.com>
 <20140922172251.GA30685@ab42.lan>
 <5424E27C.2090302@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5424E27C.2090302-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Vineet,

On Fri, Sep 26, 2014 at 09:20:20AM +0530, Vineet Gupta wrote:
> Hi Chrisitian,
> 
> On Monday 22 September 2014 10:53 PM, Christian Ruppert wrote:
> > If there is no designware i2c in any of your platforms, simply ignore
> > my message. From my point of view there is no need to move "select
> > COMMON_CLK" up to the ARC architecture level.
> 
> I still ended up moving COMMON_CLK out of tb10x to arch/arc - due to consolidation
> of .init_machine() callbacks - from platform to arc core.
> 
> Give linux-next a spin (perhaps later today as I just pushed a build error in that
> area).
> 
> You'll like the almost empty platform file :-)

This looks very nice indeed. Support for "standard" platforms is simple
and elegant. The fact that most platforms won't need any specific
support code at all (apart from drivers) goes well with the idea of
device tree.  However, the kernel-doc comment for init_machine in
mach_desc.h is now slightly confusing (still mentioning device tree).

With this patch there remains only a single detail we need to manage
through platform-specific code: the reset handler. Today we still
provide a patch for the machine_restart function in reset.c to our
customers so that rebooting from the command line works. Do you have any
plans/ideas to fix this one as well?

Greetings,
  Christian
