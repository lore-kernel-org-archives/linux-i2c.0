From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
Date: Fri, 21 Apr 2017 16:41:04 +0200
Message-ID: <1492785664.2364.13.camel@pengutronix.de>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
         <1492101794-13444-4-git-send-email-peda@axentia.se>
         <1492784582.2364.10.camel@pengutronix.de>
         <9e3d48c4-0dbc-3e80-c653-b0357abf1d6f@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e3d48c4-0dbc-3e80-c653-b0357abf1d6f-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Fri, 2017-04-21 at 16:32 +0200, Peter Rosin wrote:
> On 2017-04-21 16:23, Philipp Zabel wrote:
> > On Thu, 2017-04-13 at 18:43 +0200, Peter Rosin wrote:
> > [...]
> >> +int mux_chip_register(struct mux_chip *mux_chip)
> >> +{
> >> +	int i;
> >> +	int ret;
> >> +
> >> +	for (i = 0; i < mux_chip->controllers; ++i) {
> >> +		struct mux_control *mux = &mux_chip->mux[i];
> >> +
> >> +		if (mux->idle_state == mux->cached_state)
> >> +			continue;
> > 
> > I think this should be changed to
> >  
> > -               if (mux->idle_state == mux->cached_state)
> > +               if (mux->idle_state == mux->cached_state ||
> > +                   mux->idle_state == MUX_IDLE_AS_IS)
> >                         continue;
> > 
> > or the following mux_control_set will be called with state ==
> > MUX_IDLE_AS_IS. Alternatively, mux_control_set should return when passed
> > this value.
> 
> That cannot happen because ->cached_state is initialized to -1
> in mux_chip_alloc, so should always be == MUX_IDLE_AS_IS when
> registering. And drivers are not supposed to touch ->cached_state.
> I.e., ->cached_state is "owned" by the core.

So this was caused by me filling cached_state from register reads in the
mmio driver. Makes me wonder why I am not allowed to do this, though, if
I am able to read back the initial state?

regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
