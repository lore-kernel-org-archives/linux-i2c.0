From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: [PATCH 1/6] i2c: bcm-kona: register with subsys_initcall
Date: Wed, 5 Feb 2014 10:30:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1402051028350.1312-100000@iolanthe.rowland.org>
References: <20140205151826.GC22153@beef>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140205151826.GC22153@beef>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 5 Feb 2014, Matt Porter wrote:

> On Wed, Feb 05, 2014 at 10:08:18AM +0100, Wolfram Sang wrote:
> > On Tue, Feb 04, 2014 at 07:19:07AM -0500, Matt Porter wrote:
> > 
> > > Voltage regulators are needed very early due to deferred probe
> > > being incompatible with built-in USB gadget drivers.
> > 
> > What does it need to fix those instead?
> 
> [added Alan/Felipe for more insight]
> 
> Discussion on that topic came about from this submission:
> http://www.spinics.net/lists/linux-usb/msg94217.html
> 
> End of it is:
> http://www.spinics.net/lists/linux-usb/msg94731.html
> 
> We can either add to the many drivers that already do subsys_initcall()
> for similar reasons...or I can drop this from the series and add gadget
> probe ordering to my TODO list.
> 
> In short, it can't be a late_initcall() hack like the original post and
> really could be solved by converting to a real bus (and letting
> deferred probe do its job)..but Alan voiced concerns about that.

Don't worry too much about what I said.  If adding a "gadget" bus will 
solve the problem in an appropriate way, and if nobody else objects 
(particularly Felipe, who is on vacation now), then go for it.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
