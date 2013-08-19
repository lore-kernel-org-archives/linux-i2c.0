From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Mon, 19 Aug 2013 09:39:28 +0300
Message-ID: <20130819063928.GH4898@intel.com>
References: <20130709084402.GF4898@intel.com>
 <20130709161927.GC30236@ab42.lan>
 <20130710105215.GY4898@intel.com>
 <20130710165634.GA30693@ab42.lan>
 <20130711073600.GG4898@intel.com>
 <20130711101330.GP4898@intel.com>
 <51DFB6C1.4040001@pobox.com>
 <20130712085140.GY4898@intel.com>
 <51E0E76B.1040304@pobox.com>
 <20130716111616.GA25835@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130716111616.GA25835-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Sorry for the slooow response, I've been on vacation.

On Tue, Jul 16, 2013 at 01:16:18PM +0200, Christian Ruppert wrote:
> > Second step is that if current i2c_dw_scl_hcnt and i2c_dw_scl_lcnt
> > calculations don't suit with later DW I2C cores, then it would be
> > nice for someone who can access to the data book to update formulas,
> > or provide alternative formulas and make them selectable depending
> > on DW core versions.
> 
> I'm not having the impression there is a huge difference between the
> different generations of DW blocks. Probably we can find one formula
> that suits all blocks. We just have to be careful (in doubt rather
> conservative) with the transition times. This seems to be currently
> the case and if I understand Mika correctly, his objective is to remove
> some of this conservatism.

What I had originally in mind was that we could just pass whatever
HCNT/LCNT values we get from system FW (with the help of ACPI or DT).

However, if we can make the HCNT/LCNT calculation more accurate using tf
and tr, that are passed from DT or platform data, we should implement that
as well (as a separate patch).

> > It always helps us to have a way to calculate *HCNT and *LCNT values
> > automatically.  As said above, DW I2C core can control tHIGH, tLOW,
> > tHD;STA, etc. quite _accurate_, if HCNT/LCNT values were calculated
> > with proper formulas.  It also helps hardware people as well to
> > provide reference HCNT/LCNT values.
> > 
> > And as a third step, if we want to use optimized HCNT/LCNT values
> > which can not be obtained from proper formulas + user-requested
> > tf/tr, or if we want to use HCNT/LCNT settings verified by vendors
> > or provided from hardware team, then I'm fine with having a way to
> > _override_ HCNT/LCNT values.  Such direct way might be useful.
> 
> I agree. Probably it is best to have both, a default method based on
> formulas and timing parameters (the formulas are quite simple anyway)
> which works with device tree and such and a second method based on
> register values which works with mechanisms like ACPI.

I agree.

I'm going to post a new version of this patch (and the SDA hold patch) that
takes care of the ACPI case if there are no objections.
