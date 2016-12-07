From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 5/5] i2c: designware: Cleaning comments and
 formatation
Date: Wed, 07 Dec 2016 21:52:35 +0200
Message-ID: <1481140355.30772.17.camel@linux.intel.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
         <02856fdb6ce3230a4ac1ba0958938ad51e763205.1481131072.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6056 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932677AbcLGTyK (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 7 Dec 2016 14:54:10 -0500
In-Reply-To: <02856fdb6ce3230a4ac1ba0958938ad51e763205.1481131072.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Wed, 2016-12-07 at 17:55 +0000, Luis Oliveira wrote:
> - Missspelling, comment formatation and fix a string of
>   the existing code
> 

Good, but after addressing below comments:
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> --- a/drivers/i2c/busses/i2c-designware-slave.c
> +++ b/drivers/i2c/busses/i2c-designware-slave.c
> @@ -70,8 +70,8 @@ int i2c_dw_init_slave(struct dw_i2c_dev *dev)
>  		/* Configure register access mode 16bit */
>  		dev->accessor_flags |= ACCESS_16BIT;
>  	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
> -		dev_err(dev->dev, "Unknown Synopsys component type: "
> -			"0x%08x\n", reg);
> +		dev_err(dev->dev,
> +		 "Unknown Synopsys component type: 0x%08x\n", reg);

Keep indentation like 

some_call(param, param2, ...
	  paramX, paramY, ...);

It applies to all your new code you bring by this series.


> @@ -181,8 +181,10 @@ int i2c_dw_reg_slave(struct i2c_client *slave)
>  		return -EBUSY;
>  	if (slave->flags & I2C_CLIENT_TEN)
>  		return -EAFNOSUPPORT;
> -		/* set slave address in the IC_SAR register,
> -		* the address to which the DW_apb_i2c responds */
> +		/*
> +		 * set slave address in the IC_SAR register,
> +		 * the address to which the DW_apb_i2c responds

Again, Capital letter here, dot at the end of sentence. You may fix (if
you want to) the rest of comment lines in entire driver.

> +		 */
>  
>  	__i2c_dw_enable(dev, false);
>  	dw_writel(dev, slave->addr, DW_IC_SAR);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
