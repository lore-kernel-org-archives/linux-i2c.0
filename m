From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 3/4] Device bindings documentation updated
 ACPI-enabled platforms not currently supported
Date: Fri, 21 Oct 2016 13:54:32 +0300
Message-ID: <1477047272.6423.6.camel@linux.intel.com>
References: <cover.1476462204.git.lolivei@synopsys.com>
         <36f4b1736e36b039af15b13645df0de492f1b6e1.1476462204.git.lolivei@synopsys.com>
         <20161014173014.GA26269@leverpostej> <20161014182045.GA1509@katana>
         <55cc91af-8d24-8aea-f74f-2ef40cd8ea5a@synopsys.com>
         <20161018151706.GA1433@katana>
         <76ab13e9-9aa5-97c3-2328-928bbcef9877@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <76ab13e9-9aa5-97c3-2328-928bbcef9877-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Ramiro Oliveira <Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, 2016-10-21 at 10:56 +0100, Luis Oliveira wrote:
> Since practically 90% of the code is shared between master and slave,
> I was
> thinking if it will be acceptable to use the same driver for both but
> differentiate the master/slave mode by the compatible strings.

It might be possible to split like other drivers do:

1. Core part (i2c-designware-core.c)
2. Master part (i2c-designware-master.c)
3. Slave part (i2c-designware-slave.c)
4. Glue drivers (like: i2c-designware-platdrv.c)

> 
> Thanks,
> Luis
> 
> On 10/18/2016 16:17, Wolfram Sang wrote:
> > > This is needed because the configuration is different and the i2c-
> > > designware
> > > cannot be master/slave without a reset. To resolve that I added
> > > this property
> > > to bind it as a slave when needed.
> > 
> > Aww, pity that the HW can't do that. Do you have details why?
> > 
> > If that is really a HW limitation, then I'd suggest having a
> > seperate
> > driver for slave-only mode so we can differentiate by compatible
> > strings.
> > 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
