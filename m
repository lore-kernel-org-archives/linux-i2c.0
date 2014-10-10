From: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Subject: Re: arc platform code updates (was Re: [PATCH 2/2] i2c: designware:
 Add support for AMD I2C controller)
Date: Fri, 10 Oct 2014 11:13:57 +0200
Message-ID: <20141010091356.GA16492@ab42.lan>
References: <20140920093633.GG1612@katana>
 <20140922091207.GJ1786@lahna.fi.intel.com>
 <20140922122905.GA13321@ab42.lan>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA425@IN01WEMBXA.internal.synopsys.com>
 <20140922140020.GB1786@lahna.fi.intel.com>
 <C2D7FE5348E1B147BCA15975FBA230753C5DA47D@IN01WEMBXA.internal.synopsys.com>
 <20140922172251.GA30685@ab42.lan>
 <5424E27C.2090302@synopsys.com>
 <20141007093004.GB30162@ab42.lan>
 <C2D7FE5348E1B147BCA15975FBA230753C5E4C98@IN01WEMBXA.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA230753C5E4C98-uUKrqVzojAgF5QVroWrzJvufCSb+aD3WLzEdoUbNIic@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org" <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Carl Peng <carlpeng008-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Oct 07, 2014 at 12:35:29PM +0000, Vineet Gupta wrote:
> +CC Guenter Roeck
> [...]
> > However, the kernel-doc comment for init_machine in
> > mach_desc.h is now slightly confusing (still mentioning device tree).
> 
> A platform of future can still call of_platform_populate() etc to reparse the
> stuff for say it's platform devices !
> So I would think it is still relevant !

OK.

> > With this patch there remains only a single detail we need to manage
> > through platform-specific code: the reset handler. Today we still
> > provide a patch for the machine_restart function in reset.c to our
> > customers so that rebooting from the command line works. Do you have any
> > plans/ideas to fix this one as well?
> 
> Patches are welcome ;-)
> 
> ATM, I dont have a specific use-case for my current platforms, so can't write the
> code - you can propose a patch and then we can work out what's best in general for
> all ARC platforms. BTW there's a series in flight on related topic from Guenter so
> please take a look at that too for big picture !
> 
> http://www.spinics.net/linux/lists/kernel/msg1840650.html

Actually, before sending my previous mail I looked at the current
implementation of the halt hook and didn't like it (otherwise I would
have proposed something in the lines). So this one is definitely a step
forward! I'm wondering about two things concerning reset, however:

1. Is the PM module the right place for a reset handler? On the one hand
   reset is functionally very similar to power off but on the other hand
   reset is technically not a power management functionality. If the PM
   module is not the right place, which would be the right place
   instead?

2. What would be the desired behaviour/semantics for a reset handler
   chain equivalent to the power off handler chain. I see two
   possibilities here:
   a) Implementation exactly like power off. Every handler is expected
      to reset the entire system and never returns.
   b) A more "modular" implementation where different subsystems are
      being reset sequentially (e.g. first reset peripherals through
      GPIO in "high priority" handlers and finally reset the core in the
      terminal "low priority" handler).

Greetings,
  Christian
