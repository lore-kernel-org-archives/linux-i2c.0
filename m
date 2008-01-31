From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
	support to the pca9539 GPIO driver
Date: Thu, 31 Jan 2008 02:48:40 -0800
Message-ID: <200801310248.41076.david-b@pacbell.net>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<200801302052.04336.david-b@pacbell.net>
	<Pine.LNX.4.64.0801311025210.6494@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0801311025210.6494-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thursday 31 January 2008, Guennadi Liakhovetski wrote:
> Thanks for all the comments, I'm going to address them in the next version 
> of the patch. A couple of small clarifications first:
> 
> On Wed, 30 Jan 2008, David Brownell wrote:
> 
> > I'd split this patch into two parts (feature addition, and renaming),
> 
> Would you prefer
> 
> 	...
> 	
> patch-1: git-mv
> patch-2: sed -e "s/pca9539/pca953x/"
> patch-3: pca953[678]
> 
> ?

I think that last would be clearest in terms of GIT history
and patch reviewability... that's why you listed it, right?  :)
So that one, given my druthers.


> 
> > > >         depends on I2C
> > > >         help
> > > > -         Say yes here to support the PCA9539 16-bit I/O port. These
> > > > -         parts are made by NXP and TI.
> > > > +         Say yes here to support PCA9539 16-bit and PCA9536 4-bit I/O ports.
> > 
> > This should IMO list the '38 (8-bit) and '37 (4-bit) parts too.
> > Same register layout as the '36 (4-bit).  Otherwise the "x" seems
> > misleading...
> 
> Ok, I don't want to look through all datasheets ATM, so, I'll just trust 
> you, ok?

OK by me.  The NXP website makes them easy enough to find, but
it's another one of those sites that tries to be too clever by
overusing JavaScript.


> > What I'd do is save those four offsets directly in pca953x_chip,
> > initialized near when gpio_chip.ngpio is set up and with no need
> > for a separate "desc" type or table.  Eventually there'd be:
> > 
> > 	struct i2c_device_id chips [] = {
> > 		{ "pca9536", 4, },
> > 		{ "pca9537", 4, },
> > 		{ "pca9538", 8, },
> > 		{ "pca9539", 16, },
> > 	};
> > 	MODULE_DEVICE_TABLE(i2c, chips);
> > 
> > Meanwhile, the equivalent of that table can come from a few strcmp()
> > tests in the probe() logic -- like what you already have, except
> > not using a "desc" type.
> 
> I introduced the descriptor array, to contain _constant_ chip 
> descriptions, much like your "struct i2c_device_id chips []" array above. 
> So, actually, using my descriptor array is nearer to what it eventually 
> should become, I think. Under 2.6.26 you'd also, probably, just have a 
> "struct i2c_device_id *" member in your pca953x_chip.

Well, I was also pointing out that all you need is the number of GPIOs;
no need to save any ID struct at all.  These chips are VERY similar.


> I can change the  
> descriptor table to look exactly like the i2c_device_id, and then in probe 
> just walk it in a loop, comparing the name? Or would you be getting a 
> pointer to "struct i2c_device_id" in the probe()?

The probe() would get handed the ID, not unlike how USB or PCI work:

 http://marc.info/?l=i2c&m=120091221712826&w=2


> > > > +#ifndef NO_GPIO
> > > > +#define NO_GPIO                        ((unsigned int)-1)
> > > > +#endif
> > > > +
> > > 
> > > I don't understand this.
> > 
> > Me either; *ANY* negative number is invalid as a GPIO number,
> > not just "-1"...
> 
> Ok, this one should rather go into a separate patch. I'd like to have such 
> a macro to check whether the platform is using a GPIO with this specific 
> camera or not. Similar to NO_IRQ.

Then maybe there should be an is_valid_gpio() predicate.
Anything not between 0..MAX_INT would fail.  And there
should be a Documentation/gpio.txt update to match.

- Dave

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
