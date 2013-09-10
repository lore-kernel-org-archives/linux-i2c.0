From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH RESEND 1/2] i2c: prepare runtime PM support for I2C client devices
Date: Tue, 10 Sep 2013 13:38:14 +0200
Message-ID: <1713872.SpMsCYYTas@vostro.rjw.lan>
References: <1378733679-19500-1-git-send-email-mika.westerberg@linux.intel.com> <20130909154028.GP29403@sirena.org.uk> <20130910075100.GK7393@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130910075100.GK7393-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Aaron Lu <aaron.lu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tuesday, September 10, 2013 10:51:00 AM Mika Westerberg wrote:
> On Mon, Sep 09, 2013 at 04:40:28PM +0100, Mark Brown wrote:
> > On Mon, Sep 09, 2013 at 04:34:38PM +0300, Mika Westerberg wrote:
> > 
> > > +	/*
> > > +	 * Enable runtime PM for the client device. If the client wants to
> > > +	 * participate on runtime PM it should call pm_runtime_put() in its
> > > +	 * probe() callback.
> > > +	 *
> > > +	 * User still needs to allow the PM runtime before it can actually
> > > +	 * happen.
> > > +	 */
> > > +	pm_runtime_forbid(&client->dev);
> > > +	pm_runtime_get_noresume(&client->dev);
> > > +	pm_runtime_set_active(&client->dev);
> > > +	pm_runtime_enable(&client->dev);
> > 
> > How is this going to interact with client devices which are already
> > enabling runtime PM for themselves, and what are the advantages of doing
> > this over having the client device enable runtime PM for itself (given
> > that the client still needs an explicit put() adding)?
> 
> My understanding is that you can call pm_runtime_enable() several times
> (provided that pm_runtime_disable() is called as many times). So that
> should have no effect on the current drivers that already take advantage of
> runtime PM.

That's correct.

> There is one difference though -- runtime PM is now blocked by default and
> it needs to be unblocked from the userspace per each device.
> 
> For the advantages compared to each driver handling it completely
> themselves:
> 
> 	- Few lines less as you only need to call _put().
> 	- It follows what is already been done for other buses, like PCI
> 	  and AMBA .
> 	- The I2C core makes sure that the device is available (from bus
> 	  point of view) when the driver ->probe() is called.
> 
> > Given that it's relatively common for devices to have both I2C and SPI
> > control it seems like it'd be sensible to keep the policy common between
> > the two buses to simplify driver implementation.
> 
> Yes and IMHO if I2C and SPI follows what has already been done for other
> buses it should make the driver writer's job easier as the usage is similar
> from one bus to another.

I agree here, FWIW.

Thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
