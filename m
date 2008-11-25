From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC] i2c-parport: Add SMBus alert support for ADM1032EB
Date: Tue, 25 Nov 2008 02:45:09 -0800
Message-ID: <200811250245.09781.david-b@pacbell.net>
References: <20081121212945.14e14217@hyperion.delvare> <200811221318.44271.david-b@pacbell.net> <20081125110513.56c843c3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20081125110513.56c843c3-ig7AzVSIIG7kN2dkZ6Wm7A@public.gmane.org>
Content-Disposition: inline
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tuesday 25 November 2008, Jean Delvare wrote:
> > It'd be simpler to use the parport-light code, and delegate all
> > that handling to i2c-core.  After all, you're not likely to
> > have a collection of such i2c adapter dongles sharing a single
> > parallel port ...
> 
> Even the i2c-parport driver only supports one device at the moment,
> because we request the parallel port with flag PARPORT_FLAG_EXCL.
> Honestly I don't really recall why I did that, maybe just paranoia
> while I was developing the driver and then I forgot to change it. OTOH
> I'm not sure if it is really possible to grab the parallel port
> non-exclusively especially now that we can receive an interrupt at
> about any time.
> 
> The daisy chaining of parallel port devices always looked like a hack
> to me anyway.

Yes, a hack.  I'm happy to see it wither away.


> > Alternatively, maybe *both* parport adapter drivers should be
> > updated.
> 
> Yes, that would make sense. However, I always have a hard time testing
> i2c-parport-light, as apparently loading the parport_pc driver is
> enough for the parallel port hardware to lose its pristine state and
> then i2c-parport-light no longer works. And of course parport_pc tends
> to load automatically on my systems.

Oh.  I never used it enough to notice such stuff, I guess.
Somehow I expect parport-light bugs are low priority.  ;)


> > > @@ -189,12 +197,18 @@ static void i2c_parport_attach (struct p
> > >  	if (adapter_parm[type].init.val)
> > >  		line_set(port, 1, &adapter_parm[type].init);
> > >  
> > > -	parport_release(adapter->pdev);
> > > +	/* Setup SMBus alert if supported */
> > > +	if (adapter_parm[type].smbus_alert) {
> > > +		adapter->adapter.do_setup_alert = 1;
> > > +		adapter->adapter.alert_edge_triggered = 1;
> > 
> > The fact that you need to set this trigger flag reflects a bug
> > in the SMBALERT# patch.  Since "you" are handling the IRQ, it
> > has no business caring about that.  It should suffice to set
> > the do_setup_alert flag.
> 
> I'm unsure about this. For edge-triggered interrupts, you indeed
> shouldn't do anything in i2c-core if the adapter driver takes care of
> the interrupt.

If the adapter driver is taking care of the interrupt, then i2c-core
should *never* try touching it.  That part is easy to fix.


> For level-triggered interrupts though, the interrupt 
> needs to be disabled and re-enabled. smbus_alert() appears to be the
> right place to re-enable the interrupt. Else how would the adapter
> driver code know when to re-enable it?

That's another aspect of the bug.  You'll recall I mentioned needing
a hook for that, maybe a callback ... 


> > > --- linux-2.6.28-rc6.orig/drivers/hwmon/lm90.c	2008-10-27 08:46:47.000000000 +0100
> > > +++ linux-2.6.28-rc6/drivers/hwmon/lm90.c	2008-11-21 17:34:36.000000000 +0100
> > 
> > Separate patch?
> 
> I kept it in the same patch to help review and testing. When I submit
> it upstream, I will split appropriately.
> 
> Note that this is one more reason too make sure that the i2c-core code
> is robust against misbehaving devices. At some point in time,
> i2c-parport might support SMBus alert and the lm90 driver might not, or
> vice-versa.

Right; I certainly wasn't arguing aginst robustness.

(And testing against ... quirkier ... hardware than I
used is of course a great way to shake loose issues
in new code.)
