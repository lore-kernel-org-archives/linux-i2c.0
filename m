From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
	filter.
Date: Thu, 6 Nov 2008 11:53:39 +1100
Message-ID: <20081106005339.GF28465__39047.9369125844$1225933886$gmane$org@yookeroo.seuss>
References: <490A84F8.20403@consentry.com> <490AEEBF.9000707@scram.de> <20081105233617.GC28465@yookeroo.seuss> <49123BB7.90503@consentry.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <49123BB7.90503-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Cc: Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 05, 2008 at 04:35:03PM -0800, Mike Ditto wrote:
> David Gibson wrote:
> > What does worry me, however, is the description says it's about
> > whether the driver "should" enable the filter.  Generally the device
> > tree doesn't attempt to say what users "should" do with the hardware,
> > just what the characteristics of the hardware are.
> >
> > What's the underlying difference here that affects the driver's choice
> > to enable the filter or not?
> 
> I think it's a hardware/environment design parameter - e.g. if the I2C
> bus has hot-pluggable devices, long PCB traces, or a hierarchy of
> multiplexed bus segments, these can result in a noisy SCL signal that
> needs to be filtered.  It's also a recommended mitigation for errata
> in certain CPU revs.

Ah, ok.  Well the CPU revision thing could be selected based on the
CPU revision, but the other conditions are a property of the board
wiring.  Obviously it's hard to precisely characterize what it says
about the hardware, which is usually best avoided for devtree
properties, but I can see why this is more-or-less unavoidable in this
case.

Ok.  This property name and meaning looks ok to me.  I would suggest a
note in the binding roughly explaining what leads to the property
being set (basically what you just told me in the paragraph above).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
