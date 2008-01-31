From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [i2c] [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
 support to the pca9539 GPIO driver
Date: Thu, 31 Jan 2008 12:30:19 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801311204280.6494@axis700.grange>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<200801302052.04336.david-b@pacbell.net>
	<Pine.LNX.4.64.0801311025210.6494@axis700.grange>
	<200801310248.41076.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200801310248.41076.david-b@pacbell.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: David Brownell <david-b@pacbell.net>
Cc: Jean Delvare <khali@linux-fr.org>, video4linux-list@redhat.com, i2c@lm-sensors.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 31 Jan 2008, David Brownell wrote:

> On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> > patch-1: git-mv
> > patch-2: sed -e "s/pca9539/pca953x/"
> > patch-3: pca953[678]
> > 
> > ?
> 
> I think that last would be clearest in terms of GIT history
> and patch reviewability... that's why you listed it, right?  :)
> So that one, given my druthers.

Was my preference too.

> > > > >         depends on I2C
> > > > >         help
> > > > > -         Say yes here to support the PCA9539 16-bit I/O port. These
> > > > > -         parts are made by NXP and TI.
> > > > > +         Say yes here to support PCA9539 16-bit and PCA9536 4-bit I/O ports.
> > > 
> > > This should IMO list the '38 (8-bit) and '37 (4-bit) parts too.
> > > Same register layout as the '36 (4-bit).  Otherwise the "x" seems
> > > misleading...
> > 
> > Ok, I don't want to look through all datasheets ATM, so, I'll just trust 
> > you, ok?
> 
> OK by me.  The NXP website makes them easy enough to find, but
> it's another one of those sites that tries to be too clever by
> overusing JavaScript.

I'm actually adding 9534 (8-bit) and 9535 (16-bit) too atm, if you don't 
mind:-)

> > > What I'd do is save those four offsets directly in pca953x_chip,
> > > initialized near when gpio_chip.ngpio is set up and with no need
> > > for a separate "desc" type or table.  Eventually there'd be:
> > > 
> > > 	struct i2c_device_id chips [] = {
> > > 		{ "pca9536", 4, },
> > > 		{ "pca9537", 4, },
> > > 		{ "pca9538", 8, },
> > > 		{ "pca9539", 16, },
> > > 	};
> > > 	MODULE_DEVICE_TABLE(i2c, chips);
> > > 
> > > Meanwhile, the equivalent of that table can come from a few strcmp()
> > > tests in the probe() logic -- like what you already have, except
> > > not using a "desc" type.
> > 
> > I introduced the descriptor array, to contain _constant_ chip 
> > descriptions, much like your "struct i2c_device_id chips []" array above. 
> > So, actually, using my descriptor array is nearer to what it eventually 
> > should become, I think. Under 2.6.26 you'd also, probably, just have a 
> > "struct i2c_device_id *" member in your pca953x_chip.
> 
> Well, I was also pointing out that all you need is the number of GPIOs;
> no need to save any ID struct at all.  These chips are VERY similar.

Ok, agreed, let's remove it then. For now I just use an array of structs 
similar to i2c_device_id only to avoid a long sequence of strcmp calls in 
probe() and compare the name in a loop. Is this alright?

> > > > > +#ifndef NO_GPIO
> > > > > +#define NO_GPIO                        ((unsigned int)-1)
> > > > > +#endif
> > > > > +
> > > > 
> > > > I don't understand this.
> > > 
> > > Me either; *ANY* negative number is invalid as a GPIO number,
> > > not just "-1"...
> > 
> > Ok, this one should rather go into a separate patch. I'd like to have such 
> > a macro to check whether the platform is using a GPIO with this specific 
> > camera or not. Similar to NO_IRQ.
> 
> Then maybe there should be an is_valid_gpio() predicate.
> Anything not between 0..MAX_INT would fail.  And there
> should be a Documentation/gpio.txt update to match.

Good, will do that.

Thanks
Guennadi
---
Guennadi Liakhovetski

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
