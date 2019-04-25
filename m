From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data found
Date: Thu, 25 Apr 2019 23:09:49 +0300
Message-ID: <20190425200948.bj5h7svga727havo@mobilestation>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-3-fancer.lancer@gmail.com>
 <4e7c9184-03a2-f1d3-2ed0-a761d76b9654@axentia.se>
 <20190425154736.emjumxqimzgvzrla@mobilestation>
 <3366ab5c-ced5-cfe1-c93e-d50ce795c2aa@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3366ab5c-ced5-cfe1-c93e-d50ce795c2aa@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Peter Korsgaard <peter.korsgaard@barco.com>, Serge Semin <Sergey.Semin@t-platforms.ru>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Thu, Apr 25, 2019 at 07:28:52PM +0000, Peter Rosin wrote:
> On 2019-04-25 17:47, Serge Semin wrote:
> > On Wed, Apr 24, 2019 at 09:25:50PM +0000, Peter Rosin wrote:
> >> On 2019-04-24 14:34, Serge Semin wrote:
> >>> It's pointless and might be even errors prone to proceed with further
> >>> initialization if neither of- no platform-based settings were discovered.
> >>> Just return an error in this case.
> >>>
> >>> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >>> ---
> >>>  drivers/i2c/muxes/i2c-mux-gpio.c | 12 +++++++-----
> >>>  1 file changed, 7 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
> >>> index 24cf6ec02e75..a14fe132b0c3 100644
> >>> --- a/drivers/i2c/muxes/i2c-mux-gpio.c
> >>> +++ b/drivers/i2c/muxes/i2c-mux-gpio.c
> >>> @@ -132,7 +132,7 @@ static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
> >>>  static int i2c_mux_gpio_probe_dt(struct gpiomux *mux,
> >>>  					struct platform_device *pdev)
> >>>  {
> >>> -	return 0;
> >>> +	return -EINVAL;
> >>>  }
> >>>  #endif
> >>>  
> >>> @@ -142,6 +142,9 @@ static int i2c_mux_gpio_probe_plat(struct gpiomux *mux,
> >>>  	struct i2c_mux_gpio_platform_data *data = dev_get_platdata(&pdev->dev);
> >>>  	struct gpio_chip *gpio;
> >>>  
> >>> +	if (!data)
> >>> +		return -EINVAL;
> >>> +
> >>>  	/*
> >>>  	 * If a GPIO chip name is provided, the GPIO pin numbers provided are
> >>>  	 * relative to its base GPIO number. Otherwise they are absolute.
> >>> @@ -175,11 +178,10 @@ static int i2c_mux_gpio_probe(struct platform_device *pdev)
> >>>  	if (!mux)
> >>>  		return -ENOMEM;
> >>>  
> >>> -	if (!dev_get_platdata(&pdev->dev))
> >>> +	ret = i2c_mux_gpio_probe_plat(mux, pdev);
> >>> +	if (ret)
> >>>  		ret = i2c_mux_gpio_probe_dt(mux, pdev);
> >>> -	else
> >>> -		ret = i2c_mux_gpio_probe_plat(mux, pdev);
> >>> -	if (ret < 0)
> >>> +	if (ret)
> >>>  		return ret;
> >>
> >> I notice that after this patch, all probe failures from non-dt configs
> >> will return -EINVAL from the dummy i2c_mux_gpio_probe_dt that gets
> >> called on i2c_mux_gpio_probe_plat failure.
> >>
> >> So, any -EPROBE_DEFER is now lost. That probably doesn't fly.
> >>
> > 
> > So what do you suggest then?
> 
> I don't know, I'm just pointing out that you are breaking probe-defer.
> 
> >                              We can return to something like:
> > if (dev_get_platdata(&pdev->dev))
> >     ret = i2c_mux_gpio_probe_plat(mux, pdev);
> > else
> >     ret = i2c_mux_gpio_probe_dt(mux, pdev);
> > 
> > In this case there is no falling back to dt. Just either plat- or of-based
> > initialization. The same can be done for i2c_mux_gpio_request_*() methods.
> 
> Works for me, I fail to see why it is interesting with a fallback
> anyway? If you supply platform data, that is supposed to take
> precedence. No?
> 
> If the platform data fails, I'd rather not have the code run into the
> weeds attempting stuff that's not even supposed to work...
> 

Yeah, you are right. Adding fallback pattern here was a bad idea.
I'll fix it in the next patchset version.

-Sergey

> Cheers,
> Peter
> 
> > -Sergey
> > 
> >> Cheers,
> >> Peter
> >>
> >>>  
> >>>  	parent = i2c_get_adapter(mux->data.parent);
> >>>
> >>
> 
