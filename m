From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 2/7] i2c: designware: refactoring of the
 i2c-designware
Date: Wed, 28 Dec 2016 17:12:48 +0200
Message-ID: <1482937968.9552.159.camel@linux.intel.com>
References: <cover.1482934380.git.lolivei@synopsys.com>
         <0dbbce3bb2ffd47d5a78ea49f992b48d7ea2f35d.1482934380.git.lolivei@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38292 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbcL1PMy (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Wed, 28 Dec 2016 10:12:54 -0500
In-Reply-To: <0dbbce3bb2ffd47d5a78ea49f992b48d7ea2f35d.1482934380.git.lolivei@synopsys.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Luis Oliveira <Luis.Oliveira@synopsys.com>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, jarkko.nikula@linux.intel.com, mika.westerberg@linux.intel.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ramiro.Oliveira@synopsys.com, Joao.Pinto@synopsys.com, CARLOS.PALMINHA@synopsys.com

On Wed, 2016-12-28 at 14:43 +0000, Luis Oliveira wrote:
> - Factor out all _master() part of code from i2c-designware-core
>   and i2c-designware-platdrv to separate functions.
> - Standardize all code related with MASTER mode.
> - I have to take off DW_IC_INTR_TX_EMPTY from DW_IC_INTR_DEFAULT_MASK
>   because it is master specific.
> 
> The purpose of this is to prepare the controller to have is I2C MASTER
> flow in a separate driver. To do this first all the
> functions/definitions related to the MASTER flow were identified.

Thanks for an update.
Some style related comments below (For the code related is up to you, my
tag still stands).

> 
> Signed-off-by: Luis Oliveira <lolivei@synopsys.com>
> ---
> Changes V4->V5: (ACK by Andy)

When you get an Ack, or other tag (Reviewed-by, Tested-by, etc), and you
send new version, include this tag to your commit message (it applies to
all affected patches in your series).

It would be also good to have some high level changelog in the cover
letter, from this series I don't see, for example, which base you did
use (i2c-next? linux-next? v4.9? v4.10-rc1?).

> +       dev_dbg(dev->dev,
> +               "%s: enabled=%#x stat=%#x\n", __func__, enabled,
stat);

I hope you can fit format string on the first line. __func__ is
redundant when you are using debug printing (Dynamic Debug would include
it if asked for).

> +static void i2c_dw_configure_master(struct platform_device *pdev)
> +{
> +	struct dw_i2c_dev *dev = platform_get_drvdata(pdev);

By the way, does it make sense to pass struct dw_i2c_dev * as a
parameter of the function?

> +
> +	dev->master_cfg = DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE
> |
> +			  DW_IC_CON_RESTART_EN;
> +
> +	dev_dbg(&pdev->dev, "I am registed as a I2C Master!\n");
> +
> +	switch (dev->clk_freq) {
> +	case 100000:
> +		dev->master_cfg |= DW_IC_CON_SPEED_STD;
> +		break;
> +	case 3400000:
> +		dev->master_cfg |= DW_IC_CON_SPEED_HIGH;
> +		break;
> +	default:
> +		dev->master_cfg |= DW_IC_CON_SPEED_FAST;
> +	}
> +}
> +
> 


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
