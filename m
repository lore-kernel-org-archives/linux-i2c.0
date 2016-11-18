From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] i2c: designware: Add slave definitions
Date: Fri, 18 Nov 2016 11:01:55 -0600
Message-ID: <20161118170155.chrdpguohgl6vo5f@rob-hp-laptop>
References: <cover.1479410047.git.lolivei@synopsys.com>
 <f1bf9ca52e47cdd79b8f0d5e0c159a8727857269.1479410047.git.lolivei@synopsys.com>
 <1479472552.22212.23.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479472552.22212.23.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Nov 18, 2016 at 02:35:52PM +0200, Andy Shevchenko wrote:
> On Fri, 2016-11-18 at 11:19 +0000, Luis Oliveira wrote:
> >  - Add slave defintitions to i2c-designware-core
> >  - Changes in Kconfig to auto-enable I2C_SLAVE when compiling the
> > modules
> >  - Add compatible string to designware-core.txt explaining the
> > devicetree bindings
> > 
> 
> 
> > --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> > @@ -2,7 +2,9 @@
> >  
> >  Required properties :
> >  
> > - - compatible : should be "snps,designware-i2c"
> > + - compatible : should be:
> > +   - "snps,designware-i2c" to setup the hardware block as I2C master.
> > +   - "snps,designware-i2c-slave" to setup the hardware block as I2C
> > slave.
> 
> Not sure about this one.
> 
> Compatible string is more generic than list of modes. Basically you have
> to add a property which selects mode.

Yes, agreed. And come up with a common property.

> DT people's ACK is a must for this change.
> 
> 
> --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -470,6 +470,7 @@ config I2C_DESIGNWARE_CORE
> >  config I2C_DESIGNWARE_PLATFORM
> >  	tristate "Synopsys DesignWare Platform"
> >  	select I2C_DESIGNWARE_CORE
> > +	select I2C_SLAVE
> > 
> 
> Common rule, generic dependencies usually go first
> 
> 	select I2C_SLAVE
>  	select I2C_DESIGNWARE_CORE
> 
> -- 
> Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
