From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/5] i2c: designware: Refactoring of the
 i2c-designware
Date: Wed, 07 Dec 2016 20:58:56 +0200
Message-ID: <1481137136.30772.8.camel@linux.intel.com>
References: <cover.1481131072.git.lolivei@synopsys.com>
         <486c43e4c57116fa955ab99cea7f484ee8a2bdf3.1481131072.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:44812 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbcLGS7M (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 7 Dec 2016 13:59:12 -0500
In-Reply-To: <486c43e4c57116fa955ab99cea7f484ee8a2bdf3.1481131072.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Wed, 2016-12-07 at 17:55 +0000, Luis Oliveira wrote:
> - Factor out all _master() part of code from i2c-designware-core
>   and i2c-designware-platdrv to separate functions.
> - Standardize all code related with MASTER modes.
> 

Couple of comments, after addressing them
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> +	if ((dev->master_cfg & DW_IC_CON_MASTER) &&
> +		 (dev->master_cfg & DW_IC_CON_SLAVE_DISABLE))
> +		i2c_dw_configure_fifo_master(dev);

So, logically it's a part of slave patch.
For now it would be just 
 i2c_dw_configure_fifo_master(dev);

> +static irqreturn_t i2c_dw_isr(int this_irq, void *dev_id)
> +{
> +	struct dw_i2c_dev *dev = dev_id;
> +	u32 stat, enabled, mode;

mode is unused here, this is a part of slave patch either.

> +static void i2c_dw_configure_master(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);

> +	dev_info(&pdev->dev, "I am registed as a I2C Master!\n");

I don't want bikeshedding here, but the question just comes:
"Do we need to have this available via sysfs as a part of ABI?" So. user
space can check for / set a mode.

In any case this one is a separate story and another patch, here just to
make the message less annoying, it looks like dev_dbg() to me.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
