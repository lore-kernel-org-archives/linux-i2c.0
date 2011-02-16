From: Guenter Roeck <guenter.roeck-IzeFyvvaP7pWk0Htik3J/w@public.gmane.org>
Subject: Re: Using the gpio i2c multiplexer driver
Date: Wed, 16 Feb 2011 06:29:45 -0800
Message-ID: <20110216142945.GB13872@ericsson.com>
References: <1297810054.24938.218.camel@groeck-laptop>
 <4D5B77AE.20307@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4D5B77AE.20307-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Lawnick <ml.lawnick-Mmb7MZpHnFY@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 16, 2011 at 02:07:26AM -0500, Michael Lawnick wrote:
> Guenter Roeck said the following:
> > Hi all,
> > 
> > I am trying to use the new GPIO based I2C multiplexer. Unfortunately, I
> > have an initialization problem with it.
> > 
> > Some time after registering the multiplexer as platform driver, its
> > probe function is called. Unfortunately, that does not happen in sync
> > with I2C adapter initialization. The GPIO mux probe function is called
> > before the parent's (ie the multiplexed I2C adapter) probe function is
> > called. As a result, the GPIO mux driver does not find its parent i2c
> > adapter, and the probe function aborts with an error.
> > 
> > Any idea how I I can fix the problem, ie how I can ensure that the GPIO
> > mux probe function is only called after its parent I2C adapter is
> > initialized ?
> > 
> Well, I assume your GPIO-Mux is registered as an GPIO device? Can't you
> add it as an I2C-device? This way the right sequence should be kept.
> 
It is registered as a platform device. I thought about registering it as 
I2C device, but it is not an I2C device itself, so that would be a bit kludgy.

Thanks,
Guenter
