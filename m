From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 1/2] i2c-designware: make *CNT values configurable
Date: Wed, 10 Jul 2013 13:52:15 +0300
Message-ID: <20130710105215.GY4898@intel.com>
References: <1373283927-21677-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130708134216.GB6402@ab42.lan>
 <20130709084402.GF4898@intel.com>
 <20130709161927.GC30236@ab42.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130709161927.GC30236-7oYq3qWSd+k@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christian Ruppert <christian.ruppert-ux6zf3SgZrrQT0dZR+AlfA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Jul 09, 2013 at 06:19:28PM +0200, Christian Ruppert wrote:
> What I meant is the following: The clock cycle time Tc is composed of
> the four components
> 
>   Tc = Th + Tf + Tl + Tr
> 
> where
>   Th: Time during which the signal is high
>   Tf: Falling edge transition time
>   Tl: Time during which the signal is low
>   Tr: Rising edge transition time
> 
> The I2C specification specifies a minimum for Tl and Th and a range (or
> maximum) for Tr and Tf. A maximum frequency is specified as the
> frequency obtained by adding the minima for Th and Tl to the maxima of
> Tr ant Tf.
> Since as you said, transition times are very much PCB dependent, one way
> to guarantee the max. frequency constraint (and to achieve a constant
> frequency at its max) is to define the constants
> Th' = Th + Tf := Th_min + Tf_max
> Tl' = Tl + Tr := Tl_min + Tr_max
> 
> and to calculate the variables
> Th = Th' - Tf
> Tl = Tl' - Tr
> in function of Tf and Tr of the given PCB.

If I understand the above, it leaves Tf and Tr to be PCB specific and then
these values are passed to the core driver from platform data, right?

I'm thinking that passing directly the "measured" *CNT values from the
platform data makes this even more accurate (given that information is
available). And if you only have the Tf and Tr for your board, you can have
custom calculation done in the platform part of the driver that takes them
into account, and then passes these custom *CNT values to the core.

> > At least on Intel
> > hardware we have an ACPI method that returns directly the optimum *CNT
> > values.
> 
> I don't know ACPI very well and if it deals with register values
> directly your patch is probably the right thing.

Our FW people decided to have a custom ACPI method that returns the correct
values to be used in the Windows I2C driver. It returns direct *CNT
register values that have been measured to be good for a given PCB.

> The timing calculation in the driver seems a bit strange to me, however
> (see above), but I never dared touching it because I never had time to
> dive into the code deep enough and I was just wondering if it was
> possible to fix it at the same time.

It would be good if we can fix this for non-ACPI devices as well. Is it
hard to add similar properties to the driver specific Device Tree bindings?

Wolfram, do you have any input on this?
