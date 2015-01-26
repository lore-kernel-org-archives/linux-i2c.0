From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: I2C slave support
Date: Mon, 26 Jan 2015 18:07:47 +0100
Message-ID: <20150126180747.07ddacfd@endymion.delvare>
References: <20150124210825.521bf923@endymion.delvare>
	<20150126113329.GB1052@katana>
	<20150126171745.3d6d0fec@endymion.delvare>
	<20150126163013.GE13494@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150126163013.GE13494@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Mon, 26 Jan 2015 17:30:13 +0100, Wolfram Sang wrote:
> 
> > > Own module: Again, undecided. On the one hand it makes for a nice
> > > encapsulation, on the other hand there is overhead for having another
> > > module. I am very happy that the core code for slave support is so slim.
> > 
> > I gave a try to the separate module approach and I have to agree that
> > it seems overkill given the small amount of code.
> 
> OK, thanks for trying!
> 
> > Something like this?
> 
> Yes, pretty much what I had in mind. One issue, though:
> 
> > +#if IS_ENABLED(CONFIG_I2C_SLAVE)
> >  enum i2c_slave_event {
> >  	I2C_SLAVE_REQ_READ_START,
> >  	I2C_SLAVE_REQ_READ_END,
> > @@ -263,6 +266,7 @@ static inline int i2c_slave_event(struct
> >  {
> >  	return client->slave_cb(client, event, val);
> >  }
> > +#endif
> 
> This should fail because bus drivers need those enums for their slave
> backend. Try building i2c-sh_mobile which builds with an x86 toolchain
> as well.

Sorry I missed that, because there is currently no i2c bus driver
implementing slave support on x86-64.

> * Either we leave this included, so bus drivers don't need any ifdeffery

We can do that. The enum itself has no run-time cost so I don't mind.

> or
> 
> * we mandate that bus drivers also use the ifedeffery. Then, we could
>   also mask out the (un)reg_slave callbacks in struct i2c_adapter
> 
> What do you think?

Oh, I admit I completely missed the (un)reg_slave callbacks in my first
patch.

While I am happy with a few ifdefs in i2c-core and i2c.h, I agree it
will become messy if these are required in device drivers as well.

Hmm, what about bus drivers with slave mode support must select
CONFIG_I2C_SLAVE? This solves my problem nicely, and makes no change
compared to the current situation for people using slave mode.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
