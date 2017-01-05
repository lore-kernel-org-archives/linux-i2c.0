From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 6/7] i2c: designware: enable SLAVE in platform module
Date: Thu, 05 Jan 2017 14:43:46 +0200
Message-ID: <1483620226.9552.237.camel@linux.intel.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
         <ea8b611c3b7c2af8088e2dbc16554af5c8aed368.1482934380.git.lolivei@synopsys.com>
         <1482939844.9552.165.camel@linux.intel.com>
         <20e47113-efd7-787c-b2f8-39e9fd8b83d2@synopsys.com>
         <1482942696.9552.172.camel@linux.intel.com>
         <c41db9e0-756d-6697-a845-0d5b1efcaedc@synopsys.com>
         <1482945043.9552.174.camel@linux.intel.com>
         <b27405b9-b768-34e7-d61a-433100f9856d@synopsys.com>
         <9747bb4d-9a52-789d-32e9-ddbef9e129e4@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5493 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032018AbdAEMnv (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Thu, 5 Jan 2017 07:43:51 -0500
In-Reply-To: <9747bb4d-9a52-789d-32e9-ddbef9e129e4@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Thu, 2017-01-05 at 12:13 +0000, Luis Oliveira wrote:
> On 28-Dec-16 18:10, Luis Oliveira wrote:
> > On 28-Dec-16 17:10, Andy Shevchenko wrote:
> > > On Wed, 2016-12-28 at 16:41 +0000, Luis Oliveira wrote:
> > > > On 28-Dec-16 16:31, Andy Shevchenko wrote:


> > > So, ACPI has a property to support slave mode for I2CSerialBus()
> > > macro.
> > > 
> > > I would propose to create a helper function in i2c-core.c which
> > > will be
> > > responsible for mode detection
> > > 
> > > ... i2c_slave_mode_detect()
> > > {
> > > ...
> > >  if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
> > >   ... (use of_*() here) ...
> > >  } else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev))
> > >   dev_dbg(..., "ACPI slave is not supported yet\n");
> > >   ... to master ...
> > >  } else {
> > >   ... default to master ...
> > >  }
> > > }
> > > EXPORT_...();
> > > 
> > > Make it as a separate patch.
> > > 
> > 
> > Oh I see, yes it looks good. I will check it. Thanks
> > 
> 
> Hi Andy,
> 
> I implemented a helper function as you proposed and it looks like
> this:
> 
> int i2c_slave_mode_detect(struct device *dev)
> {
> 	struct device_node *child;
> 	u32 reg;
> 	
> 	if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
> 		for_each_child_of_node(dev->of_node, child) {
> 			of_property_read_u32(child, "reg", &reg);
> 			if (reg & I2C_OWN_SLAVE_ADDRESS)
> 				return 1;
> 		}
> 	} else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev))
> 		dev_dbg(dev, "ACPI slave is not supported yet\n");

Curly braces here as well.

> 	else
> 		return 0;

For now this is not needed

> 	return 0;
> }
> 
> Before I submit the patch to the i2c-core.c I wonder if I could have
> some
> comment on the implementation.

Glad you did it. See above. Otherwise looks good to me.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
