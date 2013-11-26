From: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH] I2C: BCM2835: Linking platform nodes to adapter nodes
Date: Tue, 26 Nov 2013 13:05:53 +0000
Message-ID: <20131126130553.GF25130@opensource.wolfsonmicro.com>
References: <527CB3A1.7050808@koalo.de> <527D1870.8080302@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <527D1870.8080302-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Florian Meier <florian.meier-oZ8rN/sblLk@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 08, 2013 at 09:59:28AM -0700, Stephen Warren wrote:
> On 11/08/2013 02:49 AM, Florian Meier wrote:
> > In order to find I2C devices in the device tree, the platform nodes
> > have to be known by the I2C core. Analogous to the i2c-omap driver
> > this requires setting the dev.of_node parameter of the adapter.
> 
> (CCing the I2C maintainers...)
> 
> > diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
> 
> > @@ -299,6 +299,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
> >  	strlcpy(adap->name, "bcm2835 I2C adapter", sizeof(adap->name));
> >  	adap->algo = &bcm2835_i2c_algo;
> >  	adap->dev.parent = &pdev->dev;
> > +	adap->dev.of_node = pdev->dev.of_node;
> 
> Ah, that makes sense. Thinking about it now, I'd only ever used i2cget
> etc. to access I2C devices, rather than instantiating drivers from DT.
> 
> That all said, I wonder if the I2C core shouldn't do something like the
> following inside i2c_add_adapter():
> 
> if (!adap->dev.of_node && adap->dev.parent)
> 	adap->dev.of_node = adap->dev.parent->of_node;

Should this not also have an of_node_get to increment the ref
count on the node?

Thanks,
Charles
