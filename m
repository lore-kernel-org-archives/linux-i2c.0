From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 6/7] i2c: designware: enable SLAVE in platform module
Date: Wed, 28 Dec 2016 17:44:04 +0200
Message-ID: <1482939844.9552.165.camel@linux.intel.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
         <ea8b611c3b7c2af8088e2dbc16554af5c8aed368.1482934380.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22612 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbcL1PrK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Dec 2016 10:47:10 -0500
In-Reply-To: <ea8b611c3b7c2af8088e2dbc16554af5c8aed368.1482934380.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
> - Slave mode selected in platform module (devicetree support only)
> - Check for ACPI - not supported in SLAVE mode:
>   - Changed the ifndef style to the use of ACPI_HANDLE that returns
> NULL
>     if the device was not enumerated from ACPI namespace.

I'm not sure what is wrong with ACPI?
 
> @@ -264,9 +297,16 @@ static int dw_i2c_plat_probe(struct
> platform_device *pdev)
>  	if (r)
>  		return r;
>  
> -	dev->functionality = I2C_FUNC_10BIT_ADDR |
> DW_IC_DEFAULT_FUNCTIONALITY;
> -
> -	i2c_dw_configure_master(pdev);

> +	if (ACPI_HANDLE(&pdev->dev) == NULL) {

I don't think you need this at all.

> +		device_for_each_child_node(&pdev->dev, child) {

This is resource agnostic.

> +			fwnode_property_read_u32(child, "reg", &reg);

This is as well.

> +			if (reg & I2C_OWN_SLAVE_ADDRESS)
> +				i2c_dw_configure_slave(pdev);
> +			else
> +				i2c_dw_configure_master(pdev);
> +		}
> +	} else
> +		i2c_dw_configure_master(pdev);


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
