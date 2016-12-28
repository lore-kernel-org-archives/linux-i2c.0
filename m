From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 6/7] i2c: designware: enable SLAVE in platform module
Date: Wed, 28 Dec 2016 19:10:43 +0200
Message-ID: <1482945043.9552.174.camel@linux.intel.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
         <ea8b611c3b7c2af8088e2dbc16554af5c8aed368.1482934380.git.lolivei@synopsys.com>
         <1482939844.9552.165.camel@linux.intel.com>
         <20e47113-efd7-787c-b2f8-39e9fd8b83d2@synopsys.com>
         <1482942696.9552.172.camel@linux.intel.com>
         <c41db9e0-756d-6697-a845-0d5b1efcaedc@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:28518 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750976AbcL1RPX (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Dec 2016 12:15:23 -0500
In-Reply-To: <c41db9e0-756d-6697-a845-0d5b1efcaedc@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Wed, 2016-12-28 at 16:41 +0000, Luis Oliveira wrote:
> On 28-Dec-16 16:31, Andy Shevchenko wrote:
> > On Wed, 2016-12-28 at 15:53 +0000, Luis Oliveira wrote:
> > > On 28-Dec-16 15:44, Andy Shevchenko wrote:
> > > > On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
> > > > > - Slave mode selected in platform module (devicetree support
> > > > > only)
> > > > > - Check for ACPI - not supported in SLAVE mode:
> > > > >   - Changed the ifndef style to the use of ACPI_HANDLE that
> > > > > returns
> > > > > NULL
> > > > >     if the device was not enumerated from ACPI namespace.
> > > > 
> > > > I'm not sure what is wrong with ACPI?
> > > 
> > > I dont have a way to test it. Just that.
> > 
> > Okay, can you provide an excerpt to see how it will look like in
> > DTS?
> 
> Yes, it looks like this now:
> 
> 	i2c@0x2000 {
> 			compatible = "snps,designware-i2c";
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			reg = <0x2000 0x100>;
> 			clock-frequency = <400000>;
> 			clocks = <&i2cclk>;
> 			interrupts = <0>;
> 
> 			eeprom@64 {
> 				compatible = "linux,slave-24c02";
> 				reg = <0x40000064>;
> 			};
> 	};

+1 to Carlos' comment.

> >  
> > > > > -	dev->functionality = I2C_FUNC_10BIT_ADDR |
> > > > > DW_IC_DEFAULT_FUNCTIONALITY;
> > > > > -
> > > > > -	i2c_dw_configure_master(pdev);
> > > > > +	if (ACPI_HANDLE(&pdev->dev) == NULL) {
> > > > 
> > > > I don't think you need this at all.
> > > 
> > > This is to avoid the use of the "ifdef" style I used before.
> > 
> > My point is to drop it completely.
> > 
> > > > 
> > > > > +		device_for_each_child_node(&pdev->dev, child)
> > > > > {
> > > > 
> > > > This is resource agnostic.
> > > > 
> > > > > +			fwnode_property_read_u32(child,
> > > > > "reg",
> > > > > &reg);
> > > > 
> > > > This is as well.
> > > 
> > > Are you suggesting I use of_ functions?
> > 
> > Nope. See above.

So, ACPI has a property to support slave mode for I2CSerialBus() macro.

I would propose to create a helper function in i2c-core.c which will be
responsible for mode detection

... i2c_slave_mode_detect()
{
...
 if (IS_BUILTIN(CONFIG_OF) && dev->of_node) {
  ... (use of_*() here) ...
 } else if (IS_BUILTIN(CONFIG_ACPI) && ACPI_HANDLE(dev))
  dev_dbg(..., "ACPI slave is not supported yet\n");
  ... to master ...
 } else {
  ... default to master ...
 }
}
EXPORT_...();

Make it as a separate patch.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
