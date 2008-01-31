From: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Subject: Re: [i2c] [RFC PATCH 3/8] Add PCA9536 4 bit I2C GPIO extender
 support to the pca9539 GPIO driver
Date: Thu, 31 Jan 2008 11:13:15 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0801311025210.6494@axis700.grange>
References: <Pine.LNX.4.64.0801231646090.4932@axis700.grange>
	<Pine.LNX.4.64.0801301732550.6547@axis700.grange>
	<f17812d70801301731n62597f12kc151d01c320e3dec@mail.gmail.com>
	<200801302052.04336.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200801302052.04336.david-b@pacbell.net>
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

Thanks for all the comments, I'm going to address them in the next version 
of the patch. A couple of small clarifications first:

On Wed, 30 Jan 2008, David Brownell wrote:

> I'd split this patch into two parts (feature addition, and renaming),

Would you prefer

patch-1: git-mv && sed -e "s/pca9539/pca953x/"
patch-2: add pca953[678]

or

patch-1: git-mv
patch-2: sed -e "s/pca9539/pca953x/" && pca953[678]

or even

patch-1: git-mv
patch-2: sed -e "s/pca9539/pca953x/"
patch-3: pca953[678]

?

> > >         depends on I2C
> > >         help
> > > -         Say yes here to support the PCA9539 16-bit I/O port. These
> > > -         parts are made by NXP and TI.
> > > +         Say yes here to support PCA9539 16-bit and PCA9536 4-bit I/O ports.
> 
> This should IMO list the '38 (8-bit) and '37 (4-bit) parts too.
> Same register layout as the '36 (4-bit).  Otherwise the "x" seems
> misleading...

Ok, I don't want to look through all datasheets ATM, so, I'll just trust 
you, ok?

> > > -#define NR_PCA9539_GPIOS       16
> > > +struct pca953x_desc {
> > > +       unsigned int gpios;
> > > +       unsigned int input;
> > > +       unsigned int output;
> > > +       unsigned int invert;
> > > +       unsigned int direction;
> > > +};
> > 
> > I guess the register address can be inferred either from the number
> > of GPIOs or a single member field of "shift" may be sufficient.
> 
> Yes, inferring that would be simpler.  The number of GPIOs is a
> function of the particular chip, and register offsets are 0/1/2/3
> except for the 16-GPIO part where they're twice that.
> 
> What I'd do is save those four offsets directly in pca953x_chip,
> initialized near when gpio_chip.ngpio is set up and with no need
> for a separate "desc" type or table.  Eventually there'd be:
> 
> 	struct i2c_device_id chips [] = {
> 		{ "pca9536", 4, },
> 		{ "pca9537", 4, },
> 		{ "pca9538", 8, },
> 		{ "pca9539", 16, },
> 	};
> 	MODULE_DEVICE_TABLE(i2c, chips);
> 
> Meanwhile, the equivalent of that table can come from a few strcmp()
> tests in the probe() logic -- like what you already have, except
> not using a "desc" type.

I introduced the descriptor array, to contain _constant_ chip 
descriptions, much like your "struct i2c_device_id chips []" array above. 
So, actually, using my descriptor array is nearer to what it eventually 
should become, I think. Under 2.6.26 you'd also, probably, just have a 
"struct i2c_device_id *" member in your pca953x_chip. I can change the 
descriptor table to look exactly like the i2c_device_id, and then in probe 
just walk it in a loop, comparing the name? Or would you be getting a 
pointer to "struct i2c_device_id" in the probe()?

> > > -static int pca9539_init_gpio(struct pca9539_chip *chip)
> > > +static int pca953x_init_gpio(struct pca953x_chip *chip)
> > >  {
> > >         struct gpio_chip *gc;
> > >
> > >         gc = &chip->gpio_chip;
> > >
> > > -       gc->direction_input  = pca9539_gpio_direction_input;
> > > -       gc->direction_output = pca9539_gpio_direction_output;
> > > -       gc->get = pca9539_gpio_get_value;
> > > -       gc->set = pca9539_gpio_set_value;
> > > +       gc->direction_input  = pca953x_gpio_direction_input;
> > > +       gc->direction_output = pca953x_gpio_direction_output;
> > > +       gc->get = pca953x_gpio_get_value;
> > > +       gc->set = pca953x_gpio_set_value;
> > >
> > >         gc->base = chip->gpio_start;
> > > -       gc->ngpio = NR_PCA9539_GPIOS;
> > > -       gc->label = "pca9539";
> > > +       gc->ngpio = chip->desc->gpios;
> 
> I'd expect "desc" to vanish, and ngpio to be an input to this function
> (see below).  Then ngpio could be used to choose the values to stuff
> into chip->{input,output,invert,direction} register offsets.
> 
> 
> > > +       gc->label = "pca953x";
> 
> Why not just set gc->label to be chip->client->name?

See above. I didn't invent it - just a result of "sed". But I can change 
it I guess.

> > > --- a/include/asm-generic/gpio.h
> > > +++ b/include/asm-generic/gpio.h
> > > @@ -16,6 +16,10 @@
> > >  #define ARCH_NR_GPIOS          256
> > >  #endif
> > >
> > > +#ifndef NO_GPIO
> > > +#define NO_GPIO                        ((unsigned int)-1)
> > > +#endif
> > > +
> > 
> > I don't understand this.
> 
> Me either; *ANY* negative number is invalid as a GPIO number,
> not just "-1"...

Ok, this one should rather go into a separate patch. I'd like to have such 
a macro to check whether the platform is using a GPIO with this specific 
camera or not. Similar to NO_IRQ.

Thanks
Guennadi
---
Guennadi Liakhovetski

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=unsubscribe
https://www.redhat.com/mailman/listinfo/video4linux-list
