From: Mike Ditto <mditto-Vjf7OWgA3BLqlBn2x/YWAg@public.gmane.org>
Subject: Re: [PATCH] i2c-cpm: Add flexibility for I2C clock frequency and
 filter.
Date: Wed, 05 Nov 2008 17:12:32 -0800
Message-ID: <49124480.4030409@consentry.com>
References: <490A84F8.20403@consentry.com> <490AEEBF.9000707@scram.de> <20081105233617.GC28465@yookeroo.seuss> <49123BB7.90503@consentry.com> <20081106005339.GF28465@yookeroo.seuss>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081106005339.GF28465-787xzQ0H9iRg7VrjXcPTGA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Jochen Friedrich <jochen-NIgtFMG+Po8@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

[including extra context because some of the thread went to the
 wrong I2C list]

David Gibson wrote:
> On Wed, Nov 05, 2008 at 04:35:03PM -0800, Mike Ditto wrote:
>> David Gibson wrote:
>> > What does worry me, however, is the description says it's about
>> > whether the driver "should" enable the filter.  Generally the device
>> > tree doesn't attempt to say what users "should" do with the hardware,
>> > just what the characteristics of the hardware are.
>> >
>> > What's the underlying difference here that affects the driver's choice
>> > to enable the filter or not?
>> 
>> I think it's a hardware/environment design parameter - e.g. if the I2C
>> bus has hot-pluggable devices, long PCB traces, or a hierarchy of
>> multiplexed bus segments, these can result in a noisy SCL signal that
>> needs to be filtered.  It's also a recommended mitigation for errata
>> in certain CPU revs.
> 
> Ah, ok.  Well the CPU revision thing could be selected based on the
> CPU revision, but the other conditions are a property of the board
> wiring.  Obviously it's hard to precisely characterize what it says
> about the hardware, which is usually best avoided for devtree
> properties, but I can see why this is more-or-less unavoidable in this
> case.
> 
> Ok.  This property name and meaning looks ok to me.  I would suggest a
> note in the binding roughly explaining what leads to the property
> being set (basically what you just told me in the paragraph above).

Will do.  I'll send a revised patch shortly.

Thanks,
					-=] Mike [=-
