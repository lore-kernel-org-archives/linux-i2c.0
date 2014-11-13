From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] i2c: Driver to expose PowerNV platform i2c busses
Date: Fri, 14 Nov 2014 07:53:40 +1100
Message-ID: <1415912020.666.17.camel@kernel.crashing.org>
References: <20141110060424.9407.2498.stgit@localhost.localdomain>
	 <20141113075817.GA1288@katana> <1415876169.666.2.camel@kernel.crashing.org>
	 <20141113131014.GA8025@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141113131014.GA8025@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Neelesh Gupta <neelegup-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 2014-11-13 at 14:10 +0100, Wolfram Sang wrote:
> > > Please sort the includes.
> > 
> > Ugh ? Since when do we do that ? :-)
> 
> Since I realised it is more readable and reduces likeliness of
> duplicated includes.

Ok, I assume alphabetical rather than Ingo's aesthetic "tree" ?

> > > > +	rc = opal_i2c_request(token, bus_id, req);
> > > > +	if (rc != OPAL_ASYNC_COMPLETION) {
> > > > +		rc = -EIO;
> > > > +		goto exit;
> > > > +	}
> > > > +
> > > > +	rc = opal_async_wait_response(token, &msg);
> > > > +	if (rc) {
> > > > +		rc = -EIO;
> > > > +		goto exit;
> > > 
> > > Is it really -EIO? Maybe -ETIMEDOUT?
> > 
> > No, there is no timeout, if that fails something went quite wrong, it
> > could almost be a BUG_ON (basically we passed a wrong token or a NULL
> > msg).
> 
> OK. I'd think it at least makes sense to use error codes which
> distinguish I2C bus errors from OPAL interface errors. Always using -EIO
> seems very generic :)

Ok, any suggestion ? We don't have a -EINTERNAL :) In any case, I'm not
too worried, the above basically cannot happen.

> > > I don't think you should offer I2C_FUNC_I2C with those limitations. Is
> > > there a case you really needs this?
> > 
> > Yes there is, and it's pretty common :-) I actually added this to
> > Neelesh original driver, it's the "smbus" style but with 2 bytes offset.
> > Typically what we need for driver such as at24. They use normal raw i2c
> > writes for writes but need the 2-bytes write + read combo without stop
> > for reads.
> 
> Understood. So, basically something like I2C_SMBUS_WORD_I2C_BLOCK_DATA
> is missing where the 'command' argument is not u8 but u16? Brainstorming
> here, not relevant for this driver now.

Yes, or a generic "N bytes command". My FW driver supports up to 4 bytes
in fact at the moment.

> > > > +	adapter = kzalloc(sizeof(struct i2c_adapter), GFP_KERNEL);
> > > 
> > > devm_kzalloc?
> > 
> > Ah, I never got the knack of using the new devm stuff, Neelesh, can you
> > take care of this ?
> 
> New? :D This would be a dead simple exercise to learn about it ;)

Oh I *know* about it, it's just a habit I didn't catch ... yet :-) I'm
probably getting old and set in my ways ..... :-)

> > > > +	adapter->dev.parent = &pdev->dev;
> > > > +	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
> > > > +	pname = of_get_property(pdev->dev.of_node, "port-name", NULL);
> > > 
> > > I have never seen this binding before, it looks fishy. Where is it documented?
> > 
> > We made it up, like pretty every SoC vendor out there. What's fishy
> > about it ? It's a very good way to get fixed i2c port names on the
> > system, the firmware defines them.
> 
> But the SoC vendors prefix it with their company name and add
> documentation for the binding.

Why do we need to prefix arbitrary props for a very specific device ?
When adding things to an existing more/less generic device it makes some
sense but here I don't see much point. I can whip up a "binding"
document for this adapter and make "port-name" be part of it if you
want :) In fact a better name for the property might be "bus-id"...

> Furthermore, this is just wrong, too. The adapter name is the name of
> the IP core or chip or whatever which does the I2C bus. It is not the
> functional name of the bus. It should be plain "Opal I2C" or similar.

But that really makes no sense. On one hand we have a way to get
something decent and useful out of i2c-detect -l, and on the other hand,
we get a list of N (N = 3*number of P8 chips at least) identical names
and have to go through hoops figuring out which is which ...

I don't see why we can't use the name for that... the name scheme I use
does convey both bits of information btw, I use something like:

	p8_xxxxxxxx_eypz (ex: p8_00000000_e0p0)

Where p8 means power 8 (centaur's, our memory buffers, will have
something else there), xxxxxxxx is the chip ID (identify a processor or
centaur chip uniquely in the system), y the engine number on the chip
and z the port number on the engine.

Cheers,
Ben.

> Regards,
> 
>    Wolfram
