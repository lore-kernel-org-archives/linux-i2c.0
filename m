From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Fri, 12 Jul 2013 11:51:40 +0300
Message-ID: <20130712085140.GY4898@intel.com>
References: <1373283927-21677-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130708134216.GB6402@ab42.lan>
 <20130709084402.GF4898@intel.com>
 <20130709161927.GC30236@ab42.lan>
 <20130710105215.GY4898@intel.com>
 <20130710165634.GA30693@ab42.lan>
 <20130711073600.GG4898@intel.com>
 <20130711101330.GP4898@intel.com>
 <51DFB6C1.4040001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51DFB6C1.4040001-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shinya Kuribayashi <skuribay-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Jul 12, 2013 at 04:56:49PM +0900, Shinya Kuribayashi wrote:
> On 7/11/13 7:13 PM, Mika Westerberg wrote:
> >On Thu, Jul 11, 2013 at 10:36:00AM +0300, Mika Westerberg wrote:
> >>On Wed, Jul 10, 2013 at 06:56:35PM +0200, Christian Ruppert wrote:
> >>>On Wed, Jul 10, 2013 at 01:52:15PM +0300, Mika Westerberg wrote:
> >>>>On Tue, Jul 09, 2013 at 06:19:28PM +0200, Christian Ruppert wrote:
> >>>>>What I meant is the following: The clock cycle time Tc is composed of
> >>>>>the four components
> >>>>>
> >>>>>   Tc = Th + Tf + Tl + Tr
> >>>>>
> >>>>>where
> >>>>>   Th: Time during which the signal is high
> >>>>>   Tf: Falling edge transition time
> >>>>>   Tl: Time during which the signal is low
> >>>>>   Tr: Rising edge transition time
> >>>>>
> >>>>>The I2C specification specifies a minimum for Tl and Th and a range (or
> >>>>>maximum) for Tr and Tf. A maximum frequency is specified as the
> >>>>>frequency obtained by adding the minima for Th and Tl to the maxima of
> >>>>>Tr ant Tf.
> >>>>>Since as you said, transition times are very much PCB dependent, one way
> >>>>>to guarantee the max. frequency constraint (and to achieve a constant
> >>>>>frequency at its max) is to define the constants
> >>>>>Th' = Th + Tf := Th_min + Tf_max
> >>>>>Tl' = Tl + Tr := Tl_min + Tr_max
> >>>>>
> >>>>>and to calculate the variables
> >>>>>Th = Th' - Tf
> >>>>>Tl = Tl' - Tr
> >>>>>in function of Tf and Tr of the given PCB.
> >>>>
> >>>>If I understand the above, it leaves Tf and Tr to be PCB specific and then
> >>>>these values are passed to the core driver from platform data, right?
> >>>
> >>>That would be the idea: Calculate Th' and Tl' in function of the desired
> >>>clock frequency and duty cycle and then adapt these values using
> >>>measured transition times. What prevented me from implementing this
> >>>rather academic approach are the following comments in
> >>>i2c-designware-core.c:
> 
> When we talk about I2C timing specs, we should not bring up "clock speed"
> things.  All we have to do is to strictly meet timing constraints of
> tHIGH, tLOW, tHD;SATA, tr, tf, etc.  The resulting "clock speed" is not
> a goal.

OK, thanks for the explanation.

I'm relatively new with I2C bus even though I've adapted the DW I2C driver
to work on our HW.

> >>>/*
> >>>  * DesignWare I2C core doesn't seem to have solid strategy to meet
> >>>  * the tHD;STA timing spec.  Configuring _HCNT based on tHIGH spec
> >>>  * will result in violation of the tHD;STA spec.
> >>>  */
> >>>
> >>>/* ...
> >>>  * This is just experimental rule; the tHD;STA period
> >>>  * turned out to be proportinal to (_HCNT + 3).  With this setting,
> >>>  * we could meet both tHIGH and tHD;STA timing specs.
> >>>  * ...
> >>>  */
> >>>
> >>>If I interpret this right, the slow down of the clock is intentional to
> >>>meet tHD;STA timing constraints.
> 
> Correct.
> 
> >>Yeah, looks like so. tHD;STA is the SDA hold time. I wonder if the above
> >>comments apply to some earlier version of the IP that didn't have the SDA
> >>hold register?
> 
> If I remember DesignWare APB I2C spec correctly, SDA hold time register
> doesn't help to meet tHD;STA spec.  Could someone confirm it really so
> with a real hardware, please?

Indeed, SDA hold in the DesignWare I2C is not the same as tHD;STA according
the databook. Unfortunately I don't have means to actually measure that
here.

Anyway, the HCNT, LCNT and SDA hold time values we get from ACPI SSCN/FMCN
methods are measured by our HW guys on a certain board and they have
verified that using those we meet all the I2C timing specs.

In order to take advantage of those we need some way to pass those values
to the i2c designware core. I have two suggestions:
  
  - Use the method outlined in this patch and let the interface driver
    override *CNT values.

  - Allow interface drivers to override the function that does calculations
    for these values like:

	if (dev->std_scl_cnt)
		dev->std_scl_cnt(dev, &hcnt, &lcnt);
	else
		/* Fallback to the calculation based solely on iclk */

Any comments on these?
