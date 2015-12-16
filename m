From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] i2c: designware: Do not require clock when SSCN and FFCN
 are provided
Date: Wed, 16 Dec 2015 16:28:10 +0200
Message-ID: <20151216142810.GW1762@lahna.fi.intel.com>
References: <1450219138-5868-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <20151216094202.GR1762@lahna.fi.intel.com>
 <56717100.3020602@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56717100.3020602@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Cc: wsa@the-dreams.de, lho@apm.com, Ken.Xue@amd.com, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Dec 16, 2015 at 08:11:12AM -0600, Suravee Suthikulpanit wrote:
> >The clk framework should work fine if the returned clock is NULL (which
> >I think is your case).
> >
> >The driver gates clocks when the device is suspended and on Intel LPSS
> >there actually is a clock that gets gated.
> >
> >>[..]
> >>@@ -203,13 +223,11 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
> >>  		dev->master_cfg =  DW_IC_CON_MASTER | DW_IC_CON_SLAVE_DISABLE |
> >>  			DW_IC_CON_RESTART_EN | DW_IC_CON_SPEED_FAST;
> >>
> >>-	dev->clk = devm_clk_get(&pdev->dev, NULL);
> >>-	dev->get_clk_rate_khz = i2c_dw_get_clk_rate_khz;
> >>-	if (IS_ERR(dev->clk))
> >>-		return PTR_ERR(dev->clk);
> 
> Actually, if we don't provide the clock (which is the case for ACPI), this
> would also return and cause the probing to fail.

Indeed it seems that when you have CONFIG_COMMON_CLK selected the clock
framework starts returning errors if the clock is not found.

Since we need the clock for Intel LPSS I2C host controllers (and they
may have *CNT methods), I think you just need to provide the clock for
AMD I2C host controller in similar way than we do in
drivers/acpi/acpi_lpss.c.
