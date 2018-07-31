From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/6] i2c: designware: use generic table matching
Date: Tue, 31 Jul 2018 17:23:04 +0300
Message-ID: <0559c93256ae4f59aed278912bcbfd996e279839.camel@linux.intel.com>
References: <20180731134740.441-1-alexandre.belloni@bootlin.com>
         <20180731134740.441-2-alexandre.belloni@bootlin.com>
         <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44e52856371e4b5c102df8f2efebd527fd26b066.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-31 at 17:02 +0300, Andy Shevchenko wrote:
> On Tue, 2018-07-31 at 15:47 +0200, Alexandre Belloni wrote:
> > Switch to device_get_match_data in probe to match the device
> > specific
> > data
> > instead of using the acpi specific function.
> > 
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Oops. See below.

> > -	id = acpi_match_device(pdev->dev.driver->acpi_match_table,
> > &pdev->dev);
> > -	if (id && id->driver_data)
> > -		dev->flags |= (u32)id->driver_data;

It seems you forgot to remove unused variable.

> > -
> >  	if (acpi_bus_get_device(handle, &adev))
> >  		return -ENODEV;
> >  
> > @@ -269,6 +265,8 @@ static int dw_i2c_plat_probe(struct
> > platform_device *pdev)
> >  	else
> >  		i2c_parse_fw_timings(&pdev->dev, t, false);
> >  
> > +	dev->flags |= (u32)device_get_match_data(&pdev->dev);
> > +

And since it would be changed anyway, can you actually move this line
closet to  if (has_acpi_companion()) one ?

> >  	acpi_speed = i2c_acpi_find_bus_speed(&pdev->dev);
> >  	/*
> >  	 * Some DSTDs use a non standard speed, round down to the
> > lowest
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
