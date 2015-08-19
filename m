From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: allow specifying separate wakeup interrupt in
 device tree
Date: Wed, 19 Aug 2015 19:43:49 +0200
Message-ID: <20150819174347.GA2112@katana>
References: <20150730201431.GA5255@dtor-ws>
 <20150809152255.GA2367@katana>
 <20150810055936.GB26735@dtor-ws>
 <20150810061621.GA1573@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150810061621.GA1573@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org


> > > > @@ -659,20 +662,47 @@ static int i2c_device_probe(struct device *dev)
> > > >  	if (!device_can_wakeup(&client->dev))
> > > >  		device_init_wakeup(&client->dev,
> > > >  					client->flags & I2C_CLIENT_WAKE);
> > > 
> > > I was about to ask if we couldn't combine this and the later if-blocks
> > > with an if-else combination. But now I stumble over the above block in
> > > general: If the device cannot cause wake ups, then we might initialize
> > > it as a wakeup-device depending on client->flags??
> > 
> > I believe it is done so that we do not try to re-add wakeup source after
> > unbinding/rebinding the device. With my patch we clearing wakeup flag on
> > unbind, so it is OK, but there is still error path where we might want
> > to reset the wakeup flag as well.
> 
> I was wondering if it wants to achieve that, why does it not
> unconditionally use 0 instead of the WAKE flag.

When reviewing V2, I wasn't comfortable with just guessing what the old
code means. So, I did some digging and found:

https://lkml.org/lkml/2008/8/10/204

Quoting the interesting paragraph from David Brownell:

===

Better would be to preserve any existing settings:

	if (!device_can_wakeup(&client->dev))
		device_init_wakeup(...)
That way the userspace policy setting is preserved unless the
device itself gets removed ... instead of being clobbered by
the simple act of (re)probing a driver.

> > +	device_init_wakeup(&client->dev, client->flags &
> > I2C_CLIENT_WAKE);

===

I have to admit that I am not familiar with device wakeup handling and
especially its userspace policies. Can you double check that your V2
meets the above intention?

Thanks,

   Wolfram
