From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Tue, 9 Jul 2013 11:44:02 +0300
Message-ID: <20130709084402.GF4898@intel.com>
References: <1373283927-21677-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130708134216.GB6402@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130708134216.GB6402-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Mon, Jul 08, 2013 at 03:42:17PM +0200, Christian Ruppert wrote:
> On Mon, Jul 08, 2013 at 02:45:26PM +0300, Mika Westerberg wrote:
> > The DesignWare I2C controller has high count (HCNT) and low count (LCNT)
> > registers for each of the I2C speed modes (standard and fast). These
> > registers are programmed based on the input clock speed in the driver.
> > 
> > However, that is not always the most accurate way. For example on Intel
> > BayTrail we have 100MHz input clock and calculated *CNT values result as
> > measured by one of our team:
> > 
> >  Standard mode: 100.25kHz
> >  Fast mode    : 315.41kHZ
> > 
> > The fast mode speed is over 20% lower than what is expected.
> 
> We have observed similar issues and I am wondering if this effect is due
> to the overly-pessimistic formulas in i2c_dw_scl_lcnt and
> i2c_dw_scl_hcnt. The comments in these functions are a bit confusing and
> I don't pretend having fully understood what the intention is. I'm
> having the impression that defining the arguments tf in function of the
> hardware would be the "correct" way to achieve better clock accuracy.

Well, that's not the only timing parameter specified in the I2C spec. We
also have tr among other things (even though the dw driver doesn't use it).

> > It might be
> > that there are things like strenght of the pull-up resistors, bus
> > capacitance etc. that are very platform specific and have an effect on the
> > clock signal.
> 
> I believe tf is supposed to model these things. I just haven't clearly
> understood how. In my understanding, transition times should be
> subtracted rather than added to cycle times or am I getting something
> fundamentally wrong here?

I'm not sure, honestly :-) I believe tf is the same tf that is in the I2C
spec, meaning fall time of both SCL and SDA signals and the spec measures
one clock cycle to be from end of the first tf to the end of the second
(fig. 27 in the I2C spec). If I'm reading it right then it means adding
instead of substracting.

Do you have any suggestions how we could use tf here? At least on Intel
hardware we have an ACPI method that returns directly the optimum *CNT
values.
