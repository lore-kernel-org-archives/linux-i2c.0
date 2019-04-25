From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 3/5] i2c-mux-gpio: Save initial channel number to the
 idle data field
Date: Thu, 25 Apr 2019 18:53:26 +0300
Message-ID: <20190425155325.voqlrmbdblo7xhtx@mobilestation>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-4-fancer.lancer@gmail.com>
 <7c8d4751-f5f7-ee2a-c411-a985b81d61a3@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7c8d4751-f5f7-ee2a-c411-a985b81d61a3@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Serge Semin <Sergey.Semin@t-platforms.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Apr 24, 2019 at 09:26:22PM +0000, Peter Rosin wrote:
> On 2019-04-24 14:34, Serge Semin wrote:
> > In case if the idle state has been specified in the data structure,
> > the idle variable is left untouched as before, so to keep a default
> > channel number enabled in the mux idle state. But if a platform doesn't
> > specify which channel is going to be enabled by default, we as before
> > don't setup the deselect callback, but the initial state is saved in the
> > idle variable for further initialization. We can safely do this here
> > since that variable is used for initial state setting only, when no
> > idling lane is specified.
> 
> While this subtlety is *maybe* ok, a comment about it belongs in the
> *code* where it will be seen when the next person makes changes.
> 
> But why not extend the struct with the initial state? How many of
> these muxes do you expect to exist in a system? Multiplied by a
> couple of bytes. Who cares?
> 

I actually thought about this when started working on the patchset.
That time saving the initial value in the idle variable seemed like a
good idea. I even put a small comment in the code about this.

Anyway lets add a new field to "struct gpiomux" structure and use
it as a container for initial value. It is also a good alternative.
I'll do this in a v2 patchset.

-Sergey

> Cheers,
> Peter
> 
> > 
> > The reason of this change is to prepare the code for future GPIOs request
> > path being split up into of- and plat- based methods. The idle variable
> > here is used as a container of the initial state for both of the paths in
> > case of idle-channel isn't specified.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/i2c/muxes/i2c-mux-gpio.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> > index a14fe132b0c3..535c83c43371 100644
> > --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> > +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> > @@ -171,7 +171,6 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >  	struct gpiomux *mux;
> >  	struct i2c_adapter *parent;
> >  	struct i2c_adapter *root;
> > -	unsigned initial_state;
> >  	int i, ret;
> >  
> >  	mux = devm_kzalloc(&pdev->dev, sizeof(*mux), GFP_KERNEL);
> > @@ -204,12 +203,14 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >  
> >  	muxc->mux_locked = true;
> >  
> > -	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE) {
> > -		initial_state = mux->data.idle;
> > +	/*
> > +	 * Set descelect callback if idle state has been setup otherwise just
> > +	 * use the idle variable to store the initial muxer value.
> > +	 */
> > +	if (mux->data.idle != I2C_MUX_GPIO_NO_IDLE)
> >  		muxc->deselect = i2c_mux_gpio_deselect;
> > -	} else {
> > -		initial_state = mux->data.values[0];
> > -	}
> > +	else
> > +		mux->data.idle = mux->data.values[0];
> >  
> >  	for (i = 0; i < mux->data.n_gpios; i++) {
> >  		struct device *gpio_dev;
> > @@ -224,7 +225,7 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >  		}
> >  
> >  		ret = gpio_direction_output(mux->gpio_base + mux->data.gpios[i],
> > -					    initial_state & (1 << i));
> > +					    mux->data.idle & (1 << i));
> >  		if (ret) {
> >  			dev_err(&pdev->dev,
> >  				"Failed to set direction of GPIO %d to output\n",
> > 
> 
