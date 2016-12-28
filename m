From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v5 6/7] i2c: designware: enable SLAVE in platform module
Date: Wed, 28 Dec 2016 18:31:36 +0200
Message-ID: <1482942696.9552.172.camel@linux.intel.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
         <ea8b611c3b7c2af8088e2dbc16554af5c8aed368.1482934380.git.lolivei@synopsys.com>
         <1482939844.9552.165.camel@linux.intel.com>
         <20e47113-efd7-787c-b2f8-39e9fd8b83d2@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20e47113-efd7-787c-b2f8-39e9fd8b83d2-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Luis Oliveira <Luis.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ramiro.Oliveira-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 2016-12-28 at 15:53 +0000, Luis Oliveira wrote:
> On 28-Dec-16 15:44, Andy Shevchenko wrote:
> > On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
> > > - Slave mode selected in platform module (devicetree support only)
> > > - Check for ACPI - not supported in SLAVE mode:
> > >   - Changed the ifndef style to the use of ACPI_HANDLE that
> > > returns
> > > NULL
> > >     if the device was not enumerated from ACPI namespace.
> > 
> > I'm not sure what is wrong with ACPI?
> 
> I dont have a way to test it. Just that.

Okay, can you provide an excerpt to see how it will look like in DTS?

 
> > > -	dev->functionality = I2C_FUNC_10BIT_ADDR |
> > > DW_IC_DEFAULT_FUNCTIONALITY;
> > > -
> > > -	i2c_dw_configure_master(pdev);
> > > +	if (ACPI_HANDLE(&pdev->dev) == NULL) {
> > 
> > I don't think you need this at all.
> 
> This is to avoid the use of the "ifdef" style I used before.

My point is to drop it completely.

> > 
> > > +		device_for_each_child_node(&pdev->dev, child) {
> > 
> > This is resource agnostic.
> > 
> > > +			fwnode_property_read_u32(child, "reg",
> > > &reg);
> > 
> > This is as well.
> 
> Are you suggesting I use of_ functions?

Nope. See above.


-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
