From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
Date: Tue, 17 Jul 2018 18:16:10 +0300
Message-ID: <1886510d2a828d3a246ef1f490c6819f073fbdcb.camel@linux.intel.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-4-alexandre.belloni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717114837.21839-4-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, James Hogan <jhogan@kernel.org>
Cc: Paul Burton <paul.burton@mips.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Allan Nielsen <allan.nielsen@microsemi.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.

Thanks for information you provided. See my comments below.

>  struct dw_i2c_dev {
>  	struct device		*dev;
>  	void __iomem		*base;
> +	void __iomem		*base_ext;

Maybe simple "ext"? Up to you.
 
> +#define MSCC_ICPU_CFG_TWI_DELAY		0x0
> +#define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
> +#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
> +
> +static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
> +{
> +	writel((dev->sda_hold_time << 1) |
> MSCC_ICPU_CFG_TWI_DELAY_ENABLE,
> +	       dev->base_ext + MSCC_ICPU_CFG_TWI_DELAY);
> +
> +	return 0;
> +}

(1)

>  
> +	if (of_device_is_compatible(pdev->dev.of_node, "mscc,ocelot-
> i2c")) {
> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +		dev->base_ext = devm_ioremap_resource(&pdev->dev,
> mem);
> +		if (!IS_ERR(dev->base_ext))
> +			dev->set_sda_hold_time =
> mscc_twi_set_sda_hold_time;
> +	}

(2)

>  static const struct of_device_id dw_i2c_of_match[] = {
>  	{ .compatible = "snps,designware-i2c", },
> +	{ .compatible = "mscc,ocelot-i2c", },
>  	{},
>  };

(3)


I would rather place them in analogue how we do for ACPI, i.e.

--- 8< --- 8< ---

...
#define MODEL_MSCC_OCELOT  0x00000200
#define MODEL_MASK         0x00000f00
...

#ifdef CONFIG_OF
-->(1)
int dw_i2c_of_configure(pdev)
{
...
-->(2) (perhaps we don't care if it goes without condition, or move it
below in the corresponding case?
...

 switch(dev->flags & MODEL_MASK) {
  case MODEL_MSCC_OCELOT:
   ...
   break;
  default:
   break;
 }

 return 0;
}

-->(3)
...
{ .compatible = "mscc,ocelot-i2c", .data = (void *)MODEL_MSCC_OCELOT },
...

#else
static inline int dw_i2c_of_configure(pdev) { return -ENODEV; }
#endif

...

->probe():

...

/* REPLACE THIS in dw_i2c_acpi_configure() by below in ->probe():
 * id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev-
>dev);
 * if (id && id->driver_data)
 *   dev->flags |= (u32)id->driver_data;
 */

  dev->flags |= (u32)device_get_match_data(&pdev->dev);

  if (&pdev->dev.of_node)
    dw_i2c_of_configure(pdev);

...

--- 8< --- 8< ---

What do you think?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
