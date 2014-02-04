From: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/6] mfd: add bcm59056 pmu driver
Date: Tue, 4 Feb 2014 10:01:56 -0500
Message-ID: <20140204150156.GC4627@beef>
References: <1391516352-32359-1-git-send-email-mporter@linaro.org>
 <1391516352-32359-4-git-send-email-mporter@linaro.org>
 <20140204132951.GE13529@lee--X1>
 <20140204143119.GA4627@beef>
 <20140204144731.GA3154@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140204144731.GA3154@lee--X1>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christian Daudt <bcm-xK7y4jjYLqYh9ZMKESR00Q@public.gmane.org>, Devicetree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux I2C List <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Feb 04, 2014 at 02:47:31PM +0000, Lee Jones wrote:
> Hold your horses. :)

Holding :)

> > > > Add a driver for the BCM59056 PMU multi-function device. The driver
> > > > initially supports regmap initialization and instantiation of the
> > > > voltage regulator device function of the PMU.
> > > > 
> > > > Signed-off-by: Matt Porter <mporter-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > Reviewed-by: Tim Kryger <tim.kryger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > Reviewed-by: Markus Mayer <markus.mayer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > ---
> > > >  drivers/mfd/Kconfig          |   8 +++
> > > >  drivers/mfd/Makefile         |   1 +
> > > >  drivers/mfd/bcm59056.c       | 119 +++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/mfd/bcm59056.h |  35 +++++++++++++
> > > >  4 files changed, 163 insertions(+)
> > > >  create mode 100644 drivers/mfd/bcm59056.c
> > > >  create mode 100644 include/linux/mfd/bcm59056.h
> 
> <snip>
> 
> > > I thought this was a DT only driver? If so, you probably want to use
> > > of_match_device() instead.
> > 
> > Correct, I'll use of_match_device()
> 
> If you're going to use this ...
> 
> <snip>
> 
> > > You've gone to the trouble of setting a device version here, but you
> > > don't seem to use it?
> > 
> > I'll drop the device version
> 
> ... then you'll still need this.

Yes, I was far too vague..I'm going to stop explicitly populating the
data field.

static const struct of_device_id bcm59056_of_match[] = {
	{ .compatible = "brcm,bcm59056"},
	{ }
};

> > > > +static const struct i2c_device_id bcm59056_i2c_id[] = {
> > > > +	{ "bcm59056", BCM59056 },
> > > > +	{ }
> > > > +};
> > > 
> > > Ah, I guess this is where id->driver comes from.
> > > 
> > > It's pretty silly that the I2C subsystem demands the presence of this
> > > table, despite not using it if an of_device_id table is present.
> > 
> > It does make it very difficult to follow DT enabled I2C client drivers
> > :( I'll drop the BCM59056 too.
> 
> And I don't think you can drop this, as the I2C subsystem still
> insists on it.

Agreed. I'm just dropping explicit population of the driver_data field
here.

static const struct i2c_device_id bcm59056_i2c_id[] = {
	{ "bcm59056" },
	{ }
};

> 
> > > > +/* chip id */
> > > > +#define BCM59056		0
> > > 
> > > Lonely, oh so lonely!
> > 
> > Understood. Will remove.
> 
> I think you need to keep this to supply the silly I2C ID table.
> 
> I would just omit the '.data = (void *) VERSION' from the
> of_match_table until you require it. 

Well, it's not even necessary for I2C ID table. the I2C subsystem is
happy with just a matching entry on the i2c_device_id name field and
NULL driver_data. palmas is implemented in this manner.

-Matt
